//
//  MKNBHEnergyModel.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/3/28.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHEnergyModel.h"

#import "MKMacroDefines.h"

#import "MKNBHDeviceModeManager.h"

#import "MKNBHMQTTServerManager.h"
#import "MKNBHMQTTInterface.h"
#import "MKNBHMQTTInterface+MKNBHConfig.h"

@interface MKNBHEnergyModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKNBHEnergyModel

- (NSString *)deviceName {
    return [MKNBHDeviceModeManager shared].deviceName;
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readHourlyDatas]) {
            [self operationFailedBlockWithMsg:@"Read Hourly Data Timeout" block:failedBlock];
            return;
        }
        if (![self readDailyDatas]) {
            [self operationFailedBlockWithMsg:@"Read Daily Data Timeout" block:failedBlock];
            return;
        }
        if (![self readTotalEnergy]) {
            [self operationFailedBlockWithMsg:@"Read Total Data Timeout" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)clearEnergyDatasWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_clearAllEnergyDatasWithdeviceID:[MKNBHDeviceModeManager shared].deviceID
                                                 macAddress:[MKNBHDeviceModeManager shared].macAddress
                                                      topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                                   sucBlock:sucBlock
                                                failedBlock:failedBlock];
}

#pragma mark - interface

- (BOOL)readHourlyDatas {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readHourlyEnergyDataWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.hourlyDic = returnData[@"data"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDailyDatas {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMonthlyEnergyDataWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.dailyDic = returnData[@"data"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTotalEnergy {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readTotalEnergyDataWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger totalValue = [returnData[@"data"][@"energy"] integerValue];
        self.totalEnergy = [NSString stringWithFormat:@"%.2f",(totalValue * 0.01)];
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
        NSError *error = [[NSError alloc] initWithDomain:@"EnergyPageParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
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
        _readQueue = dispatch_queue_create("EnergyPageQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
