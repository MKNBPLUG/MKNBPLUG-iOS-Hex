//
//  MKNBHMQTTTaskAdopter.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHMQTTTaskAdopter.h"

#import "MKMacroDefines.h"

#import "MKNBHMQTTTaskID.h"
#import "MKNBHMQTTSDKAdopter.h"
#import "MKNBHMQTTDataParser.h"

@implementation MKNBHMQTTTaskAdopter

+ (NSDictionary *)parseDataWithJson:(NSDictionary *)json topic:(NSString *)topic {
    if ([json[@"msg_flag"] isEqualToString:@"00"]) {
        //读取
        return [self parseReadParamsWithJson:json msgID:json[@"msg_id"]];
    }
    if ([json[@"msg_flag"] isEqualToString:@"01"]) {
        //配置
        return [self parseConfigParamsWithJson:json msgID:json[@"msg_id"]];
    }
    return @{};
}

#pragma mark - private method
+ (NSDictionary *)parseConfigParamsWithJson:(NSDictionary *)json msgID:(NSString *)msgID {
    NSData *contenData = json[@"device_data"];
    if (!ValidData(contenData)) {
        return @{};
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    BOOL success = [content isEqualToString:@"01"];
    mk_nbh_serverOperationID operationID = mk_nbh_defaultServerOperationID;
    if ([msgID isEqualToString:@"01"]) {
        //默认开关状态
        operationID = mk_nbh_server_taskConfigPowerOnSwitchStatusOperation;
    }else if ([msgID isEqualToString:@"02"]) {
        //配置开关状态和倒计时上报间隔
        operationID = mk_nbh_server_taskConfigPeriodicalReportOperation;
    }else if ([msgID isEqualToString:@"03"]) {
        //配置电量上报信息
        operationID = mk_nbh_server_taskConfigPowerReportOperation;
    }else if ([msgID isEqualToString:@"04"]) {
        //配置电能存储和上报参数
        operationID = mk_nbh_server_taskConfigEnergyReportOperation;
    }else if ([msgID isEqualToString:@"05"]) {
        //配置过载保护
        operationID = mk_nbh_server_taskConfigOverloadOperation;
    }else if ([msgID isEqualToString:@"06"]) {
        //配置过压保护
        operationID = mk_nbh_server_taskConfigOvervoltageOperation;
    }else if ([msgID isEqualToString:@"07"]) {
        //配置欠压保护
        operationID = mk_nbh_server_taskConfigUndervoltageOperation;
    }else if ([msgID isEqualToString:@"08"]) {
        //配置过流保护
        operationID = mk_nbh_server_taskConfigOvercurrentOperation;
    }else if ([msgID isEqualToString:@"09"]) {
        //配置功率指示灯颜色
        operationID = mk_nbh_server_taskConfigPowerIndicatorColorOperation;
    }else if ([msgID isEqualToString:@"0a"]) {
        //配置NTP服务器参数
        operationID = mk_nbh_server_taskConfigNTPServerParamsOperation;
    }else if ([msgID isEqualToString:@"0b"]) {
        //配置时区
        operationID = mk_nbh_server_taskConfigDeviceTimeZoneOperation;
    }else if ([msgID isEqualToString:@"0c"]) {
        //配置负载通知开关状态
        operationID = mk_nbh_server_taskConfigLoadNotificationSwitchOperation;
    }else if ([msgID isEqualToString:@"0d"]) {
        //配置连接中网络指示灯开关
        operationID = mk_nbh_server_taskConfigServerConnectingIndicatorStatusOperation;
    }else if ([msgID isEqualToString:@"0e"]) {
        //配置连接成功网络指示灯状态
        operationID = mk_nbh_server_taskConfigServerConnectedIndicatorStatusOperation;
    }else if ([msgID isEqualToString:@"0f"]) {
        //配置电源指示灯开关指示
        operationID = mk_nbh_server_taskConfigIndicatorStatusOperation;
    }else if ([msgID isEqualToString:@"10"]) {
        //配置电源指示灯保护触发指示
        operationID = mk_nbh_server_taskConfigIndicatorProtectionSignalOperation;
    }else if ([msgID isEqualToString:@"11"]) {
        //配置服务器重连超时重启时间
        operationID = mk_nbh_server_taskConfigConnectionTimeoutOperation;
    }else if ([msgID isEqualToString:@"12"]) {
        //配置按键控制功能开关状态
        operationID = mk_nbh_server_taskConfigSwitchByButtonStatusOperation;
    }else if ([msgID isEqualToString:@"21"]) {
        //解除过载状态
        operationID = mk_nbh_server_taskClearOverloadStatusOperation;
    }else if ([msgID isEqualToString:@"22"]) {
        //解除过压状态
        operationID = mk_nbh_server_taskClearOvervoltageStatusOperation;
    }else if ([msgID isEqualToString:@"23"]) {
        //解除欠压状态
        operationID = mk_nbh_server_taskClearUndervoltageStatusOperation;
    }else if ([msgID isEqualToString:@"24"]) {
        //解除过流状态
        operationID = mk_nbh_server_taskClearOvercurrentStatusOperation;
    }else if ([msgID isEqualToString:@"25"]) {
        //配置开关状态
        operationID = mk_nbh_server_taskConfigSwitchStatusOperation;
    }else if ([msgID isEqualToString:@"27"]) {
        //配置倒计时
        operationID = mk_nbh_server_taskConfigCountdownOperation;
    }else if ([msgID isEqualToString:@"28"]) {
        //清除电能数据
        operationID = mk_nbh_server_taskClearAllEnergyDatasOperation;
    }else if ([msgID isEqualToString:@"29"]) {
        //恢复出厂设置
        operationID = mk_nbh_server_taskResetDeviceOperation;
    }else if ([msgID isEqualToString:@"2a"]) {
        //OTA固件升级
        operationID = mk_nbh_server_taskConfigOTAFirmwareOperation;
    }else if ([msgID isEqualToString:@"2b"]) {
        //OTA单项认证证书
        operationID = mk_nbh_server_taskConfigOTACACertificateOperation;
    }else if ([msgID isEqualToString:@"2c"]) {
        //OTA双向认证证书
        operationID = mk_nbh_server_taskConfigOTASelfSignedCertificatesOperation;
    }else if ([msgID isEqualToString:@"3a"]) {
        //配置设备UTC时间
        operationID = mk_nbh_server_taskConfigDeviceUTCTimeOperation;
    }else if ([msgID isEqualToString:@"61"]) {
        //配置MQTT服务器地址
        operationID = mk_nbh_server_taskConfigMQTTHostOperation;
    }else if ([msgID isEqualToString:@"62"]) {
        //配置MQTT服务器端口号
        operationID = mk_nbh_server_taskConfigMQTTPortOperation;
    }else if ([msgID isEqualToString:@"63"]) {
        //配置MQTT用户名
        operationID = mk_nbh_server_taskConfigMQTTUsernameOperation;
    }else if ([msgID isEqualToString:@"64"]) {
        //配置MQTT密码
        operationID = mk_nbh_server_taskConfigMQTTPasswordOperation;
    }else if ([msgID isEqualToString:@"65"]) {
        //配置MQTT Client ID
        operationID = mk_nbh_server_taskConfigMQTTClientIDOperation;
    }else if ([msgID isEqualToString:@"66"]) {
        //配置MQTT Clean Session
        operationID = mk_nbh_server_taskConfigCleanSessionOperation;
    }else if ([msgID isEqualToString:@"67"]) {
        //配置MQTT KeepAlive
        operationID = mk_nbh_server_taskConfigMQTTKeepAliveOperation;
    }else if ([msgID isEqualToString:@"68"]) {
        //配置MQTT Qos
        operationID = mk_nbh_server_taskConfigMQTTQosOperation;
    }else if ([msgID isEqualToString:@"69"]) {
        //配置MQTT 订阅主题
        operationID = mk_nbh_server_taskConfigMQTTSubscribeTopicOperation;
    }else if ([msgID isEqualToString:@"6a"]) {
        //配置MQTT 发布主题
        operationID = mk_nbh_server_taskConfigMQTTPublishTopicOperation;
    }else if ([msgID isEqualToString:@"6b"]) {
        //配置MQTT遗嘱功能开关
        operationID = mk_nbh_server_taskConfigLWTStatusOperation;
    }else if ([msgID isEqualToString:@"6c"]) {
        //配置MQTT遗嘱Qos
        operationID = mk_nbh_server_taskConfigLWTQosOperation;
    }else if ([msgID isEqualToString:@"6d"]) {
        //配置MQTT遗嘱Retain
        operationID = mk_nbh_server_taskConfigLWTRetainOperation;
    }else if ([msgID isEqualToString:@"6e"]) {
        //配置MQTT遗嘱主题
        operationID = mk_nbh_server_taskConfigLWTTopicOperation;
    }else if ([msgID isEqualToString:@"6f"]) {
        //配置MQTT遗嘱内容
        operationID = mk_nbh_server_taskConfigLWTPayloadOperation;
    }else if ([msgID isEqualToString:@"70"]) {
        //配置MQTT加密方式
        operationID = mk_nbh_server_taskConfigSSLStatusOperation;
    }else if ([msgID isEqualToString:@"71"]) {
        //配置APN
        operationID = mk_nbh_server_taskConfigAPNOperation;
    }else if ([msgID isEqualToString:@"72"]) {
        //配置APN用户名
        operationID = mk_nbh_server_taskConfigAPNUsernameOperation;
    }else if ([msgID isEqualToString:@"73"]) {
        //配置APN密码
        operationID = mk_nbh_server_taskConfigAPNPasswordOperation;
    }else if ([msgID isEqualToString:@"74"]) {
        //配置网络制式
        operationID = mk_nbh_server_taskConfigNetworkPriorityOperation;
    }else if ([msgID isEqualToString:@"75"]) {
        //配置单向认证证书
        operationID = mk_nbh_server_taskConfigCACertificateOperation;
    }else if ([msgID isEqualToString:@"76"]) {
        //配置双向认证证书
        operationID = mk_nbh_server_taskConfigSelfSignedCertificatesOperation;
    }else if ([msgID isEqualToString:@"77"]) {
        //配置MQTT参数完成
        operationID = mk_nbh_server_taskConfigMQTTServerParamsCompleteOperation;
    }else if ([msgID isEqualToString:@"78"]) {
        //切换服务器
        operationID = mk_nbh_server_taskReconnectMQTTServerOperation;
    }
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}

+ (NSDictionary *)parseReadParamsWithJson:(NSDictionary *)json msgID:(NSString *)msgID {
    NSData *contenData = json[@"device_data"];
    mk_nbh_serverOperationID operationID = mk_nbh_defaultServerOperationID;
    NSDictionary *resultDic = @{};
    if ([msgID isEqualToString:@"01"]) {
        //默认开关状态
        resultDic = [MKNBHMQTTDataParser parseReadDefaultPowerOnModeData:json];
        operationID = mk_nbh_server_taskReadPowerOnSwitchStatusOperation;
    }else if ([msgID isEqualToString:@"02"]) {
        //读取开关状态和倒计时上报间隔
        resultDic = [MKNBHMQTTDataParser parseReadPeriodicalReportingData:json];
        operationID = mk_nbh_server_taskReadPeriodicalReportingOperation;
    }else if ([msgID isEqualToString:@"03"]) {
        //读取电量上报间隔和阈值
        resultDic = [MKNBHMQTTDataParser parseReadPowerReportingData:json];
        operationID = mk_nbh_server_taskReadPowerReportingOperation;
    }else if ([msgID isEqualToString:@"04"]) {
        //读取电能存储和上报参数
        resultDic = [MKNBHMQTTDataParser parseReadEnergyReportingData:json];
        operationID = mk_nbh_server_taskReadEnergyReportingOperation;
    }else if ([msgID isEqualToString:@"05"]) {
        //读取过载保护
        resultDic = [MKNBHMQTTDataParser parseReadOverProtectionData:json];
        operationID = mk_nbh_server_taskReadOverloadProtectionDataOperation;
    }else if ([msgID isEqualToString:@"06"]) {
        //读取过压保护
        resultDic = [MKNBHMQTTDataParser parseReadOverProtectionData:json];
        operationID = mk_nbh_server_taskReadOvervoltageProtectionDataOperation;
    }else if ([msgID isEqualToString:@"07"]) {
        //读取欠压保护
        resultDic = [MKNBHMQTTDataParser parseReadOverProtectionData:json];
        operationID = mk_nbh_server_taskReadUndervoltageProtectionDataOperation;
    }else if ([msgID isEqualToString:@"08"]) {
        //读取过流保护
        resultDic = [MKNBHMQTTDataParser parseReadOverProtectionData:json];
        operationID = mk_nbh_server_taskReadOvercurrentProtectionDataOperation;
    }else if ([msgID isEqualToString:@"09"]) {
        //读取功率指示灯颜色
        resultDic = [MKNBHMQTTDataParser parseReadPowerIndicatorColorData:json];
        operationID = mk_nbh_server_taskReadPowerIndicatorColorOperation;
    }else if ([msgID isEqualToString:@"0a"]) {
        //读取NTP服务器参数
        resultDic = [MKNBHMQTTDataParser parseReadNTPServerParamsData:json];
        operationID = mk_nbh_server_taskReadNTPServerParamsOperation;
    }else if ([msgID isEqualToString:@"0b"]) {
        //读取时区
        resultDic = [MKNBHMQTTDataParser parseReadTimezoneData:json];
        operationID = mk_nbh_server_taskReadTimeZoneOperation;
    }else if ([msgID isEqualToString:@"0c"]) {
        //读取负载通知开关
        resultDic = [MKNBHMQTTDataParser parseReadloadNotificationData:json];
        operationID = mk_nbh_server_taskReadLoadNotificationSwitchOperation;
    }else if ([msgID isEqualToString:@"0d"]) {
        //读取连接中网络指示灯开关
        resultDic = [MKNBHMQTTDataParser parseStateData:json];
        operationID = mk_nbh_server_taskReadServerConnectingIndicatorStatusOperation;
    }else if ([msgID isEqualToString:@"0e"]) {
        //读取连接成功网络指示灯状态
        resultDic = [MKNBHMQTTDataParser parseReadIndicatorConnectedData:json];
        operationID = mk_nbh_server_taskReadServerConnectedIndicatorStatusOperation;
    }else if ([msgID isEqualToString:@"0f"]) {
        //读取电源指示灯开关状态
        resultDic = [MKNBHMQTTDataParser parseStateData:json];
        operationID = mk_nbh_server_taskReadIndicatorStatusOperation;
    }else if ([msgID isEqualToString:@"10"]) {
        //读取电源指示灯保护触发指示
        resultDic = [MKNBHMQTTDataParser parseStateData:json];
        operationID = mk_nbh_server_taskReadIndicatorProtectionSignalOperation;
    }else if ([msgID isEqualToString:@"11"]) {
        //读取服务器重连超时重启的时间间隔
        resultDic = [MKNBHMQTTDataParser parseReadConnectionTimeoutData:json];
        operationID = mk_nbh_server_taskReadConnectionTimeoutOperation;
    }else if ([msgID isEqualToString:@"12"]) {
        //读取按键控制功能开关状态
        resultDic = [MKNBHMQTTDataParser parseStateData:json];
        operationID = mk_nbh_server_taskReadSwitchByButtonStatusOperation;
    }else if ([msgID isEqualToString:@"26"]) {
        //读取开关状态
        resultDic = [MKNBHMQTTDataParser parseReadSwitchStateData:json];
        operationID = mk_nbh_server_taskReadSwitchStatusOperation;
    }else if ([msgID isEqualToString:@"2d"]) {
        //读取设备当前OTA状态
        resultDic = [MKNBHMQTTDataParser parseReadDeviceStateData:json];
        operationID = mk_nbh_server_taskReadDeviceUpdateStateOperation;
    }else if ([msgID isEqualToString:@"2e"]) {
        //读取设备当前电量信息
        resultDic = [MKNBHMQTTDataParser parseReadElectricityData:json];
        operationID = mk_nbh_server_taskReadElectricityDataOperation;
    }else if ([msgID isEqualToString:@"2f"]) {
        //读取设备总累计电能
        resultDic = [MKNBHMQTTDataParser parseTotalEnergyDataDic:json];
        operationID = mk_nbh_server_taskReadTotalEnergyDataOperation;
    }else if ([msgID isEqualToString:@"30"]) {
        //读取设备最近30天电能
        resultDic = [MKNBHMQTTDataParser parseEnergyDataDic:json];
        operationID = mk_nbh_server_taskReadMonthlyEnergyDataOperation;
    }else if ([msgID isEqualToString:@"31"]) {
        //读取设备当天每小时电能
        resultDic = [MKNBHMQTTDataParser parseEnergyDataDic:json];
        operationID = mk_nbh_server_taskReadHourlyEnergyDataOperation;
    }else if ([msgID isEqualToString:@"32"]) {
        //读取设备规格
        resultDic = [MKNBHMQTTDataParser parseReadSpecificationsData:json];
        operationID = mk_nbh_server_taskReadSpecificationsOfDeviceOperation;
    }else if ([msgID isEqualToString:@"33"]) {
        //读取厂商信息
        resultDic = [MKNBHMQTTDataParser parseReadDeviceInfoData:json];
        operationID = mk_nbh_server_taskReadManufacturerOperation;
    }else if ([msgID isEqualToString:@"34"]) {
        //读取产品型号
        resultDic = [MKNBHMQTTDataParser parseReadDeviceInfoData:json];
        operationID = mk_nbh_server_taskReadDeviceModeOperation;
    }else if ([msgID isEqualToString:@"35"]) {
        //读取硬件版本
        resultDic = [MKNBHMQTTDataParser parseReadDeviceInfoData:json];
        operationID = mk_nbh_server_taskReadHardwareOperation;
    }else if ([msgID isEqualToString:@"36"]) {
        //读取固件版本
        resultDic = [MKNBHMQTTDataParser parseReadDeviceInfoData:json];
        operationID = mk_nbh_server_taskReadFirmwareOperation;
    }else if ([msgID isEqualToString:@"37"]) {
        //读取mac地址
        resultDic = [MKNBHMQTTDataParser parseReadDeviceMacAddressData:json];
        operationID = mk_nbh_server_taskReadMacAddressOperation;
    }else if ([msgID isEqualToString:@"38"]) {
        //读取IEMI
        resultDic = [MKNBHMQTTDataParser parseReadDeviceInfoData:json];
        operationID = mk_nbh_server_taskReadDeviceIEMIOperation;
    }else if ([msgID isEqualToString:@"39"]) {
        //读取ICCID
        resultDic = [MKNBHMQTTDataParser parseReadDeviceInfoData:json];
        operationID = mk_nbh_server_taskReadDeviceICCIDOperation;
    }else if ([msgID isEqualToString:@"3a"]) {
        //读取设备UTC时间
        resultDic = [MKNBHMQTTDataParser parseReadUTCTimeData:json];
        operationID = mk_nbh_server_taskReadDeviceUTCTimeOperation;
    }else if ([msgID isEqualToString:@"3b"]) {
        //读取设备工作模式
        resultDic = [MKNBHMQTTDataParser parseReadDebugModeData:json];
        operationID = mk_nbh_server_taskReadDeviceWorkModeOperation;
    }else if ([msgID isEqualToString:@"3c"]) {
        //读取设备出厂信息
        resultDic = [MKNBHMQTTDataParser parseDeviceInfoDic:json];
        operationID = mk_nbh_server_taskReadDeviceInfoOperation;
    }else if ([msgID isEqualToString:@"61"]) {
        //读取MQTT服务器地址
        resultDic = [MKNBHMQTTDataParser parseReadMQTTHostData:json];
        operationID = mk_nbh_server_taskReadMQTTHostOperation;
    }else if ([msgID isEqualToString:@"62"]) {
        //读取MQTT服务器端口号
        resultDic = [MKNBHMQTTDataParser parseReadMQTTPortData:json];
        operationID = mk_nbh_server_taskReadMQTTPortOperation;
    }else if ([msgID isEqualToString:@"63"]) {
        //读取MQTT用户名
        resultDic = [MKNBHMQTTDataParser parseReadMQTTUsernameData:json];
        operationID = mk_nbh_server_taskReadMQTTUsernameOperation;
    }else if ([msgID isEqualToString:@"64"]) {
        //读取MQTT密码
        resultDic = [MKNBHMQTTDataParser parseReadMQTTPasswordData:json];
        operationID = mk_nbh_server_taskReadMQTTPasswordOperation;
    }else if ([msgID isEqualToString:@"65"]) {
        //读取MQTT Client ID
        resultDic = [MKNBHMQTTDataParser parseReadMQTTClientIDData:json];
        operationID = mk_nbh_server_taskReadMQTTClientIDOperation;
    }else if ([msgID isEqualToString:@"66"]) {
        //读取MQTT Clean Session
        resultDic = [MKNBHMQTTDataParser parseStateData:json];
        operationID = mk_nbh_server_taskReadMQTTCleanSessionOperation;
    }else if ([msgID isEqualToString:@"67"]) {
        //读取MQTT KeepAlive
        resultDic = [MKNBHMQTTDataParser parseReadMQTTKeepAliveData:json];
        operationID = mk_nbh_server_taskReadMQTTKeepAliveOperation;
    }else if ([msgID isEqualToString:@"68"]) {
        //读取MQTT Qos
        resultDic = [MKNBHMQTTDataParser parseReadQosData:json];
        operationID = mk_nbh_server_taskReadMQTTQosOperation;
    }else if ([msgID isEqualToString:@"69"]) {
        //读取MQTT 订阅主题
        resultDic = [MKNBHMQTTDataParser parseReadMQTTTopicData:json];
        operationID = mk_nbh_server_taskReadMQTTSubscribeTopicOperation;
    }else if ([msgID isEqualToString:@"6a"]) {
        //读取MQTT 发布主题
        resultDic = [MKNBHMQTTDataParser parseReadMQTTTopicData:json];
        operationID = mk_nbh_server_taskReadMQTTPublishTopicOperation;
    }else if ([msgID isEqualToString:@"6b"]) {
        //读取MQTT 遗嘱功能开关
        resultDic = [MKNBHMQTTDataParser parseStateData:json];
        operationID = mk_nbh_server_taskReadMQTTLWTStatusOperation;
    }else if ([msgID isEqualToString:@"6c"]) {
        //读取MQTT 遗嘱Qos
        resultDic = [MKNBHMQTTDataParser parseReadQosData:json];
        operationID = mk_nbh_server_taskReadMQTTLWTQosOperation;
    }else if ([msgID isEqualToString:@"6d"]) {
        //读取MQTT 遗嘱Retain
        resultDic = [MKNBHMQTTDataParser parseStateData:json];
        operationID = mk_nbh_server_taskReadMQTTLWTRetainOperation;
    }else if ([msgID isEqualToString:@"6e"]) {
        //读取MQTT 遗嘱主题
        resultDic = [MKNBHMQTTDataParser parseReadMQTTTopicData:json];
        operationID = mk_nbh_server_taskReadMQTTLWTTopicOperation;
    }else if ([msgID isEqualToString:@"6f"]) {
        //读取MQTT 遗嘱Payload
        resultDic = [MKNBHMQTTDataParser parseReadMQTTLWTPayloadData:json];
        operationID = mk_nbh_server_taskReadMQTTLWTPayloadOperation;
    }else if ([msgID isEqualToString:@"70"]) {
        //读取加密方式
        resultDic = [MKNBHMQTTDataParser parseReadMQTTSSLStatusData:json];
        operationID = mk_nbh_server_taskReadMQTTSSLStatusOperation;
    }else if ([msgID isEqualToString:@"71"]) {
        //读取APN
        resultDic = [MKNBHMQTTDataParser parseReadAPNData:json];
        operationID = mk_nbh_server_taskReadAPNOperation;
    }else if ([msgID isEqualToString:@"72"]) {
        //读取APN用户名
        resultDic = [MKNBHMQTTDataParser parseReadMQTTUsernameData:json];
        operationID = mk_nbh_server_taskReadAPNUsernameOperation;
    }else if ([msgID isEqualToString:@"73"]) {
        //读取APN密码
        resultDic = [MKNBHMQTTDataParser parseReadMQTTPasswordData:json];
        operationID = mk_nbh_server_taskReadAPNPasswordOperation;
    }else if ([msgID isEqualToString:@"74"]) {
        //读取网络制式
        resultDic = [MKNBHMQTTDataParser parseReadNetwordPriorityData:json];
        operationID = mk_nbh_server_taskReadNetwordPriorityOperation;
    }else if ([msgID isEqualToString:@"79"]) {
        //读取设备MQTT服务器信息
        resultDic = [MKNBHMQTTDataParser parseDeviceMQTTServerInfoDic:json];
        operationID = mk_nbh_server_taskReadDeviceMQTTServerInfoOperation;
    }
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_nbh_serverOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
