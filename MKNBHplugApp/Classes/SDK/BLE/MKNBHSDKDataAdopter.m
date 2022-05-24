//
//  MKNBHSDKDataAdopter.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHSDKDataAdopter.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKNBHSDKDataAdopter

+ (NSString *)fetchAsciiCode:(NSString *)value {
    if (!MKValidStr(value)) {
        return @"";
    }
    NSString *tempString = @"";
    for (NSInteger i = 0; i < value.length; i ++) {
        int asciiCode = [value characterAtIndex:i];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    return tempString;
}

+ (NSString *)fetchMqttServerQosMode:(mk_nbh_mqttServerQosMode)mode {
    switch (mode) {
        case mk_nbh_mqttQosLevelAtMostOnce:
            return @"00";
        case mk_nbh_mqttQosLevelAtLeastOnce:
            return @"01";
        case mk_nbh_mqttQosLevelExactlyOnce:
            return @"02";
    }
}

+ (NSString *)fetchConnectModeString:(mk_nbh_connectMode)mode {
    switch (mode) {
        case mk_nbh_connectMode_TCP:
            return @"00";
        case mk_nbh_connectMode_CACertificate:
            return @"01";
        case mk_nbh_connectMode_SelfSignedCertificates:
            return @"02";
    }
}

+ (NSString *)fetchNetworkPriority:(mk_nbh_networkPriority)priority {
    switch (priority) {
        case mk_nbh_networkPriority_eMTC_nbh_IOT_GSM:
            return @"00";
        case mk_nbh_networkPriority_eMTC_GSM_nbh_IOT:
            return @"01";
        case mk_nbh_networkPriority_nbh_IOT_GSM_eMTC:
            return @"02";
        case mk_nbh_networkPriority_nbh_IOT_eMTC_GSM:
            return @"03";
        case mk_nbh_networkPriority_GSM_nbh_IOT_eMTC:
            return @"04";
        case mk_nbh_networkPriority_GSM_eMTC_nbh_IOT:
            return @"05";
        case mk_nbh_networkPriority_eMTC_nbh_IOT:
            return @"06";
        case mk_nbh_networkPriority_nbh_IOT_eMTC:
            return @"07";
        case mk_nbh_networkPriority_GSM:
            return @"08";
        case mk_nbh_networkPriority_nbh_IOT:
            return @"09";
        case mk_nbh_networkPriority_eMTC:
            return @"0a";
    }
}

+ (NSString *)fetchDataFormat:(mk_nbh_dataFormat)format {
    switch (format) {
        case mk_nbh_dataFormat_json:
            return @"00";
        case mk_nbh_dataFormat_hex:
            return @"01";
    }
}

+ (NSString *)fetchWorkMode:(mk_nbh_workMode)mode {
    switch (mode) {
        case mk_nbh_workMode_rc:
            return @"00";
        case mk_nbh_workMode_debug:
            return @"01";
    }
}

@end
