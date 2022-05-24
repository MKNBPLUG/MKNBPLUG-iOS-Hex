//
//  MKNBHMQTTSettingInfoModel.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/25.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHMQTTSettingInfoModel.h"

#import "MKMacroDefines.h"

#import "MKNBHDeviceModeManager.h"

#import "MKNBHMQTTInterface.h"

@interface MKNBHMQTTSettingInfoModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKNBHMQTTSettingInfoModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        /*
        if (![self readSSLStatus]) {
            [self operationFailedBlockWithMsg:@"Read MQTT SSL Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTHost]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Host Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTPort]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Port Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTClientID]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Client ID Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTUsername]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Username Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTPassword]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Password Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTCleanSession]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Clean Session Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTQos]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Qos Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTKeepAlive]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Keep Alive Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTPublishTopic]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Publish Topic Timeout" block:failedBlock];
            return;
        }
        if (![self readMQTTSubscribeTopic]) {
            [self operationFailedBlockWithMsg:@"Read MQTT Subscribe Topic Timeout" block:failedBlock];
            return;
        }
        if (![self readLWTStatus]) {
            [self operationFailedBlockWithMsg:@"Read MQTT LWT Status Error" Timeout:failedBlock];
            return;
        }
        if (![self readLWTRetain]) {
            [self operationFailedBlockWithMsg:@"Read MQTT LWT Retain Timeout" block:failedBlock];
            return;
        }
        if (![self readLWTQos]) {
            [self operationFailedBlockWithMsg:@"Read MQTT LWT Qos Timeout" block:failedBlock];
            return;
        }
        if (![self readLWTTopic]) {
            [self operationFailedBlockWithMsg:@"Read MQTT LWT Topic Timeout" block:failedBlock];
            return;
        }
        if (![self readLWTPayload]) {
            [self operationFailedBlockWithMsg:@"Read MQTT LWT Payload Timeout" block:failedBlock];
            return;
        }*/
        if (![self readDeviceMQTTInfo]) {
            [self operationFailedBlockWithMsg:@"Read Device MQTT Info Timeout" block:failedBlock];
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
- (BOOL)readDeviceMQTTInfo {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readDeviceMQTTServerInfoWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.type = ([returnData[@"data"][@"sslType"] integerValue] == 0 ? @"TCP" : @"SSL");
        self.host = returnData[@"data"][@"host"];
        self.port = returnData[@"data"][@"port"];
        self.clientID = returnData[@"data"][@"clientID"];
        self.userName = returnData[@"data"][@"username"];
        self.password = returnData[@"data"][@"password"];
        self.cleanSession = ([returnData[@"data"][@"cleanSession"] boolValue] ? @"1" : @"0");
        self.qos = returnData[@"data"][@"qos"];
        self.keepAlive = returnData[@"data"][@"keepAlive"];
        self.lwt = ([returnData[@"data"][@"lwt"] boolValue] ? @"1" : @"0");
        self.lwtRetain = ([returnData[@"data"][@"lwtRetain"] boolValue] ? @"1" : @"0");
        self.lwtQos = returnData[@"data"][@"lwtQos"];
        self.lwtTopic = returnData[@"data"][@"lwtTopic"];
        self.lwtPayload = returnData[@"data"][@"payload"];
        self.deviceID = returnData[@"device_id"];
        self.publishedTopic = returnData[@"data"][@"publishedTopic"];
        self.subscribedTopic = returnData[@"data"][@"subscribedTopic"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSSLStatus {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTSSLStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.type = ([returnData[@"data"][@"sslType"] integerValue] == 0 ? @"TCP" : @"SSL");
        self.deviceID = returnData[@"device_id"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTHost {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTHostWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.host = returnData[@"data"][@"host"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTPort {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTPortWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.port = returnData[@"data"][@"port"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTClientID {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTCilentIDWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.clientID = returnData[@"data"][@"clientID"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTUsername {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTUsernameWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.userName = returnData[@"data"][@"username"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTPassword {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTPasswordWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.password = returnData[@"data"][@"password"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTCleanSession {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTCleanSessionWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.cleanSession = ([returnData[@"data"][@"isOn"] boolValue] ? @"YES" : @"NO");
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTQos {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTQosWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.qos = returnData[@"data"][@"qos"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTKeepAlive {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTKeepAliveWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.keepAlive = returnData[@"data"][@"keepAlive"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTPublishTopic {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTPublishTopicWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.publishedTopic = returnData[@"data"][@"topic"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMQTTSubscribeTopic {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTSubscribeTopicWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.subscribedTopic = returnData[@"data"][@"topic"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLWTStatus {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTLWTStatusWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lwt = ([returnData[@"data"][@"isOn"] boolValue] ? @"1" : @"0");
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLWTRetain {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTLWTRetainWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lwtRetain = ([returnData[@"data"][@"isOn"] boolValue] ? @"1" : @"0");
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLWTQos {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTLWTQosWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lwtQos = returnData[@"data"][@"qos"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLWTTopic {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTLWTTopicWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lwtTopic = returnData[@"data"][@"topic"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLWTPayload {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_readMQTTLWTPayloadWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lwtPayload = returnData[@"data"][@"payload"];
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
        NSError *error = [[NSError alloc] initWithDomain:@"mqttServerParams"
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
        _readQueue = dispatch_queue_create("mqttServerQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
