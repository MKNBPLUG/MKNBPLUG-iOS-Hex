//
//  MKNBHConnectSettingModel.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHConnectSettingModel.h"

#import "MKMacroDefines.h"

#import "MKNBHDeviceModeManager.h"

#import "MKNBHMQTTInterface.h"
#import "MKNBHMQTTInterface+MKNBHConfig.h"

@interface MKNBHConnectSettingModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKNBHConnectSettingModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readConnectTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Params Timeout" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Para Error" block:failedBlock];
            return;
        }
        if (![self configConnectTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Params Timeout" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interfae
- (BOOL)readConnectTimeout {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readConnectionTimeoutWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"data"][@"timeout"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configConnectTimeout {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configConnectionTimeout:[self.timeout integerValue] deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
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
        NSError *error = [[NSError alloc] initWithDomain:@"connectTimeoutParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 0 || [self.timeout integerValue] > 1440) {
        return NO;
    }
    return YES;
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
        _readQueue = dispatch_queue_create("connectTimeoutQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
