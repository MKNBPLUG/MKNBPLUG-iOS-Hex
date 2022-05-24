//
//  MKNBHMQTTDataParser.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/5/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHMQTTDataParser.h"

#import "MKMacroDefines.h"

#import "MKNBHMQTTSDKAdopter.h"

@implementation MKNBHMQTTDataParser

+ (NSDictionary *)parseStateData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    BOOL isOn = [content isEqualToString:@"01"];
    NSDictionary *dataDic = @{
        @"isOn":@(isOn),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadDefaultPowerOnModeData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSString *status = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"default_status":status,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

/*
 @{
 @"msg_id":@"01",          //命令标识符，默认开关状态
 @"msg_flag":@"00",         //@"00":读取   @"01":@"写"   @"02":设备主动上报
 @"device_id":@"0001",   //device id
 @"device_data":NSData,        //原始的数据域数据
 }
 */
+ (NSDictionary *)parseReadPeriodicalReportingData:(NSDictionary *)dic {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 8) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 16) {
        return resultDic;
    }
    NSString *switchInterval = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 8)];
    NSString *countdownInterval = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 8)];
    NSDictionary *dataDic = @{
        @"switch_interval":switchInterval,
        @"countdown_interval":countdownInterval
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

/*
 @{
 @"msg_id":@"01",          //命令标识符，默认开关状态
 @"msg_flag":@"00",         //@"00":读取   @"01":@"写"   @"02":设备主动上报
 @"device_id":@"0001",   //device id
 @"device_data":NSData,        //原始的数据域数据
 }
 */
+ (NSDictionary *)parseReadPowerReportingData:(NSDictionary *)dic {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 5) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 10) {
        return resultDic;
    }
    NSString *interval = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 8)];
    NSString *threshold = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
    NSDictionary *dataDic = @{
        @"report_interval":interval,
        @"report_threshold":threshold
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

/*
 @{
 @"msg_id":@"01",          //命令标识符，默认开关状态
 @"msg_flag":@"00",         //@"00":读取   @"01":@"写"   @"02":设备主动上报
 @"device_id":@"0001",   //device id
 @"device_data":NSData,        //原始的数据域数据
 }
 */
+ (NSDictionary *)parseReadEnergyReportingData:(NSDictionary *)dic {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 4) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 8) {
        return resultDic;
    }
    NSString *storageInterval = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
    NSString *threshold = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
    NSString *reportInterval = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
    NSDictionary *dataDic = @{
        @"storage_interval":storageInterval,
        @"storage_threshold":threshold,
        @"report_interval":reportInterval
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadOverProtectionData:(NSDictionary *)dic {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || (contenData.length != 3 && contenData.length != 4)) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || (content.length != 6 && content.length != 8)) {
        return resultDic;
    }
    BOOL isOn = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
    NSInteger valueLen = 2;
    if (content.length == 8) {
        valueLen = 4;
    }
    NSString *value = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, valueLen)];
    NSString *time = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(valueLen + 2, 2)];
    NSDictionary *dataDic = @{
        @"protection_enable":@(isOn),
        @"protection_value":value,
        @"judge_time":time
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadIndicatorConnectedData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSString *value = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"net_connected":value,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadNTPServerParamsData:(NSDictionary *)dic {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length < 3) {
        return resultDic;
    }
    NSString *isOnHex = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(0, 1)]];
    NSString *intervalHex = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(1, 2)]];
    
    BOOL isOn = [isOnHex isEqualToString:@"01"];
    NSString *interval = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:intervalHex range:NSMakeRange(0, intervalHex.length)];
    NSString *ntpHost = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(3, contenData.length - 3)] encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = @{
        @"ntp_switch":@(isOn),
        @"interval":interval,
        @"server":SafeStr(ntpHost),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadTimezoneData:(NSDictionary *)dic {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSNumber *timezone = [MKNBHMQTTSDKAdopter signedHexTurnString:content];
    NSDictionary *dataDic = @{
        @"time_zone":timezone,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadloadNotificationData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 2) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 4) {
        return resultDic;
    }
    BOOL access = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
    BOOL remove = [[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"];
    NSDictionary *dataDic = @{
        @"access":@(access),
        @"remove":@(remove),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadConnectionTimeoutData:(NSDictionary *)dic {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 2) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 4) {
        return resultDic;
    }
    NSString *timeout = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"timeout":timeout,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

/*
 @{
 @"msg_id":@"01",          //命令标识符，默认开关状态
 @"msg_flag":@"00",         //@"00":读取   @"01":@"写"   @"02":设备主动上报
 @"device_id":@"0001",   //device id
 @"device_data":NSData,        //原始的数据域数据
 }
 */
+ (NSDictionary *)parseReadSwitchStateData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 6) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 12) {
        return resultDic;
    }
    BOOL switchState = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
    BOOL loadState = [[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"];
    BOOL overload = [[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"];
    BOOL overcurrent = [[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"];
    BOOL overvoltage = [[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"];
    BOOL undervoltage = [[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"];
    NSDictionary *dataDic = @{
        @"switch_state":@(switchState),
        @"load_state":@(loadState),
        @"overload_state":@(overload),
        @"overcurrent_state":@(overcurrent),
        @"overvoltage_state":@(overvoltage),
        @"undervoltage_state":@(undervoltage),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadUTCTimeData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 4) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 8) {
        return resultDic;
    }
    NSString *time = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"time":time,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadDebugModeData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSString *mode = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"work_mode":mode,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadSpecificationsData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSString *type = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"type":type,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadPowerIndicatorColorData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 13) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 26) {
        return resultDic;
    }
    NSString *colorType = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
    NSString *blue = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
    NSString *green = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
    NSString *yellow = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 4)];
    NSString *orange = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(14, 4)];
    NSString *red = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(18, 4)];
    NSString *purple = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(22, 4)];
    
    NSDictionary *dataDic = @{
        @"led_state":colorType,
        @"blue":blue,
        @"green":green,
        @"yellow":yellow,
        @"orange":orange,
        @"red":red,
        @"purple":purple,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

#pragma mark - 解析MQTT服务器信息

+ (NSDictionary *)parseReadMQTTHostData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData)) {
        return resultDic;
    }
    NSString *host = [[NSString alloc] initWithData:contenData encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = @{
        @"host":SafeStr(host),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadMQTTPortData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 2) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 4) {
        return resultDic;
    }
    NSString *port = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"port":port,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadMQTTUsernameData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData)) {
        return resultDic;
    }
    NSString *username = [[NSString alloc] initWithData:contenData encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = @{
        @"username":SafeStr(username),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadMQTTPasswordData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData)) {
        return resultDic;
    }
    NSString *password = [[NSString alloc] initWithData:contenData encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = @{
        @"password":SafeStr(password),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadMQTTClientIDData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData)) {
        return resultDic;
    }
    NSString *clientID = [[NSString alloc] initWithData:contenData encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = @{
        @"clientID":SafeStr(clientID),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadMQTTKeepAliveData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSString *keepAlive = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"keepAlive":keepAlive,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadQosData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSString *qos = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"qos":qos,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadMQTTTopicData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData)) {
        return resultDic;
    }
    NSString *topic = [[NSString alloc] initWithData:contenData encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = @{
        @"topic":SafeStr(topic),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadMQTTLWTPayloadData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData)) {
        return resultDic;
    }
    NSString *payload = [[NSString alloc] initWithData:contenData encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = @{
        @"payload":SafeStr(payload),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadMQTTSSLStatusData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSString *sslType = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"sslType":sslType,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadAPNData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData)) {
        return resultDic;
    }
    NSString *apn = [[NSString alloc] initWithData:contenData encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = @{
        @"apn":SafeStr(apn),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadNetwordPriorityData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSString *priority = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"priority":priority,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadDeviceMacAddressData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData)) {
        return resultDic;
    }
    NSString *content = [[NSString alloc] initWithData:contenData encoding:NSUTF8StringEncoding];
    NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
    NSDictionary *dataDic = @{
        @"macAddress":[SafeStr(macAddress) uppercaseString],
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadDeviceInfoData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData)) {
        return resultDic;
    }
    NSString *param = [[NSString alloc] initWithData:contenData encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = @{
        @"param":SafeStr(param),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadDeviceStateData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 1) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 2) {
        return resultDic;
    }
    NSString *status = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    NSDictionary *dataDic = @{
        @"status":status,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseReadElectricityData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 11) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 22) {
        return resultDic;
    }
    NSString *voltage = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
    NSString *current = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
    NSString *power = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 8)];
    NSString *frequency = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(16, 4)];
    NSString *factor = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(20, 2)];
    NSDictionary *dataDic = @{
        @"voltage":voltage,
        @"current":current,
        @"power":power,
        @"frequency":frequency,
        @"factor":factor,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseEnergyDataDic:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length < 8) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length < 16) {
        return resultDic;
    }
    long long timeInterval = [MKNBHMQTTSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 8)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *timestamp = [format stringFromDate:date];
    NSString *timezone = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
    NSArray *tempDateList = [timestamp componentsSeparatedByString:@" "];
    NSString *tempDateString = tempDateList[0];
    NSArray *dateList = [tempDateString componentsSeparatedByString:@"-"];
    NSString *tempTimeString = tempDateList[1];
    NSArray *timeList = [tempTimeString componentsSeparatedByString:@":"];
    
    NSString *totalNum = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 2)];
    NSString *energyContent = [content substringFromIndex:12];
    NSMutableArray *energyList = [NSMutableArray array];
    for (NSInteger i = 0; i < [totalNum integerValue]; i ++) {
        NSString *tempEnergy = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:energyContent range:NSMakeRange(i * 4, 4)];
        [energyList addObject:tempEnergy];
    }
    
    NSDictionary *dataDic = @{
        @"year":dateList[0],
        @"month":dateList[1],
        @"day":dateList[2],
        @"hour":timeList[0],
        @"number":totalNum,
        @"energyList":energyList,
        @"timestamp":timestamp,
        @"timezone":timezone,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseTotalEnergyDataDic:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || (contenData.length != 4 && contenData.length != 9)) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || (content.length != 8 && content.length != 18)) {
        return resultDic;
    }
    NSString *value = @"";
    NSString *timestamp = @"";
    NSString *timezone = @"";
    if (content.length == 8) {
        //读取回来的总累计电能，不带时间戳和时区
        value = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    }else if (content.length == 18) {
        //设备主动上报的总累计电能，带时间戳和时区
        long long timeInterval = [MKNBHMQTTSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 8)];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        timestamp = [format stringFromDate:date];
        timezone = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
        value = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 8)];
    }
    
    
    NSDictionary *dataDic = @{
        @"energy":value,
        @"timestamp":timestamp,
        @"timezone":timezone,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseDeviceInfoDic:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length < 54) {
        return resultDic;
    }
    
    NSString *firmware = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(0, 6)] encoding:NSUTF8StringEncoding];
    NSString *tempMac = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(6, 6)]];
    NSString *macAddress = @"";
    if (tempMac.length == 12) {
        tempMac = [tempMac uppercaseString];
        macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[tempMac substringWithRange:NSMakeRange(0, 2)],[tempMac substringWithRange:NSMakeRange(2, 2)],[tempMac substringWithRange:NSMakeRange(4, 2)],[tempMac substringWithRange:NSMakeRange(6, 2)],[tempMac substringWithRange:NSMakeRange(8, 2)],[tempMac substringWithRange:NSMakeRange(10, 2)]];
    }
    
    NSString *iccid = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(12, 20)] encoding:NSUTF8StringEncoding];
    
    NSInteger dataIndex = 32;
    
    NSString *manuLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(dataIndex, 1)]];
    NSInteger manuLenValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:manuLen range:NSMakeRange(0, manuLen.length)];
    dataIndex += 1;
    NSString *manu = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(dataIndex, manuLenValue)] encoding:NSUTF8StringEncoding];
    dataIndex += manuLenValue;
    
    NSString *modeLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(dataIndex, 1)]];
    dataIndex += 1;
    NSInteger modeValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:modeLen range:NSMakeRange(0, modeLen.length)];
    NSString *mode = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(dataIndex, modeValue)] encoding:NSUTF8StringEncoding];
    dataIndex += modeValue;
    
    NSString *hardwareLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(dataIndex, 1)]];
    dataIndex += 1;
    NSInteger hardwareValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:hardwareLen range:NSMakeRange(0, hardwareLen.length)];
    NSString *hardware = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(dataIndex, hardwareValue)] encoding:NSUTF8StringEncoding];
    dataIndex += hardwareValue;
    
    NSString *IEMILen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(dataIndex, 1)]];
    dataIndex += 1;
    NSInteger IEMIValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:IEMILen range:NSMakeRange(0, IEMILen.length)];
    NSString *IEMI = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(dataIndex, IEMIValue)] encoding:NSUTF8StringEncoding];
    
    NSDictionary *dataDic = @{
        @"firmware":SafeStr(firmware),
        @"macAddress":macAddress,
        @"iccid":SafeStr(iccid),
        @"manu":SafeStr(manu),
        @"mode":SafeStr(mode),
        @"hardware":SafeStr(hardware),
        @"IEMI":SafeStr(IEMI),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseDeviceMQTTServerInfoDic:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length < 23) {
        return resultDic;
    }
    
    NSInteger index = 0;
    
    NSString *portHexValue = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 2)]];
    NSString *port = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:portHexValue range:NSMakeRange(0, portHexValue.length)];
    index += 2;
    
    NSString *cleanSessionString = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    BOOL cleanSession = [cleanSessionString isEqualToString:@"01"];
    index += 1;
    
    NSString *keepHexValue = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSString *keepAlive = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:keepHexValue range:NSMakeRange(0, keepHexValue.length)];
    index += 1;
    
    NSString *qosHexValue = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSString *qos = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:qosHexValue range:NSMakeRange(0, qosHexValue.length)];
    index += 1;
    
    NSString *lwtString = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    BOOL lwt = [lwtString isEqualToString:@"01"];
    index += 1;
    
    NSString *lwtQosHexValue = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSString *lwtQos = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:lwtQosHexValue range:NSMakeRange(0, lwtQosHexValue.length)];
    index += 1;
    
    NSString *lwtRetainString = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    BOOL lwtRetain = [lwtRetainString isEqualToString:@"01"];
    index += 1;
    
    NSString *sslHexValue = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSString *ssl = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:sslHexValue range:NSMakeRange(0, sslHexValue.length)];
    index += 1;
        
    NSString *hostLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSInteger hostValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:hostLen range:NSMakeRange(0, hostLen.length)];
    index += 1;
    NSString *host = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(index, hostValue)] encoding:NSUTF8StringEncoding];
    index += hostValue;
    
    NSString *usernameLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSInteger usernameValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:usernameLen range:NSMakeRange(0, usernameLen.length)];
    index += 1;
    NSString *username = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(index, usernameValue)] encoding:NSUTF8StringEncoding];
    index += usernameValue;
    
    NSString *passwordLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSInteger passwordValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:passwordLen range:NSMakeRange(0, passwordLen.length)];
    index += 1;
    NSString *password = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(index, passwordValue)] encoding:NSUTF8StringEncoding];
    index += passwordValue;
    
    NSString *clientIDLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSInteger clientIDValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:clientIDLen range:NSMakeRange(0, clientIDLen.length)];
    index += 1;
    NSString *clientID = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(index, clientIDValue)] encoding:NSUTF8StringEncoding];
    index += clientIDValue;
    
    NSString *subTopicLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSInteger subTopicValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:subTopicLen range:NSMakeRange(0, subTopicLen.length)];
    index += 1;
    NSString *subTopic = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(index, subTopicValue)] encoding:NSUTF8StringEncoding];
    index += subTopicValue;
    
    NSString *pubTopicLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSInteger pubTopicValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:pubTopicLen range:NSMakeRange(0, pubTopicLen.length)];
    index += 1;
    NSString *pubTopic = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(index, pubTopicValue)] encoding:NSUTF8StringEncoding];
    index += pubTopicValue;
    
    NSString *lwtTopicLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSInteger lwtTopicValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:lwtTopicLen range:NSMakeRange(0, lwtTopicLen.length)];
    index += 1;
    NSString *lwtTopic = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(index, lwtTopicValue)] encoding:NSUTF8StringEncoding];
    index += lwtTopicValue;
    
    NSString *payloadLen = [MKNBHMQTTSDKAdopter hexStringFromData:[contenData subdataWithRange:NSMakeRange(index, 1)]];
    NSInteger payloadValue = [MKNBHMQTTSDKAdopter getDecimalWithHex:payloadLen range:NSMakeRange(0, payloadLen.length)];
    index += 1;
    NSString *payload = [[NSString alloc] initWithData:[contenData subdataWithRange:NSMakeRange(index, payloadValue)] encoding:NSUTF8StringEncoding];
    
    NSDictionary *dataDic = @{
        @"port":SafeStr(port),
        @"cleanSession":@(cleanSession),
        @"keepAlive":SafeStr(keepAlive),
        @"qos":SafeStr(qos),
        @"lwt":@(lwt),
        @"lwtQos":SafeStr(lwtQos),
        @"lwtRetain":@(lwtRetain),
        @"sslType":SafeStr(ssl),
        @"host":SafeStr(host),
        @"username":SafeStr(username),
        @"password":SafeStr(password),
        @"clientID":SafeStr(clientID),
        @"subscribedTopic":SafeStr(subTopic),
        @"publishedTopic":SafeStr(pubTopic),
        @"lwtTopic":SafeStr(lwtTopic),
        @"payload":SafeStr(payload),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

#pragma mark - 主动上报数据解析
+ (NSDictionary *)parseOTAResultData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 7) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 14) {
        return resultDic;
    }
    long long timeInterval = [MKNBHMQTTSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 8)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *timestamp = [format stringFromDate:date];
    NSString *timezone = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
    NSString *otaType = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 2)];
    BOOL success = [[content substringWithRange:NSMakeRange(12, 2)] isEqualToString:@"01"];
    NSDictionary *dataDic = @{
        @"ota_type":otaType,
        @"ota_result":@(success),
        @"timestamp":timestamp,
        @"timezone":timezone,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseSwitchStateData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 11) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 22) {
        return resultDic;
    }
    long long timeInterval = [MKNBHMQTTSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 8)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *timestamp = [format stringFromDate:date];
    NSString *timezone = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
    BOOL switchState = [[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"];
    BOOL loadState = [[content substringWithRange:NSMakeRange(12, 2)] isEqualToString:@"01"];
    BOOL overload = [[content substringWithRange:NSMakeRange(14, 2)] isEqualToString:@"01"];
    BOOL overcurrent = [[content substringWithRange:NSMakeRange(16, 2)] isEqualToString:@"01"];
    BOOL overvoltage = [[content substringWithRange:NSMakeRange(18, 2)] isEqualToString:@"01"];
    BOOL undervoltage = [[content substringWithRange:NSMakeRange(20, 2)] isEqualToString:@"01"];
    NSDictionary *dataDic = @{
        @"switch_state":@(switchState),
        @"load_state":@(loadState),
        @"overload_state":@(overload),
        @"overcurrent_state":@(overcurrent),
        @"overvoltage_state":@(overvoltage),
        @"undervoltage_state":@(undervoltage),
        @"timestamp":timestamp,
        @"timezone":timezone,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseCountdownData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 10) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 20) {
        return resultDic;
    }
    long long timeInterval = [MKNBHMQTTSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 8)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *timestamp = [format stringFromDate:date];
    NSString *timezone = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
    BOOL isOn = [[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"];
    NSString *countdown = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(12, 8)];
    NSDictionary *dataDic = @{
        @"timestamp":timestamp,
        @"timezone":timezone,
        @"isOn":@(isOn),
        @"countdown":countdown
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseOverStatusData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 6) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 12) {
        return resultDic;
    }
    long long timeInterval = [MKNBHMQTTSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 8)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *timestamp = [format stringFromDate:date];
    NSString *timezone = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
    BOOL normal = [[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"];
    NSDictionary *dataDic = @{
        @"timestamp":timestamp,
        @"timezone":timezone,
        @"over":@(normal),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseDownMQTTParamsData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 6) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 12) {
        return resultDic;
    }
    long long timeInterval = [MKNBHMQTTSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 8)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *timestamp = [format stringFromDate:date];
    NSString *timezone = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
    BOOL success = [[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"];
    NSDictionary *dataDic = @{
        @"result":@(success),
        @"timestamp":timestamp,
        @"timezone":timezone,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseElectricityData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 16) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 32) {
        return resultDic;
    }
    long long timeInterval = [MKNBHMQTTSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 8)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *timestamp = [format stringFromDate:date];
    NSString *timezone = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];

    NSString *voltage = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 4)];
    NSString *current = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(14, 4)];
    NSString *power = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(18, 8)];
    NSString *frequency = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(26, 4)];
    NSString *factor = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(30, 2)];
   
    NSDictionary *dataDic = @{
        @"voltage":voltage,
        @"current":current,
        @"power":power,
        @"frequency":frequency,
        @"factor":factor,
        @"timestamp":timestamp,
        @"timezone":timezone,
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

+ (NSDictionary *)parseLoadStateData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return @{};
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSData *contenData = dic[@"device_data"];
    if (!ValidData(contenData) || contenData.length != 6) {
        return resultDic;
    }
    NSString *content = [MKNBHMQTTSDKAdopter hexStringFromData:contenData];
    if (!ValidStr(content) || content.length != 12) {
        return resultDic;
    }
    long long timeInterval = [MKNBHMQTTSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 8)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *timestamp = [format stringFromDate:date];
    NSString *timezone = [MKNBHMQTTSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
    BOOL load = [[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"];
    NSDictionary *dataDic = @{
        @"timestamp":timestamp,
        @"timezone":timezone,
        @"load":@(load),
    };
    [resultDic setObject:dataDic forKey:@"data"];
    return resultDic;
}

@end
