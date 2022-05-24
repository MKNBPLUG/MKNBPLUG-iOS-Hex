//
//  MKNBHMQTTInterface.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHMQTTInterface.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKNBHMQTTServerManager.h"
#import "MKNBHMQTTSDKAdopter.h"

@implementation MKNBHMQTTInterface

+ (void)nbh_readPowerOnSwitchStatusWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0001%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadPowerOnSwitchStatusOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readPeriodicalReportingWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0002%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadPeriodicalReportingOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readPowerReportingWithDeviceID:(NSString *)deviceID
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0003%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadPowerReportingOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readEnergyReportingWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0004%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadEnergyReportingOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readOverloadProtectionDataWithDeviceID:(NSString *)deviceID
                                        macAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0005%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadOverloadProtectionDataOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readOvervoltageProtectionDataWithDeviceID:(NSString *)deviceID
                                           macAddress:(NSString *)macAddress
                                                topic:(NSString *)topic
                                             sucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0006%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadOvervoltageProtectionDataOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readUndervoltageProtectionDataWithDeviceID:(NSString *)deviceID
                                            macAddress:(NSString *)macAddress
                                                 topic:(NSString *)topic
                                              sucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0007%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadUndervoltageProtectionDataOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readOvercurrentProtectionDataWithDeviceID:(NSString *)deviceID
                                           macAddress:(NSString *)macAddress
                                                topic:(NSString *)topic
                                             sucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0008%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadOvercurrentProtectionDataOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readPowerIndicatorColorWithDeviceID:(NSString *)deviceID
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0009%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadPowerIndicatorColorOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readNTPServerParamsWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed000a%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadNTPServerParamsOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readTimeZoneWithDeviceID:(NSString *)deviceID
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed000b%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadTimeZoneOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readLoadNotificationSwitchWithDeviceID:(NSString *)deviceID
                                        macAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed000c%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadLoadNotificationSwitchOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readServerConnectingIndicatorStatusWithDeviceID:(NSString *)deviceID
                                                 macAddress:(NSString *)macAddress
                                                      topic:(NSString *)topic
                                                   sucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed000d%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadServerConnectingIndicatorStatusOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readServerConnectedIndicatorStatusWithDeviceID:(NSString *)deviceID
                                                macAddress:(NSString *)macAddress
                                                     topic:(NSString *)topic
                                                  sucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed000e%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadServerConnectedIndicatorStatusOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readIndicatorStatusWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed000f%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadIndicatorStatusOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readIndicatorProtectionSignalWithDeviceID:(NSString *)deviceID
                                           macAddress:(NSString *)macAddress
                                                topic:(NSString *)topic
                                             sucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0010%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadIndicatorProtectionSignalOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readConnectionTimeoutWithDeviceID:(NSString *)deviceID
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0011%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadConnectionTimeoutOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readSwitchByButtonStatusWithDeviceID:(NSString *)deviceID
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0012%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadSwitchByButtonStatusOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readSwitchStatusWithDeviceID:(NSString *)deviceID
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0026%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadSwitchStatusOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readDeviceUpdateStateWithDeviceID:(NSString *)deviceID
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed002d%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadDeviceUpdateStateOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readElectricityDataWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed002e%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadElectricityDataOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readTotalEnergyDataWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed002f%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadTotalEnergyDataOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMonthlyEnergyDataWithDeviceID:(NSString *)deviceID
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0030%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMonthlyEnergyDataOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readHourlyEnergyDataWithDeviceID:(NSString *)deviceID
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0031%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadHourlyEnergyDataOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readSpecificationsOfDeviceWithDeviceID:(NSString *)deviceID
                                        macAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0032%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadSpecificationsOfDeviceOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readManufacturerWithDeviceID:(NSString *)deviceID
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0033%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadManufacturerOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readDeviceModeWithDeviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0034%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadDeviceModeOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readHardwareWithDeviceID:(NSString *)deviceID
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0035%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadHardwareOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readFirmwareWithDeviceID:(NSString *)deviceID
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0036%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadFirmwareOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMacAddressWithDeviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0037%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMacAddressOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readDeviceIEMIWithDeviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0038%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadDeviceIEMIOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readDeviceICCIDWithDeviceID:(NSString *)deviceID
                             macAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0039%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadDeviceICCIDOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readDeviceUTCTimeWithDeviceID:(NSString *)deviceID
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed003a%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadDeviceUTCTimeOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readDeviceWorkModeWithDeviceID:(NSString *)deviceID
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed003b%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadDeviceWorkModeOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readDeviceInfoWithDeviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed003c%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadDeviceInfoOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

#pragma mark - 设备MQTT服务器信息

+ (void)nbh_readMQTTHostWithDeviceID:(NSString *)deviceID
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0061%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTHostOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTPortWithDeviceID:(NSString *)deviceID
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0062%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTPortOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTUsernameWithDeviceID:(NSString *)deviceID
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0063%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTUsernameOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTPasswordWithDeviceID:(NSString *)deviceID
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0064%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTPasswordOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTCilentIDWithDeviceID:(NSString *)deviceID
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0065%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTClientIDOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTCleanSessionWithDeviceID:(NSString *)deviceID
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0066%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTCleanSessionOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTKeepAliveWithDeviceID:(NSString *)deviceID
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0067%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTKeepAliveOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTQosWithDeviceID:(NSString *)deviceID
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0068%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTQosOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTSubscribeTopicWithDeviceID:(NSString *)deviceID
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0069%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTSubscribeTopicOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTPublishTopicWithDeviceID:(NSString *)deviceID
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed006a%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTPublishTopicOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTLWTStatusWithDeviceID:(NSString *)deviceID
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed006b%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTLWTStatusOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTLWTQosWithDeviceID:(NSString *)deviceID
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed006c%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTLWTQosOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTLWTRetainWithDeviceID:(NSString *)deviceID
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed006d%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTLWTRetainOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTLWTTopicWithDeviceID:(NSString *)deviceID
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed006e%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTLWTTopicOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTLWTPayloadWithDeviceID:(NSString *)deviceID
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed006f%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTLWTPayloadOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readMQTTSSLStatusWithDeviceID:(NSString *)deviceID
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0070%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadMQTTSSLStatusOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readAPNWithDeviceID:(NSString *)deviceID
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0071%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadAPNOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readAPNUsernameWithDeviceID:(NSString *)deviceID
                             macAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0072%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadAPNUsernameOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readAPNPasswordWithDeviceID:(NSString *)deviceID
                             macAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0073%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadAPNPasswordOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readNetwordPriorityWithDeviceID:(NSString *)deviceID
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0074%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadNetwordPriorityOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

+ (void)nbh_readDeviceMQTTServerInfoWithDeviceID:(NSString *)deviceID
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkDeviceID:deviceID topic:topic macAddress:macAddress];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *asciiIDString = [MKNBHMQTTSDKAdopter parseDeviceIDToCmd:deviceID];
    NSString *commandString = [NSString stringWithFormat:@"ed0079%@%@",asciiIDString,@"0000"];
    [[MKNBHMQTTServerManager shared] sendCommand:commandString
                                           topic:topic
                                        deviceID:deviceID
                                          taskID:mk_nbh_server_taskReadDeviceMQTTServerInfoOperation
                                        sucBlock:sucBlock
                                     failedBlock:failedBlock];
}

#pragma mark - private method
+ (NSString *)checkDeviceID:(NSString *)deviceID
                      topic:(NSString *)topic
                 macAddress:(NSString *)macAddress {
    if (!ValidStr(topic) || topic.length > 128 || ![topic isAsciiString]) {
        return @"Topic error";
    }
    if (!ValidStr(deviceID) || deviceID.length > 32 || ![deviceID isAsciiString]) {
        return @"ClientID error";
    }
    if (!ValidStr(macAddress)) {
        return @"Mac error";
    }
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@" " withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@":" withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@"-" withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@"_" withString:@""];
    if (macAddress.length != 12 || ![macAddress regularExpressions:isHexadecimal]) {
        return @"Mac error";
    }
    return @"";
}

+ (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.NBHMQTTManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

@end
