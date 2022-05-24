//
//  MKNBHMQTTInterface+MKNBHConfig.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHMQTTInterface+MKNBHConfig.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKNBHMQTTServerManager.h"
#import "MKNBHMQTTSDKAdopter.h"

@implementation MKNBHMQTTInterface (MKNBHConfig)

+ (void)nbh_configPowerOnSwitchStatus:(mk_nbh_switchStatus)status
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *statusValue = @"00";
    if (status == mk_nbh_switchStatusPowerOn) {
        statusValue = @"01";
    }else if (status == mk_nbh_switchStatusRevertLast) {
        statusValue = @"02";
    }
    NSString *commandString = [NSString stringWithFormat:@"ed0101%@%@%@",asciiIDString,@"0001",statusValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigPowerOnSwitchStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configSwitchReportInterval:(NSInteger)switchInterval
                     countdownInterval:(NSInteger)countdownInterval
                              deviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (switchInterval < 0 || switchInterval > 86400 || countdownInterval < 0 || countdownInterval > 86400) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *switchValue = [MKNBHMQTTSDKAdopter fetchHexValue:switchInterval byteLen:4];
    NSString *countdownValue = [MKNBHMQTTSDKAdopter fetchHexValue:countdownInterval byteLen:4];
    NSString *commandString = [NSString stringWithFormat:@"ed0102%@%@%@%@",asciiIDString,@"0008",switchValue,countdownValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigPeriodicalReportOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configPowerReportInterval:(NSInteger)interval
                      changeThreshold:(NSInteger)threshold
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 86400 || threshold < 0 || threshold > 100) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *intervalValue = [MKNBHMQTTSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *thresholdValue = [MKNBHMQTTSDKAdopter fetchHexValue:threshold byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0103%@%@%@%@",asciiIDString,@"0005",intervalValue,thresholdValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigPowerReportOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configEnergyReportInterval:(NSInteger)interval
                       storageInterval:(NSInteger)storageInterval
                       changeThreshold:(NSInteger)threshold
                              deviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 43200 || threshold < 1 || threshold > 100 || storageInterval < 1 || storageInterval > 60) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *storageIntervalValue = [MKNBHMQTTSDKAdopter fetchHexValue:storageInterval byteLen:1];
    NSString *thresholdValue = [MKNBHMQTTSDKAdopter fetchHexValue:threshold byteLen:1];
    NSString *reportIntervalValue = [MKNBHMQTTSDKAdopter fetchHexValue:interval byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0104%@%@%@%@%@",asciiIDString,@"0004",storageIntervalValue,thresholdValue,reportIntervalValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigEnergyReportOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configOverload:(BOOL)isOn
              productModel:(mk_nbh_productModel)productModel
             overThreshold:(NSInteger)overThreshold
             timeThreshold:(NSInteger)timeThreshold
                  deviceID:(NSString *)deviceID
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSInteger minValue = 10;
    NSInteger maxValue = 4416;
    if (productModel == mk_nbh_productModel_America) {
        //美规
        minValue = 10;
        maxValue = 2160;
    }else if (productModel == mk_nbh_productModel_UK) {
        //英规
        minValue = 10;
        maxValue = 3588;
    }
    if (overThreshold < minValue || overThreshold > maxValue || timeThreshold < 1 || timeThreshold > 30) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *status = (isOn ? @"01" : @"00");
    NSString *value = [MKNBHMQTTSDKAdopter fetchHexValue:overThreshold byteLen:2];
    NSString *timeValue = [MKNBHMQTTSDKAdopter fetchHexValue:timeThreshold byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0105%@%@%@%@%@",asciiIDString,@"0004",status,value,timeValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigOverloadOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configOvervoltage:(BOOL)isOn
                 productModel:(mk_nbh_productModel)productModel
                overThreshold:(NSInteger)overThreshold
                timeThreshold:(NSInteger)timeThreshold
                     deviceID:(NSString *)deviceID
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSInteger minValue = 231;
    NSInteger maxValue = 264;
    if (productModel == mk_nbh_productModel_America) {
        //美规
        minValue = 121;
        maxValue = 138;
    }
    if (overThreshold < minValue || overThreshold > maxValue || timeThreshold < 1 || timeThreshold > 30) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *status = (isOn ? @"01" : @"00");
    NSString *value = [MKNBHMQTTSDKAdopter fetchHexValue:overThreshold byteLen:2];
    NSString *timeValue = [MKNBHMQTTSDKAdopter fetchHexValue:timeThreshold byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0106%@%@%@%@%@",asciiIDString,@"0004",status,value,timeValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigOvervoltageOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configUndervoltage:(BOOL)isOn
                  productModel:(mk_nbh_productModel)productModel
                 overThreshold:(NSInteger)overThreshold
                 timeThreshold:(NSInteger)timeThreshold
                      deviceID:(NSString *)deviceID
                    macAddress:(NSString *)macAddress
                         topic:(NSString *)topic
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSInteger minValue = 196;
    NSInteger maxValue = 229;
    if (productModel == mk_nbh_productModel_America) {
        //美规
        minValue = 102;
        maxValue = 119;
    }
    if (overThreshold < minValue || overThreshold > maxValue || timeThreshold < 1 || timeThreshold > 30) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *status = (isOn ? @"01" : @"00");
    NSString *value = [MKNBHMQTTSDKAdopter fetchHexValue:overThreshold byteLen:1];
    NSString *timeValue = [MKNBHMQTTSDKAdopter fetchHexValue:timeThreshold byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0107%@%@%@%@%@",asciiIDString,@"0003",status,value,timeValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigUndervoltageOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configOvercurrent:(BOOL)isOn
                 productModel:(mk_nbh_productModel)productModel
                overThreshold:(NSInteger)overThreshold
                timeThreshold:(NSInteger)timeThreshold
                     deviceID:(NSString *)deviceID
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSInteger minValue = 1;
    NSInteger maxValue = 192;
    if (productModel == mk_nbh_productModel_America) {
        //美规
        minValue = 1;
        maxValue = 180;
    }else if (productModel == mk_nbh_productModel_UK) {
        //英规
        minValue = 1;
        maxValue = 156;
    }
    if (overThreshold < minValue || overThreshold > maxValue || timeThreshold < 1 || timeThreshold > 30) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *status = (isOn ? @"01" : @"00");
    NSString *value = [MKNBHMQTTSDKAdopter fetchHexValue:overThreshold byteLen:1];
    NSString *timeValue = [MKNBHMQTTSDKAdopter fetchHexValue:timeThreshold byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0108%@%@%@%@%@",asciiIDString,@"0003",status,value,timeValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigOvercurrentOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configPowerIndicatorColor:(mk_nbh_ledColorType)colorType
                        colorProtocol:(id <mk_nbh_ledColorConfigProtocol>)protocol
                         productModel:(mk_nbh_productModel)productModel
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (![self checkLEDColorParams:colorType colorProtocol:protocol productModel:productModel]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *type = [MKNBHMQTTSDKAdopter fetchHexValue:colorType byteLen:1];
    NSString *blue = [MKNBHMQTTSDKAdopter fetchHexValue:protocol.b_color byteLen:2];
    NSString *green = [MKNBHMQTTSDKAdopter fetchHexValue:protocol.g_color byteLen:2];
    NSString *yellow = [MKNBHMQTTSDKAdopter fetchHexValue:protocol.y_color byteLen:2];
    NSString *orange = [MKNBHMQTTSDKAdopter fetchHexValue:protocol.o_color byteLen:2];
    NSString *red = [MKNBHMQTTSDKAdopter fetchHexValue:protocol.r_color byteLen:2];
    NSString *purple = [MKNBHMQTTSDKAdopter fetchHexValue:protocol.p_color byteLen:2];
    NSString *colorString = [NSString stringWithFormat:@"%@%@%@%@%@%@",blue,green,yellow,orange,red,purple];

    NSString *commandString = [NSString stringWithFormat:@"ed0109%@%@%@%@",asciiIDString,@"000d",type,colorString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigPowerIndicatorColorOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configNTPServerStatus:(BOOL)isOn
                             host:(NSString *)host
                     syncInterval:(NSInteger)syncInterval
                         deviceID:(NSString *)deviceID
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (!host || ![host isKindOfClass:NSString.class] || host.length > 64) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (syncInterval < 1 || syncInterval > 720) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *status = (isOn ? @"01" : @"00");
    NSString *intervalValue = [MKNBHMQTTSDKAdopter fetchHexValue:syncInterval byteLen:2];
    NSString *hostString = [MKNBHMQTTSDKAdopter fetchAsciiCode:host];
    NSString *len = [MKNBHMQTTSDKAdopter fetchHexValue:(3 + host.length) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed010a%@%@%@%@%@",asciiIDString,len,status,intervalValue,hostString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigNTPServerParamsOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configDeviceTimeZone:(NSInteger)timeZone
                        deviceID:(NSString *)deviceID
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeZone < -24 || timeZone > 28) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *zoneString = [MKNBHMQTTSDKAdopter hexStringFromSignedNumber:timeZone];
    NSString *commandString = [NSString stringWithFormat:@"ed010b%@%@%@",asciiIDString,@"0001",zoneString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigDeviceTimeZoneOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configLoadNotificationSwitch:(BOOL)start
                                    stop:(BOOL)stop
                                deviceID:(NSString *)deviceID
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *startValue = (start ? @"01" : @"00");
    NSString *stopValue = (stop ? @"01" : @"00");
    NSString *commandString = [NSString stringWithFormat:@"ed010c%@%@%@%@",asciiIDString,@"0002",startValue,stopValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigLoadNotificationSwitchOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configServerConnectingIndicatorStatus:(BOOL)isOn
                                         deviceID:(NSString *)deviceID
                                       macAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *status = (isOn ? @"01" : @"00");
    NSString *commandString = [NSString stringWithFormat:@"ed010d%@%@%@",asciiIDString,@"0001",status];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigServerConnectingIndicatorStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configServerConnectedIndicatorStatus:(mk_nbh_indicatorBleConnectedStatus)status
                                        deviceID:(NSString *)deviceID
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *statusValue = @"00";
    if (status == mk_nbh_indicatorBleConnectedStatus_solidBlueForFiveSeconds) {
        statusValue = @"01";
    }else if (status == mk_nbh_indicatorBleConnectedStatus_solidBlue) {
        statusValue = @"02";
    }
    NSString *commandString = [NSString stringWithFormat:@"ed010e%@%@%@",asciiIDString,@"0001",statusValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigServerConnectedIndicatorStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configIndicatorStatus:(BOOL)isOn
                         deviceID:(NSString *)deviceID
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *status = (isOn ? @"01" : @"00");
    NSString *commandString = [NSString stringWithFormat:@"ed010f%@%@%@",asciiIDString,@"0001",status];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigIndicatorStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configIndicatorProtectionSignal:(BOOL)isOn
                                   deviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *status = (isOn ? @"01" : @"00");
    NSString *commandString = [NSString stringWithFormat:@"ed0110%@%@%@",asciiIDString,@"0001",status];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigIndicatorProtectionSignalOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configConnectionTimeout:(NSInteger)timeout
                           deviceID:(NSString *)deviceID
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeout < 0 || timeout > 1440) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *timeoutValue = [MKNBHMQTTSDKAdopter fetchHexValue:timeout byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0111%@%@%@",asciiIDString,@"0002",timeoutValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigConnectionTimeoutOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configSwitchByButtonStatus:(BOOL)isOn
                              deviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0112%@%@%@",asciiIDString,@"0001",(isOn ? @"01" : @"00")];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigSwitchByButtonStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_clearOverloadStatusWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0121%@%@",asciiIDString,@"0000"];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskClearOverloadStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_clearOvervoltageStatusWithDeviceID:(NSString *)deviceID
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0122%@%@",asciiIDString,@"0000"];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskClearOvervoltageStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_clearUndervoltageStatusWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0123%@%@",asciiIDString,@"0000"];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskClearUndervoltageStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_clearOvercurrentStatusWithDeviceID:(NSString *)deviceID
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0124%@%@",asciiIDString,@"0000"];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskClearOvercurrentStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configSwitchStatus:(BOOL)isOn
                      deviceID:(NSString *)deviceID
                    macAddress:(NSString *)macAddress
                         topic:(NSString *)topic
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0125%@%@%@",asciiIDString,@"0001",(isOn ? @"01" : @"00")];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigSwitchStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configCountdown:(NSInteger)second
                   deviceID:(NSString *)deviceID
                 macAddress:(NSString *)macAddress
                      topic:(NSString *)topic
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (second < 1 || second > 86400) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchHexValue:second byteLen:4];
    NSString *commandString = [NSString stringWithFormat:@"ed0127%@%@%@",asciiIDString,@"0004",valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigCountdownOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_clearAllEnergyDatasWithdeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0128%@%@",asciiIDString,@"0000"];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskClearAllEnergyDatasOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_resetDeviceWithdeviceID:(NSString *)deviceID
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0129%@%@",asciiIDString,@"0000"];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskResetDeviceOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_otaFirmware:(NSString *)host
                   port:(NSInteger)port
               filePath:(NSString *)filePath
               deviceID:(NSString *)deviceID
             macAddress:(NSString *)macAddress
                  topic:(NSString *)topic
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(host) || host.length > 64 || !ValidStr(filePath) || filePath.length > 100 || port < 1 || port > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *portValue = [MKNBHMQTTSDKAdopter fetchHexValue:port byteLen:2];
    NSString *hostValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:host];
    NSString *hostLen = [MKNBHMQTTSDKAdopter fetchHexValue:host.length byteLen:1];
    NSString *pathValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:filePath];
    NSString *pathLen = [MKNBHMQTTSDKAdopter fetchHexValue:filePath.length byteLen:1];
    NSString *totalLen = [MKNBHMQTTSDKAdopter fetchHexValue:(filePath.length + host.length + 4) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed012a%@%@%@%@%@%@%@",asciiIDString,totalLen,portValue,hostLen,hostValue,pathLen,pathValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigOTAFirmwareOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_otaCACertificate:(NSString *)host
                        port:(NSInteger)port
                    filePath:(NSString *)filePath
                    deviceID:(NSString *)deviceID
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(host) || host.length > 64 || !ValidStr(filePath) || filePath.length > 100 || port < 1 || port > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *portValue = [MKNBHMQTTSDKAdopter fetchHexValue:port byteLen:2];
    NSString *hostValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:host];
    NSString *hostLen = [MKNBHMQTTSDKAdopter fetchHexValue:host.length byteLen:1];
    NSString *pathValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:filePath];
    NSString *pathLen = [MKNBHMQTTSDKAdopter fetchHexValue:filePath.length byteLen:1];
    NSString *totalLen = [MKNBHMQTTSDKAdopter fetchHexValue:(filePath.length + host.length + 4) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed012b%@%@%@%@%@%@%@",asciiIDString,totalLen,portValue,hostLen,hostValue,pathLen,pathValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigOTACACertificateOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_otaSelfSignedCertificates:(NSString *)host
                                 port:(NSInteger)port
                           caFilePath:(NSString *)caFilePath
                        clientKeyPath:(NSString *)clientKeyPath
                       clientCertPath:(NSString *)clientCertPath
                             deviceID:(NSString *)deviceID
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(host) || host.length > 64 || !ValidStr(caFilePath) || caFilePath.length > 100 || port < 1 || port > 65535 || !ValidStr(clientKeyPath) || clientKeyPath.length > 100 || !ValidStr(clientCertPath) || clientCertPath.length > 100) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *portValue = [MKNBHMQTTSDKAdopter fetchHexValue:port byteLen:2];
    
    NSString *hostValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:host];
    NSString *hostLen = [MKNBHMQTTSDKAdopter fetchHexValue:host.length byteLen:1];
    
    NSString *caPathValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:caFilePath];
    NSString *caPathLen = [MKNBHMQTTSDKAdopter fetchHexValue:caFilePath.length byteLen:1];
    
    NSString *clientPathValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:clientCertPath];
    NSString *clientPathLen = [MKNBHMQTTSDKAdopter fetchHexValue:clientCertPath.length byteLen:1];
    
    NSString *clientKeyPathValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:clientKeyPath];
    NSString *clientKeyPathLen = [MKNBHMQTTSDKAdopter fetchHexValue:clientKeyPath.length byteLen:1];
    
    NSString *totalLen = [MKNBHMQTTSDKAdopter fetchHexValue:(hostValue.length + caFilePath.length + clientCertPath.length + clientKeyPath.length + 6) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed012c%@%@%@%@%@%@%@%@%@%@%@",asciiIDString,totalLen,portValue,hostLen,hostValue,caPathLen,caPathValue,clientPathLen,clientPathValue,clientKeyPathLen,clientKeyPathValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigOTASelfSignedCertificatesOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configDeviceUTCTime:(long long)timestamp
                       deviceID:(NSString *)deviceID
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *timeValue = [MKNBHMQTTSDKAdopter fetchHexValue:timestamp byteLen:4];
    NSString *commandString = [NSString stringWithFormat:@"ed013a%@%@%@",asciiIDString,@"0004",timeValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigDeviceUTCTimeOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

#pragma mark - 服务器参数
+ (void)nbh_configMQTTHost:(NSString *)host
                  deviceID:(NSString *)deviceID
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(host) || host.length > 64) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *hostString = [MKNBHMQTTSDKAdopter fetchAsciiCode:host];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:host.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0161%@%@%@",asciiIDString,dataLen,hostString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTHostOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTPort:(NSInteger)port
                  deviceID:(NSString *)deviceID
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    if (port < 1 || port > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *portString = [MKNBHMQTTSDKAdopter fetchHexValue:port byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0162%@%@%@",asciiIDString,@"0002",portString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTPortOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTUsername:(NSString *)username
                      deviceID:(NSString *)deviceID
                    macAddress:(NSString *)macAddress
                         topic:(NSString *)topic
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(username)) {
        username = @"";
    }
    if (username.length > 128) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:username];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:username.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0163%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTUsernameOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTPassword:(NSString *)password
                      deviceID:(NSString *)deviceID
                    macAddress:(NSString *)macAddress
                         topic:(NSString *)topic
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(password)) {
        password = @"";
    }
    if (password.length > 128) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:password];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:password.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0164%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTPasswordOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTClientID:(NSString *)clientID
                      deviceID:(NSString *)deviceID
                    macAddress:(NSString *)macAddress
                         topic:(NSString *)topic
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(clientID) || clientID.length > 64) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:clientID];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:clientID.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0165%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTClientIDOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTCleanSession:(BOOL)clean
                          deviceID:(NSString *)deviceID
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = (clean ? @"01" : @"00");
    NSString *commandString = [NSString stringWithFormat:@"ed0166%@%@%@",asciiIDString,@"0001",valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigCleanSessionOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTKeepAlive:(NSInteger)keepAlive
                       deviceID:(NSString *)deviceID
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (keepAlive < 10 || keepAlive > 120) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchHexValue:keepAlive byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0167%@%@%@",asciiIDString,@"0001",valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTKeepAliveOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTQos:(NSInteger)qos
                 deviceID:(NSString *)deviceID
               macAddress:(NSString *)macAddress
                    topic:(NSString *)topic
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (qos < 0 || qos > 2) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchHexValue:qos byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0168%@%@%@",asciiIDString,@"0001",valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTQosOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTSubscribeTopic:(NSString *)subTopic
                            deviceID:(NSString *)deviceID
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:subTopic];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:subTopic.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0169%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTSubscribeTopicOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTPublishTopic:(NSString *)pubTopic
                          deviceID:(NSString *)deviceID
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:pubTopic];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:pubTopic.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed016a%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTPublishTopicOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configLWTStatus:(BOOL)isOn
                   deviceID:(NSString *)deviceID
                 macAddress:(NSString *)macAddress
                      topic:(NSString *)topic
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = (isOn ? @"01" : @"00");
    NSString *commandString = [NSString stringWithFormat:@"ed016b%@%@%@",asciiIDString,@"0001",valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigLWTStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configLWTQos:(NSInteger)qos
                deviceID:(NSString *)deviceID
              macAddress:(NSString *)macAddress
                   topic:(NSString *)topic
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    if (qos < 0 || qos > 2) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchHexValue:qos byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed016c%@%@%@",asciiIDString,@"0001",valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigLWTQosOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configLWTRetain:(BOOL)isOn
                   deviceID:(NSString *)deviceID
                 macAddress:(NSString *)macAddress
                      topic:(NSString *)topic
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = (isOn ? @"01" : @"00");
    NSString *commandString = [NSString stringWithFormat:@"ed016d%@%@%@",asciiIDString,@"0001",valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigLWTRetainOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configLWTTopic:(NSString *)lwtTopic
                  deviceID:(NSString *)deviceID
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:lwtTopic];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:lwtTopic.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed016e%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigLWTTopicOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configLWTPayload:(NSString *)payload
                    deviceID:(NSString *)deviceID
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(payload) || payload.length > 128) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:payload];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:payload.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed016f%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigLWTPayloadOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configSSLStatus:(NSInteger)status
                   deviceID:(NSString *)deviceID
                 macAddress:(NSString *)macAddress
                      topic:(NSString *)topic
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (status < 0 || status > 2) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchHexValue:status byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0170%@%@%@",asciiIDString,@"0001",valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigSSLStatusOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configAPN:(NSString *)apn
             deviceID:(NSString *)deviceID
           macAddress:(NSString *)macAddress
                topic:(NSString *)topic
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(apn)) {
        apn = @"";
    }
    if (apn.length > 128) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:apn];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:apn.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0171%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigAPNOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configAPNUsername:(NSString *)username
                     deviceID:(NSString *)deviceID
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(username)) {
        username = @"";
    }
    if (username.length > 128) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:username];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:username.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0172%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigAPNUsernameOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configAPNPassword:(NSString *)password
                     deviceID:(NSString *)deviceID
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(password)) {
        password = @"";
    }
    if (password.length > 128) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchAsciiCode:password];
    NSString *dataLen = [MKNBHMQTTSDKAdopter fetchHexValue:password.length byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0173%@%@%@",asciiIDString,dataLen,valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigAPNPasswordOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configNetworkPriority:(mk_nbh_mqtt_networkPriority)priority
                         deviceID:(NSString *)deviceID
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *valueString = [MKNBHMQTTSDKAdopter fetchHexValue:priority byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"ed0174%@%@%@",asciiIDString,@"0001",valueString];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigNetworkPriorityOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configCertificate:(NSString *)host
                         port:(NSInteger)port
                     filePath:(NSString *)filePath
                     deviceID:(NSString *)deviceID
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(host) || host.length > 64 || !ValidStr(filePath) || filePath.length > 100 || port < 1 || port > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *portValue = [MKNBHMQTTSDKAdopter fetchHexValue:port byteLen:2];
    NSString *hostValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:host];
    NSString *hostLen = [MKNBHMQTTSDKAdopter fetchHexValue:host.length byteLen:1];
    NSString *pathValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:filePath];
    NSString *pathLen = [MKNBHMQTTSDKAdopter fetchHexValue:filePath.length byteLen:1];
    NSString *totalLen = [MKNBHMQTTSDKAdopter fetchHexValue:(filePath.length + host.length + 4) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0175%@%@%@%@%@%@%@",asciiIDString,totalLen,portValue,hostLen,hostValue,pathLen,pathValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigCACertificateOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configSelfSignedCertificates:(NSString *)host
                                    port:(NSInteger)port
                              caFilePath:(NSString *)caFilePath
                           clientKeyPath:(NSString *)clientKeyPath
                          clientCertPath:(NSString *)clientCertPath
                                deviceID:(NSString *)deviceID
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(host) || host.length > 64 || !ValidStr(caFilePath) || caFilePath.length > 100 || port < 1 || port > 65535 || !ValidStr(clientKeyPath) || clientKeyPath.length > 100 || !ValidStr(clientCertPath) || clientCertPath.length > 100) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *portValue = [MKNBHMQTTSDKAdopter fetchHexValue:port byteLen:2];
    
    NSString *hostValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:host];
    NSString *hostLen = [MKNBHMQTTSDKAdopter fetchHexValue:host.length byteLen:1];
    
    NSString *caPathValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:caFilePath];
    NSString *caPathLen = [MKNBHMQTTSDKAdopter fetchHexValue:caFilePath.length byteLen:1];
    
    NSString *clientPathValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:clientCertPath];
    NSString *clientPathLen = [MKNBHMQTTSDKAdopter fetchHexValue:clientCertPath.length byteLen:1];
    
    NSString *clientKeyPathValue = [MKNBHMQTTSDKAdopter fetchAsciiCode:clientKeyPath];
    NSString *clientKeyPathLen = [MKNBHMQTTSDKAdopter fetchHexValue:clientKeyPath.length byteLen:1];
    
    NSString *totalLen = [MKNBHMQTTSDKAdopter fetchHexValue:(hostValue.length + caFilePath.length + clientCertPath.length + clientKeyPath.length + 6) byteLen:2];
    NSString *commandString = [NSString stringWithFormat:@"ed0176%@%@%@%@%@%@%@%@%@%@%@",asciiIDString,totalLen,portValue,hostLen,hostValue,caPathLen,caPathValue,clientPathLen,clientPathValue,clientKeyPathLen,clientKeyPathValue];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigSelfSignedCertificatesOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_configMQTTServerParamsCompleteWithDeviceID:(NSString *)deviceID
                                            macAddress:(NSString *)macAddress
                                                 topic:(NSString *)topic
                                              sucBlock:(void (^)(void))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0177%@%@",asciiIDString,@"0000"];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskConfigMQTTServerParamsCompleteOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

+ (void)nbh_reconnectMQTTServerWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0178%@%@",asciiIDString,@"0000"];
    [self publishCommand:commandString
                   topic:topic
                deviceID:deviceID
                  taskID:mk_nbh_server_taskReconnectMQTTServerOperation
                sucBlock:sucBlock
             failedBlock:failedBlock];
}

#pragma mark - private method
+ (void)publishCommand:(NSString *)command
                 topic:(NSString *)topic
              deviceID:(NSString *)deviceID
                taskID:(mk_nbh_serverOperationID)taskID
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    [[MKNBHMQTTServerManager shared] sendCommand:command topic:topic deviceID:deviceID taskID:taskID sucBlock:^(id  _Nonnull returnData) {
        BOOL success = [returnData[@"success"] boolValue];
        if (!success) {
            [MKNBHMQTTSDKAdopter operationSetParamsErrorBlock:failedBlock];
            return ;
        }
        if (sucBlock) {
            sucBlock();
        }
    } failedBlock:failedBlock];
}

+ (BOOL)checkLEDColorParams:(mk_nbh_ledColorType)colorType
              colorProtocol:(nullable id <mk_nbh_ledColorConfigProtocol>)protocol
               productModel:(mk_nbh_productModel)productModel {
    if (colorType == mk_nbh_ledColorTransitionSmoothly || colorType == mk_nbh_ledColorTransitionDirectly) {
        if (!protocol || ![protocol conformsToProtocol:@protocol(mk_nbh_ledColorConfigProtocol)]) {
            return NO;
        }
        NSInteger maxValue = 4416;
        if (productModel == mk_nbh_productModel_America) {
            maxValue = 2160;
        }else if (productModel == mk_nbh_productModel_UK) {
            maxValue = 3588;
        }
        if (protocol.b_color < 1 || protocol.b_color > (maxValue - 5)) {
            return NO;
        }
        if (protocol.g_color <= protocol.b_color || protocol.g_color > (maxValue - 4)) {
            return NO;
        }
        if (protocol.y_color <= protocol.g_color || protocol.y_color > (maxValue - 3)) {
            return NO;
        }
        if (protocol.o_color <= protocol.y_color || protocol.o_color > (maxValue - 2)) {
            return NO;
        }
        if (protocol.r_color <= protocol.o_color || protocol.r_color > (maxValue - 1)) {
            return NO;
        }
        if (protocol.p_color <= protocol.r_color || protocol.p_color > maxValue) {
            return NO;
        }
    }
    return YES;
}

@end
