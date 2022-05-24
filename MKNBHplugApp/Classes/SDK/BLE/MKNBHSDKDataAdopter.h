//
//  MKNBHSDKDataAdopter.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKNBHSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHSDKDataAdopter : NSObject

+ (NSString *)fetchAsciiCode:(NSString *)value;

+ (NSString *)fetchMqttServerQosMode:(mk_nbh_mqttServerQosMode)mode;

+ (NSString *)fetchConnectModeString:(mk_nbh_connectMode)mode;

+ (NSString *)fetchNetworkPriority:(mk_nbh_networkPriority)priority;

+ (NSString *)fetchDataFormat:(mk_nbh_dataFormat)format;

+ (NSString *)fetchWorkMode:(mk_nbh_workMode)mode;

@end

NS_ASSUME_NONNULL_END
