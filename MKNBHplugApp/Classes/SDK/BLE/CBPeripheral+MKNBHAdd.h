//
//  CBPeripheral+MKNBHAdd.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKNBHAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_deviceModel;

@property (nonatomic, strong, readonly)CBCharacteristic *nbh_macAddress;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_notify;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_paramConfig;

/// W
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_debugConfig;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *nbh_log;

- (void)nbh_updateCharacterWithService:(CBService *)service;

- (void)nbh_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)nbh_connectSuccess;

- (void)nbh_setNil;

@end

NS_ASSUME_NONNULL_END
