//
//  MKNBHDeviceModeManager.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHDeviceModeManager.h"

#import "MKMacroDefines.h"

static MKNBHDeviceModeManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKNBHDeviceModeManager ()

@property (nonatomic, strong)id <MKNBHDeviceModeManagerDataProtocol>protocol;

@end

@implementation MKNBHDeviceModeManager

+ (MKNBHDeviceModeManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKNBHDeviceModeManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    manager = nil;
    onceToken = 0;
}

#pragma mark - public method
/// 当前设备的deviceID
- (NSString *)deviceID {
    if (!self.protocol) {
        return @"";
    }
    return SafeStr(self.protocol.deviceID);
}

/// 当前设备的mac地址
- (NSString *)macAddress {
    if (!self.protocol) {
        return @"";
    }
    return SafeStr(self.protocol.macAddress);
}

/// 当前设备的订阅主题
- (NSString *)subscribedTopic {
    if (!self.protocol) {
        return @"";
    }
    return [self.protocol currentSubscribedTopic];
}

- (NSString *)deviceName {
    if (!self.protocol) {
        return @"";
    }
    return self.protocol.deviceName;
}

- (void)addDeviceModel:(id <MKNBHDeviceModeManagerDataProtocol>)protocol {
    self.protocol = nil;
    self.protocol = protocol;
}

- (void)clearDeviceModel {
    if (self.protocol) {
        self.protocol = nil;
    }
}

- (void)updateDeviceName:(NSString *)deviceName {
    if (!ValidStr(deviceName)) {
        return;
    }
    self.protocol.deviceName = SafeStr(deviceName);
}

@end
