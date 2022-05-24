//
//  MKNBHModifyServerModel.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2021/12/6.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHModifyServerModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKNBHDeviceModeManager.h"

#import "MKNBHMQTTServerManager.h"
#import "MKNBHMQTTInterface+MKNBHConfig.h"

static NSString *const defaultSubTopic = @"{device_name}/{device_id}/app_to_device";
static NSString *const defaultPubTopic = @"{device_name}/{device_id}/device_to_app";

@interface MKNBHModifyServerModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@property (nonatomic, copy)void (^sucBlock)(void);

@property (nonatomic, copy)void (^failedBlock)(NSError *error);

@end

@implementation MKNBHModifyServerModel

- (void)dealloc {
    NSLog(@"MKNBHModifyServerModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _subscribeTopic = defaultSubTopic;
        _publishTopic = defaultPubTopic;
        _cleanSession = YES;
        _keepAlive = @"60";
        _qos = 1;
        _lwtQos = 1;
        _lwtTopic = defaultSubTopic;
        _lwtPayload = @"Offline";
    }
    return self;
}

#pragma mark - notes
- (void)receiveDownMQTTServerComplete:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_id"]) || ![user[@"device_id"] isEqualToString:[MKNBHDeviceModeManager shared].deviceID]) {
        return;
    }
    NSInteger result = [user[@"data"][@"result"] integerValue];
    if (result != 1) {
        [self operationFailedBlockWithMsg:@"Update Failed" block:self.failedBlock];
        return;
    }
    [MKNBHMQTTInterface nbh_reconnectMQTTServerWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        if (self.sucBlock) {
            self.sucBlock();
        }
    } failedBlock:self.failedBlock];
}

#pragma mark - public method
- (void)updateServerWithSucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    self.sucBlock = nil;
    self.sucBlock = sucBlock;
    self.failedBlock = nil;
    self.failedBlock = failedBlock;
    dispatch_async(self.readQueue, ^{
        NSString *msg = [self checkParams];
        if (ValidStr(msg)) {
            [self operationFailedBlockWithMsg:msg block:failedBlock];
            return;
        }
        NSInteger status = [self readDeviceState];
        if (status == 999) {
            [self operationFailedBlockWithMsg:@"Fetch Current Device State Timeout" block:failedBlock];
            return;
        }
        if (status != 0) {
            [self operationFailedBlockWithMsg:@"Device is OTA, please wait" block:failedBlock];
            return;
        }
        if (![self configMQTTHost]) {
            [self operationFailedBlockWithMsg:@"Config MQTT Host Timeout" block:failedBlock];
            return;
        }
        if (![self configMQTTPort]) {
            [self operationFailedBlockWithMsg:@"Config MQTT Port Timeout" block:failedBlock];
            return;
        }
        if (![self configMQTTUsername]) {
            [self operationFailedBlockWithMsg:@"Config MQTT Username Timeout" block:failedBlock];
            return;
        }
        if (![self configMQTTPassword]) {
            [self operationFailedBlockWithMsg:@"Config MQTT Password Failed" block:failedBlock];
            return;
        }
        if (![self configMQTTClientID]) {
            [self operationFailedBlockWithMsg:@"Config MQTT Client ID Timeout" block:failedBlock];
            return;
        }
        if (![self configMQTTCleanSession]) {
            [self operationFailedBlockWithMsg:@"Config MQTT Clean Session Timeout" block:failedBlock];
            return;
        }
        if (![self configMQTTKeepAlive]) {
            [self operationFailedBlockWithMsg:@"Config MQTT Keep Alive Timeout" block:failedBlock];
            return;
        }
        if (![self configMQTTQos]) {
            [self operationFailedBlockWithMsg:@"Config MQTT Qos Timeout" block:failedBlock];
            return;
        }
        if (![self configSubTopic]) {
            [self operationFailedBlockWithMsg:@"Config MQTT SubTopic Timeout" block:failedBlock];
            return;
        }
        if (![self configPubTopic]) {
            [self operationFailedBlockWithMsg:@"Config MQTT PubTopic Timeout" block:failedBlock];
            return;
        }
        if (![self configLWTStatus]) {
            [self operationFailedBlockWithMsg:@"Config MQTT LWT Timeout" block:failedBlock];
            return;
        }
        if (self.lwtStatus) {
            if (![self configLWTQos]) {
                [self operationFailedBlockWithMsg:@"Config LWT Qos Timeout" block:failedBlock];
                return;
            }
            if (![self configLWTRetain]) {
                [self operationFailedBlockWithMsg:@"Config LWT Retain Timeout" block:failedBlock];
                return;
            }
            if (![self configLWTTopic]) {
                [self operationFailedBlockWithMsg:@"Config LWT Topic Timeout" block:failedBlock];
                return;
            }
            if (![self configLWTPayload]) {
                [self operationFailedBlockWithMsg:@"Config LWT Payload Timeout" block:failedBlock];
                return;
            }
        }
        if (![self configSSLStatus]) {
            [self operationFailedBlockWithMsg:@"Config SSL Status Timeout" block:failedBlock];
            return;
        }
        if (self.sslIsOn) {
            if (self.certificate == 0) {
                //单向认证
                if (![self configCertificate]) {
                    [self operationFailedBlockWithMsg:@"Config Certificate Timeout" block:failedBlock];
                    return;
                }
            }
            if (self.certificate == 1) {
                //双向认证
                if (![self configSelfSignedCertificates]) {
                    [self operationFailedBlockWithMsg:@"Config Self Signed Certificates Timeout" block:failedBlock];
                    return;
                }
            }
        }
        if (![self configAPN]) {
            [self operationFailedBlockWithMsg:@"Config APN Timeout" block:failedBlock];
            return;
        }
        if (![self configAPNUsername]) {
            [self operationFailedBlockWithMsg:@"Config APN Username Timeout" block:failedBlock];
            return;
        }
        if (![self configAPNPassword]) {
            [self operationFailedBlockWithMsg:@"Config APN Password Timeout" block:failedBlock];
            return;
        }
        if (![self configNetworkPriority]) {
            [self operationFailedBlockWithMsg:@"Config Network Priority Timeout" block:failedBlock];
            return;
        }
        
        if (![self configComplete]) {
            [self operationFailedBlockWithMsg:@"Config Data Timeout" block:failedBlock];
            return;
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDownMQTTServerComplete:)
                                                     name:MKNBHReceivedDownMQTTParamsDataCompleteNotification
                                                   object:nil];
    });
}

- (NSString *)currentSubscribeTopic {
    NSString *subTopic = @"";
    if ([self.subscribeTopic isEqualToString:defaultSubTopic]) {
        //用户使用默认的topic
        subTopic = [NSString stringWithFormat:@"%@/%@/%@",[MKNBHDeviceModeManager shared].deviceName,[MKNBHDeviceModeManager shared].deviceID,@"app_to_device"];
    }else {
        //用户修改了topic
        subTopic = self.subscribeTopic;
    }
    return subTopic;
}

- (NSString *)currentPublishTopic {
    NSString *pubTopic = @"";
    if ([self.publishTopic isEqualToString:defaultPubTopic]) {
        //用户使用默认的topic
        pubTopic = [NSString stringWithFormat:@"%@/%@/%@",[MKNBHDeviceModeManager shared].deviceName,[MKNBHDeviceModeManager shared].deviceID,@"device_to_app"];
    }else {
        //用户修改了topic
        pubTopic = self.publishTopic;
    }
    return pubTopic;
}

- (NSString *)currentLWTTopic {
    NSString *topic = @"";
    if ([self.lwtTopic isEqualToString:defaultSubTopic]) {
        //用户使用默认的topic
        topic = [NSString stringWithFormat:@"%@/%@/%@",[MKNBHDeviceModeManager shared].deviceName,[MKNBHDeviceModeManager shared].deviceID,@"device_to_app"];
    }else {
        //用户修改了topic
        topic = self.lwtTopic;
    }
    return topic;
}

- (NSString *)macAddress {
    return [MKNBHDeviceModeManager shared].macAddress;
}

#pragma mark - interval
- (NSInteger)readDeviceState {
    __block NSInteger status = 999;
    [MKNBHMQTTInterface nbh_readDeviceUpdateStateWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        status = [returnData[@"data"][@"status"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return status;
}

- (BOOL)configMQTTHost {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configMQTTHost:self.host deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMQTTPort {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configMQTTPort:[self.port integerValue] deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMQTTUsername {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configMQTTUsername:self.userName deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMQTTPassword {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configMQTTPassword:self.password deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMQTTClientID {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configMQTTClientID:self.clientID deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMQTTCleanSession {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configMQTTCleanSession:self.cleanSession deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMQTTKeepAlive {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configMQTTKeepAlive:[self.keepAlive integerValue] deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMQTTQos {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configMQTTQos:self.qos deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSubTopic {
    __block BOOL success = NO;
    NSString *topic = [self currentSubscribeTopic];
    [MKNBHMQTTInterface nbh_configMQTTSubscribeTopic:topic deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPubTopic {
    __block BOOL success = NO;
    NSString *topic = [self currentPublishTopic];
    [MKNBHMQTTInterface nbh_configMQTTPublishTopic:topic deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLWTStatus {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configLWTStatus:self.lwtStatus deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLWTQos {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configLWTQos:self.lwtQos deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLWTRetain {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configLWTRetain:self.lwtRetain deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLWTTopic {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configLWTTopic:[self currentLWTTopic] deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLWTPayload {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configLWTPayload:self.lwtPayload deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSSLStatus {
    __block BOOL success = NO;
    NSInteger status = 0;
    if (self.sslIsOn) {
        if (self.certificate == 0) {
            status = 1;
        }else if (self.certificate == 1) {
            status = 2;
        }
    }
    [MKNBHMQTTInterface nbh_configSSLStatus:status deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAPN {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configAPN:self.apn deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAPNUsername {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configAPNUsername:self.networkUsername deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAPNPassword {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configAPNPassword:self.networkPassword deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNetworkPriority {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configNetworkPriority:self.networkPriority deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCertificate {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configCertificate:self.sslHost port:[self.sslPort integerValue] filePath:self.caFilePath deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSelfSignedCertificates {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configSelfSignedCertificates:self.sslHost port:[self.sslPort integerValue] caFilePath:self.caFilePath clientKeyPath:self.clientKeyPath clientCertPath:self.clientCertPath deviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configComplete {
    __block BOOL success = NO;
    [MKNBHMQTTInterface nbh_configMQTTServerParamsCompleteWithDeviceID:[MKNBHDeviceModeManager shared].deviceID macAddress:[MKNBHDeviceModeManager shared].macAddress topic:[MKNBHDeviceModeManager shared].subscribedTopic sucBlock:^ {
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
        NSError *error = [[NSError alloc] initWithDomain:@"mqttServerParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (NSString *)checkParams {
    if (!ValidStr(self.host) || self.host.length > 64 || ![self.host isAsciiString]) {
        return @"Host error";
    }
    if (!ValidStr(self.port) || [self.port integerValue] < 1 || [self.port integerValue] > 65535) {
        return @"Port error";
    }
    if (!ValidStr(self.clientID) || self.clientID.length > 64 || ![self.clientID isAsciiString]) {
        return @"ClientID error";
    }
    if (!ValidStr(self.publishTopic) || self.publishTopic.length > 128 || ![self.publishTopic isAsciiString]) {
        return @"PublishTopic error";
    }
    if (!ValidStr(self.subscribeTopic) || self.subscribeTopic.length > 128 || ![self.subscribeTopic isAsciiString]) {
        return @"SubscribeTopic error";
    }
    if (self.qos < 0 || self.qos > 2) {
        return @"Qos error";
    }
    if (!ValidStr(self.keepAlive) || [self.keepAlive integerValue] < 10 || [self.keepAlive integerValue] > 120) {
        return @"KeepAlive error";
    }
    if (self.userName.length > 256 || (ValidStr(self.userName) && ![self.userName isAsciiString])) {
        return @"UserName error";
    }
    if (self.password.length > 256 || (ValidStr(self.password) && ![self.password isAsciiString])) {
        return @"Password error";
    }
    if (self.sslIsOn) {
        if (self.certificate < 0 || self.certificate > 1) {
            return @"Certificate error";
        }
        if (!ValidStr(self.sslHost) || self.sslHost.length > 64) {
            return @"SSL Host error";
        }
        if (!ValidStr(self.sslPort) || [self.sslPort integerValue] < 1 || [self.sslPort integerValue] > 65535) {
            return @"SSL Port error";
        }
        if (!ValidStr(self.caFilePath) || self.caFilePath.length > 100) {
            return @"CA File cannot be empty.";
        }
        if (self.certificate == 1 && (!ValidStr(self.clientKeyPath) || self.clientKeyPath.length > 100 || !ValidStr(self.clientCertPath) || self.clientCertPath.length > 100)) {
            return @"Client File cannot be empty.";
        }
    }
    if (self.lwtStatus) {
        if (self.lwtQos < 0 || self.lwtQos > 2) {
            return @"LWT Qos error";
        }
        if (!ValidStr(self.lwtTopic) || self.lwtTopic.length > 128 || ![self.lwtTopic isAsciiString]) {
            return @"LWT Topic error";
        }
        if (!ValidStr(self.lwtPayload) || self.lwtPayload.length > 128 || ![self.lwtPayload isAsciiString]) {
            return @"LWT Payload error";
        }
    }
    if (self.apn.length > 100 || (ValidStr(self.apn) && ![self.apn isAsciiString])) {
        return @"APN error";
    }
    if (self.networkUsername.length > 127 || (ValidStr(self.networkUsername) && ![self.networkUsername isAsciiString])) {
        return @"Network username error";
    }
    if (self.networkPassword.length > 127 || (ValidStr(self.networkPassword) && ![self.networkPassword isAsciiString])) {
        return @"Network password error";
    }
    if (self.networkPriority < 0 || self.networkPriority > 10) {
        return @"Network Priority error";
    }
    return @"";
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

