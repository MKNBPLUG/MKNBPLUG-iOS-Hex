//
//  CBPeripheral+MKNBHAdd.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKNBHAdd.h"

#import <objc/runtime.h>

static const char *nbh_manufacturerKey = "nbh_manufacturerKey";
static const char *nbh_macAddressKey = "nbh_macAddressKey";
static const char *nbh_deviceModelKey = "nbh_deviceModelKey";
static const char *nbh_hardwareKey = "nbh_hardwareKey";
static const char *nbh_softwareKey = "nbh_softwareKey";
static const char *nbh_firmwareKey = "nbh_firmwareKey";

static const char *nbh_passwordKey = "nbh_passwordKey";
static const char *nbh_notifyKey = "nbh_notifyKey";
static const char *nbh_paramConfigKey = "nbh_paramConfigKey";
static const char *nbh_debugConfigKey = "nbh_debugConfigKey";
static const char *nbh_logKey = "nbh_logKey";

static const char *nbh_passwordNotifySuccessKey = "nbh_passwordNotifySuccessKey";
static const char *nbh_notifyNotifySuccessKey = "nbh_notifyNotifySuccessKey";
static const char *nbh_paramConfigNotifySuccessKey = "nbh_paramConfigNotifySuccessKey";
static const char *nbh_debugConfigNotifySuccessKey = "nbh_debugConfigNotifySuccessKey";

@implementation CBPeripheral (MKNBHAdd)

- (void)nbh_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &nbh_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A25"]]) {
                objc_setAssociatedObject(self, &nbh_macAddressKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &nbh_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &nbh_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &nbh_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &nbh_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &nbh_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &nbh_notifyKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &nbh_paramConfigKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
                objc_setAssociatedObject(self, &nbh_debugConfigKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
                objc_setAssociatedObject(self, &nbh_logKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)nbh_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &nbh_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &nbh_notifyNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &nbh_paramConfigNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
        objc_setAssociatedObject(self, &nbh_debugConfigNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)nbh_connectSuccess {
    if (![objc_getAssociatedObject(self, &nbh_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &nbh_notifyNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &nbh_paramConfigNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &nbh_debugConfigNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.nbh_manufacturer || !self.nbh_macAddress || !self.nbh_deviceModel || !self.nbh_hardware || !self.nbh_software || !self.nbh_firmware) {
        return NO;
    }
    if (!self.nbh_password || !self.nbh_notify || !self.nbh_paramConfig || !self.nbh_debugConfig || !self.nbh_log) {
        return NO;
    }
    return YES;
}

- (void)nbh_setNil {
    objc_setAssociatedObject(self, &nbh_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_macAddressKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &nbh_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_notifyKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_paramConfigKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_debugConfigKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_logKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &nbh_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_notifyNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_paramConfigNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &nbh_debugConfigNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)nbh_manufacturer {
    return objc_getAssociatedObject(self, &nbh_manufacturerKey);
}

- (CBCharacteristic *)nbh_macAddress {
    return objc_getAssociatedObject(self, &nbh_macAddressKey);
}

- (CBCharacteristic *)nbh_deviceModel {
    return objc_getAssociatedObject(self, &nbh_deviceModelKey);
}

- (CBCharacteristic *)nbh_hardware {
    return objc_getAssociatedObject(self, &nbh_hardwareKey);
}

- (CBCharacteristic *)nbh_software {
    return objc_getAssociatedObject(self, &nbh_softwareKey);
}

- (CBCharacteristic *)nbh_firmware {
    return objc_getAssociatedObject(self, &nbh_firmwareKey);
}

- (CBCharacteristic *)nbh_password {
    return objc_getAssociatedObject(self, &nbh_passwordKey);
}

- (CBCharacteristic *)nbh_notify {
    return objc_getAssociatedObject(self, &nbh_notifyKey);
}

- (CBCharacteristic *)nbh_paramConfig {
    return objc_getAssociatedObject(self, &nbh_paramConfigKey);
}

- (CBCharacteristic *)nbh_debugConfig {
    return objc_getAssociatedObject(self, &nbh_debugConfigKey);
}

- (CBCharacteristic *)nbh_log {
    return objc_getAssociatedObject(self, &nbh_logKey);
}

@end
