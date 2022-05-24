//
//  MKNBHIndicatorSettingModel.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHIndicatorSettingModel.h"

#import "MKMacroDefines.h"

#import "MKNBHDeviceModeManager.h"

#import "MKNBHMQTTInterface.h"
#import "MKNBHMQTTInterface+MKNBHConfig.h"

@interface MKNBHIndicatorSettingModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKNBHIndicatorSettingModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readServerConnecting]) {
            [self operationFailedBlockWithMsg:@"Read Server Connecting Timeout" block:failedBlock];
            return;
        }
        if (![self readServerConnected]) {
            [self operationFailedBlockWithMsg:@"Read Server Connected Timeout" block:failedBlock];
            return;
        }
        if (![self readIndicatorStatus]) {
            [self operationFailedBlockWithMsg:@"Read Indicator Status Timeout" block:failedBlock];
            return;
        }
        if (![self readProtectionSignal]) {
            [self operationFailedBlockWithMsg:@"Read Protection Signal Timeout" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configServerConnecting:(BOOL)isOn
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_configServerConnectingIndicatorStatus:isOn
                                                         deviceID:[MKNBHDeviceModeManager shared].deviceID
                                                       macAddress:[MKNBHDeviceModeManager shared].macAddress
                                                            topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                                         sucBlock:sucBlock
                                                      failedBlock:failedBlock];
}

- (void)configIndicatorStatus:(BOOL)isOn
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_configIndicatorStatus:isOn
                                         deviceID:[MKNBHDeviceModeManager shared].deviceID
                                       macAddress:[MKNBHDeviceModeManager shared].macAddress
                                            topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                         sucBlock:sucBlock
                                      failedBlock:failedBlock];
}

- (void)configProtectionSignal:(BOOL)isOn
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_configIndicatorProtectionSignal:isOn
                                                   deviceID:[MKNBHDeviceModeManager shared].deviceID
                                                 macAddress:[MKNBHDeviceModeManager shared].macAddress
                                                      topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                                   sucBlock:sucBlock
                                                failedBlock:failedBlock];
}

- (void)configServerConnectedIndicatorStatus:(NSInteger)status
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_configServerConnectedIndicatorStatus:status
                                                        deviceID:[MKNBHDeviceModeManager shared].deviceID
                                                      macAddress:[MKNBHDeviceModeManager shared].macAddress
                                                           topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                                        sucBlock:sucBlock
                                                     failedBlock:failedBlock];
}

#pragma mark - interfae
- (BOOL)readServerConnecting {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readServerConnectingIndicatorStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.connecting = [returnData[@"data"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readServerConnected {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readServerConnectedIndicatorStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.connected = [returnData[@"data"][@"net_connected"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readIndicatorStatus {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readIndicatorStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.indicatorStatus = [returnData[@"data"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readProtectionSignal {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readIndicatorProtectionSignalWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.protectionSignal = [returnData[@"data"][@"isOn"] boolValue];
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
        NSError *error = [[NSError alloc] initWithDomain:@"loadNotesParams"
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
        _readQueue = dispatch_queue_create("loadNotesQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
