//
//  MKNBHMQTTSDKAdopter.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/5/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHMQTTSDKAdopter : NSObject

+ (NSError *)getErrorWithCode:(NSInteger)code message:(NSString *)message;
+ (void)operationCentralBlePowerOffBlock:(void (^)(NSError *error))block;
+ (void)operationConnectFailedBlock:(void (^)(NSError *error))block;
+ (void)operationConnectingErrorBlock:(void (^)(NSError *error))block;
+ (void)operationProtocolErrorBlock:(void (^)(NSError *error))block;
+ (void)operationParamsErrorBlock:(void (^)(NSError *error))block;
+ (void)operationSetParamsErrorBlock:(void (^)(NSError *error))block;

/// 设备上报的数据解析
/*
 @{
 @"msg_id":@"01",          //命令标识符，默认开关状态
 @"msg_flag":@"00",         //@"00":读取   @"01":@"写"   @"02":设备主动上报
 @"device_id":@"0001",   //device id
 @"device_data":NSData,        //原始的数据域数据
 }
 */
/// @param data 设备上报的数据
+ (NSDictionary *)parseContentData:(NSData *)data;

//将deviceID转换成命令里面的Len+DeviceID
+ (NSString *)parseDeviceIDToCmd:(NSString *)deviceID;

/// 将16进制字符串content指定位置的字符串转换成10进制数字
/// @param content 16进制字符串
/// @param range 要转换的位置
+ (NSInteger)getDecimalWithHex:(NSString *)content range:(NSRange)range;

/// 将16进制字符串content指定位置的字符串转换成10进制字符串
/// @param content 16进制字符串
/// @param range 要转换的位置
+ (NSString *)getDecimalStringWithHex:(NSString *)content range:(NSRange)range;

/// 有符号10进制转16进制字符串
/// @param number number
+ (NSString *)hexStringFromSignedNumber:(NSInteger)number;

/**
 有符号16进制转10进制

 @param content signed number
 @return number
 */
+ (NSNumber *)signedHexTurnString:(NSString *)content;

/// 获取CRC16校验码
/// @param data data
+ (NSData *)getCrc16VerifyCode:(NSData *)data;

/// 将NSData转换成对应的16进制字符
/// @param sourceData sourceData
+ (NSString *)hexStringFromData:(NSData *)sourceData;

/// 将十六进制字符转换成对应的NSData
/// @param dataString dataString
+ (NSData *)stringToData:(NSString *)dataString;

/// 判断一个字符是否是16进制字符
/// @param character character
+ (BOOL)checkHexCharacter:(NSString *)character;

/**
 将一个字节的16进制数据转成8位2进制
 
 @param hex 需要转换的16进制数据
 @return 转换后的8位2进制数据
 */
+ (NSString *)binaryByhex:(NSString *)hex;

/// 判断一个string是否全部是ascii码
/// @param content content
+ (BOOL)asciiString:(NSString *)content;

/// 判断某个字符串是不是uuid
/// @param uuid [0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}
+ (BOOL)isUUIDString:(NSString *)uuid;

/**
 二进制转换成一个字节的十六进制
 
 @param binary 二进制数
 @return 十六进制数
 */
+ (NSString *)getHexByBinary:(NSString *)binary;

/// 将一个十进制的数据转换成对应byteLen字节长度的十六进制数据，
/*
 [MKBGSDKDataAdopter fetchHexValue:10 byteLen:4] ==>@"0000000a"
 [MKBGSDKDataAdopter fetchHexValue:10 byteLen:1] ==>@"0a"
 */
/// @param value 十进制
/// @param byteLen 字节长度
+ (NSString *)fetchHexValue:(unsigned long)value byteLen:(NSInteger)len;

+ (NSString *)fetchAsciiCode:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
