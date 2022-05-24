//
//  MKNBHSwitchStatePageModel.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/21.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHSwitchStatePageModel.h"

#import "MKMacroDefines.h"

#import "MKNBHDeviceModeManager.h"

#import "MKNBHMQTTServerManager.h"
#import "MKNBHMQTTInterface.h"
#import "MKNBHMQTTInterface+MKNBHConfig.h"

@interface MKNBHSwitchStatePageModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKNBHSwitchStatePageModel

- (void)dealloc {
    NSLog(@"MKNBHSwitchStatePageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //返回设备列表页面需要销毁单例
    [[MKNBHDeviceModeManager shared] clearDeviceModel];
}

#pragma mark - notes

- (void)receiveDeviceStateChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_id"]) || ![user[@"device_id"] isEqualToString:[MKNBHDeviceModeManager shared].deviceID]) {
        return;
    }
    moko_dispatch_main_safe(^{
        if (self.switchStateChangedBlock) {
            self.switchStateChangedBlock(user[@"data"]);
        }
    });
}

- (void)receiveCountdownData:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_id"]) || ![user[@"device_id"] isEqualToString:[MKNBHDeviceModeManager shared].deviceID]) {
        return;
    }
    moko_dispatch_main_safe(^{
        if (self.receiveCountdownDataBlock) {
            self.receiveCountdownDataBlock(user[@"data"]);
        }
    });
}

- (void)receiveDeviceLoadChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_id"]) || ![user[@"device_id"] isEqualToString:[MKNBHDeviceModeManager shared].deviceID]) {
        return;
    }
    BOOL load = [user[@"data"][@"load"] boolValue];
    moko_dispatch_main_safe(^{
        if (self.receiveLoadStatusChangedBlock) {
            self.receiveLoadStatusChangedBlock(load);
        }
    });
}

- (void)deviceOverload:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_id"]) || ![user[@"device_id"] isEqualToString:[MKNBHDeviceModeManager shared].deviceID]) {
        return;
    }
    BOOL overload = [user[@"data"][@"over"] boolValue];
    moko_dispatch_main_safe(^{
        if (self.receiveOverloadBlock) {
            self.receiveOverloadBlock(overload);
        }
    });
}

- (void)deviceOvercurrent:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_id"]) || ![user[@"device_id"] isEqualToString:[MKNBHDeviceModeManager shared].deviceID]) {
        return;
    }
    BOOL overcurrent = [user[@"data"][@"over"] boolValue];
    moko_dispatch_main_safe(^{
        if (self.receiveOvercurrentBlock) {
            self.receiveOvercurrentBlock(overcurrent);
        }
    });
}

- (void)deviceOvervoltage:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_id"]) || ![user[@"device_id"] isEqualToString:[MKNBHDeviceModeManager shared].deviceID]) {
        return;
    }
    BOOL overvoltage = [user[@"data"][@"over"] boolValue];
    moko_dispatch_main_safe(^{
        if (self.receiveOvervoltageBlock) {
            self.receiveOvervoltageBlock(overvoltage);
        }
    });
}

- (void)deviceUndervoltage:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_id"]) || ![user[@"device_id"] isEqualToString:[MKNBHDeviceModeManager shared].deviceID]) {
        return;
    }
    BOOL undervoltage = [user[@"data"][@"over"] boolValue];
    moko_dispatch_main_safe(^{
        if (self.receiveUndervoltageBlock) {
            self.receiveUndervoltageBlock(undervoltage);
        }
    });
}

#pragma mark - public method

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readSwitchState]) {
            [self operationFailedBlockWithMsg:@"Read Switch State Timeout" block:failedBlock];
            return;
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDeviceStateChanged:)
                                                     name:MKNBHReceivedSwitchStateNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveCountdownData:)
                                                     name:MKNBHReceivedCountdownNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDeviceLoadChanged:)
                                                     name:MKNBHDeviceLoadStatusChangedNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOverload:)
                                                     name:MKNBHReceiveOverloadNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOvercurrent:)
                                                     name:MKNBHReceiveOverCurrentNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOvervoltage:)
                                                     name:MKNBHReceiveOvervoltageNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceUndervoltage:)
                                                     name:MKNBHReceiveUndervoltageNotification
                                                   object:nil];
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configSwitchStatus:(BOOL)isOn
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_configSwitchStatus:isOn
                                      deviceID:[MKNBHDeviceModeManager shared].deviceID
                                    macAddress:[MKNBHDeviceModeManager shared].macAddress
                                         topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                      sucBlock:sucBlock
                                   failedBlock:failedBlock];
}

- (void)configCountdown:(NSInteger)second
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_configCountdown:second
                                   deviceID:[MKNBHDeviceModeManager shared].deviceID
                                 macAddress:[MKNBHDeviceModeManager shared].macAddress
                                      topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                   sucBlock:sucBlock
                                failedBlock:failedBlock];
}

- (void)clearOverloadWithSucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_clearOverloadStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID
                                                 macAddress:[MKNBHDeviceModeManager shared].macAddress
                                                      topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                                   sucBlock:sucBlock
                                                failedBlock:failedBlock];
}

- (void)clearOvercurrentWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_clearOvercurrentStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID
                                                    macAddress:[MKNBHDeviceModeManager shared].macAddress
                                                         topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                                      sucBlock:sucBlock
                                                   failedBlock:failedBlock];
}

- (void)clearOvervoltageWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_clearOvervoltageStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID
                                                    macAddress:[MKNBHDeviceModeManager shared].macAddress
                                                         topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                                      sucBlock:sucBlock
                                                   failedBlock:failedBlock];
}

- (void)clearUndervoltageWithSucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [MKNBHMQTTInterface nbh_clearUndervoltageStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID
                                                     macAddress:[MKNBHDeviceModeManager shared].macAddress
                                                          topic:[MKNBHDeviceModeManager shared].subscribedTopic
                                                       sucBlock:sucBlock
                                                    failedBlock:failedBlock];
}

#pragma mark - interface
- (BOOL)readSwitchState {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readSwitchStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"data"][@"switch_state"] boolValue];
        self.overload = [returnData[@"data"][@"overload_state"] boolValue];
        self.overcurrent = [returnData[@"data"][@"overcurrent_state"] boolValue];
        self.overvoltage = [returnData[@"data"][@"overvoltage_state"] boolValue];
        self.undervoltage = [returnData[@"data"][@"undervoltage_state"] boolValue];
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
        NSError *error = [[NSError alloc] initWithDomain:@"switchStateParams"
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
        _readQueue = dispatch_queue_create("switchStateQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
