//
//  MKNBHElectricityModel.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/25.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHElectricityModel.h"

#import "MKMacroDefines.h"

#import "MKNBHDeviceModeManager.h"

#import "MKNBHMQTTServerManager.h"
#import "MKNBHMQTTInterface.h"

@interface MKNBHElectricityModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKNBHElectricityModel

- (void)dealloc {
    NSLog(@"MKNBHElectricityModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - note
- (void)receiveElectricityDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_id"]) || ![user[@"device_id"] isEqualToString:[MKNBHDeviceModeManager shared].deviceID]) {
        return;
    }
    [self updateElectricityDatas:user];
    moko_dispatch_main_safe(^{
        if (self.receiveElectricityBlock) {
            self.receiveElectricityBlock();
        }
    });
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readElectricityData]) {
            [self operationFailedBlockWithMsg:@"Read Params Timeout" block:failedBlock];
            return;
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveElectricityDatas:)
                                                     name:MKNBHReceivedElectricityDataNotification
                                                   object:nil];
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interfae
- (BOOL)readElectricityData {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readElectricityDataWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        [self updateElectricityDatas:returnData];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"electricityParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (void)updateElectricityDatas:(NSDictionary *)returnData {
    NSInteger voltageInt = [returnData[@"data"][@"voltage"] integerValue];
    self.voltage = [NSString stringWithFormat:@"%.1f",(voltageInt * 0.1)];
    
    NSInteger currentInt = [returnData[@"data"][@"current"] integerValue];
    self.current = [NSString stringWithFormat:@"%ld",(long)currentInt];
    
    NSInteger powerInt = [returnData[@"data"][@"power"] integerValue];
    self.power = [NSString stringWithFormat:@"%.1f",(powerInt * 0.1)];
    
    NSInteger factorInt = [returnData[@"data"][@"power_factor"] integerValue];
    self.factor = [NSString stringWithFormat:@"%.2f",(factorInt * 0.01)];
    
    NSInteger frequencyInt = [returnData[@"data"][@"frequency"] integerValue];
    self.frequency = [NSString stringWithFormat:@"%.2f",(frequencyInt * 0.01)];
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("electricityQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
