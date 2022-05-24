//
//  MKNBHBasePageModel.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/28.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHBasePageModel.h"

#import "MKMacroDefines.h"

#import "MKNBHDeviceModeManager.h"

#import "MKNBHMQTTServerManager.h"

@implementation MKNBHBasePageModel

- (void)dealloc {
    NSLog(@"MKNBHBasePageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
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
    }
    return self;
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

@end
