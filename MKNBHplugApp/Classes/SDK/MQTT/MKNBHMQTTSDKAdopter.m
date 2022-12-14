//
//  MKNBHMQTTSDKAdopter.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/5/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHMQTTSDKAdopter.h"

#import "MKMacroDefines.h"

@implementation MKNBHMQTTSDKAdopter

+ (NSError *)getErrorWithCode:(NSInteger)code message:(NSString *)message {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.BLESDK"
                                                code:code
                                            userInfo:@{@"errorInfo":message}];
    return error;
}

+ (void)operationCentralBlePowerOffBlock:(void (^)(NSError *error))block{
    moko_dispatch_main_safe(^{
        if (block) {
            NSError *error = [self getErrorWithCode:-10001 message:@"Mobile phone bluetooth is currently unavailable"];
            block(error);
        }
    });
}

+ (void)operationConnectFailedBlock:(void (^)(NSError *error))block{
    moko_dispatch_main_safe(^{
        if (block) {
            NSError *error = [self getErrorWithCode:-10001 message:@"Connect Failed"];
            block(error);
        }
    });
}

+ (void)operationConnectingErrorBlock:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        if (block) {
            NSError *error = [self getErrorWithCode:-10001 message:@"The devices are connectting"];
            block(error);
        }
    });
}

+ (void)operationProtocolErrorBlock:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        if (block) {
            NSError *error = [self getErrorWithCode:-10001 message:@"The parameters passed in must conform to the protocol"];
            block(error);
        }
    });
}

+ (void)operationParamsErrorBlock:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        if (block) {
            NSError *error = [self getErrorWithCode:10001 message:@"Params error"];
            block(error);
        }
    });
}

+ (void)operationSetParamsErrorBlock:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        if (block) {
            NSError *error = [self getErrorWithCode:-10001 message:@"Set parameter error"];
            block(error);
        }
    });
}

+ (NSDictionary *)parseContentData:(NSData *)data {
    if (!ValidData(data) || data.length < 7) {
        return @{};
    }
    NSString *header = [self hexStringFromData:[data subdataWithRange:NSMakeRange(0, 1)]];
    if (![header isEqualToString:@"ed"]) {
        return @{};
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *flag = [self hexStringFromData:[data subdataWithRange:NSMakeRange(1, 1)]];
    [dic setObject:flag forKey:@"msg_flag"];
    NSString *cmd = [self hexStringFromData:[data subdataWithRange:NSMakeRange(2, 1)]];
    [dic setObject:cmd forKey:@"msg_id"];
    NSString *deviceIDLen = [self hexStringFromData:[data subdataWithRange:NSMakeRange(3, 1)]];
    NSInteger deviceIDLenValue = [self getDecimalWithHex:deviceIDLen range:NSMakeRange(0, deviceIDLen.length)];
    if (data.length < (4 + deviceIDLenValue)) {
        return @{};
    }
    NSString *deviceID =  [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, deviceIDLenValue)] encoding:NSUTF8StringEncoding];
    [dic setObject:deviceID forKey:@"device_id"];
    NSString *dataLen = [self hexStringFromData:[data subdataWithRange:NSMakeRange(4 + deviceIDLenValue, 2)]];
    NSInteger dataLenValue = [self getDecimalWithHex:dataLen range:NSMakeRange(0, dataLen.length)];
    if (dataLenValue > 0) {
        NSData *contentData = [data subdataWithRange:NSMakeRange(4 + deviceIDLenValue + 2, dataLenValue)];
        [dic setObject:contentData forKey:@"device_data"];
    }
    return dic;
}

+ (NSString *)parseDeviceIDToCmd:(NSString *)deviceID {
    if (!ValidStr(deviceID)) {
        return @"";
    }
    NSString *asciiID = [self fetchAsciiCode:deviceID];
    NSString *len = [self fetchHexValue:deviceID.length byteLen:1];
    return [len stringByAppendingString:asciiID];
}

+ (NSInteger)getDecimalWithHex:(NSString *)content range:(NSRange)range{
    if (!ValidStr(content)) {
        return 0;
    }
    for (NSInteger i = 0; i < content.length; i ++) {
        if (![self checkHexCharacter:[content substringWithRange:NSMakeRange(i, 1)]]) {
            return 0;
        }
    }
    if (range.location > content.length - 1 || range.length > content.length || (range.location + range.length > content.length)) {
        return 0;
    }
    return strtoul([[content substringWithRange:range] UTF8String],0,16);
}
+ (NSString *)getDecimalStringWithHex:(NSString *)content range:(NSRange)range{
    NSInteger decimalValue = [self getDecimalWithHex:content range:range];
    return [NSString stringWithFormat:@"%ld",(long)decimalValue];
}

+ (NSString *)hexStringFromSignedNumber:(NSInteger)number {
    NSString *tempNumber = [NSString stringWithFormat:@"%lX", (long)number];
    if (tempNumber.length == 1) {
        tempNumber = [@"0" stringByAppendingString:tempNumber];
    }
    NSData *data = [self stringToData:tempNumber];
    NSData *resultData = [data subdataWithRange:NSMakeRange(data.length - 1, 1)];
    return [self hexStringFromData:resultData];
}

+ (NSNumber *)signedHexTurnString:(NSString *)content{
    if (!ValidStr(content)) {
        return @(0);
    }
    NSData *tempData = [self stringToData:content];
    NSInteger lenth = [tempData length];
    NSString *maxHexString = [self headString:@"F" trilString:@"F" strLenth:lenth];
    NSString *centerHexString = [self headString:@"8" trilString:@"0" strLenth:lenth];
    if ([[self numberHexString:content] longLongValue] - [[self numberHexString:centerHexString] longLongValue] < 0) {
        return [self numberHexString:content];
    }
    unsigned long long maxValue = [[self numberHexString:content] longLongValue];
    unsigned long long minValue = [[self numberHexString:maxHexString] longLongValue];
    return [NSNumber numberWithLongLong:(maxValue - minValue - 1)];
}

+ (NSData *)getCrc16VerifyCode:(NSData *)data{
    if (!ValidData(data)) {
        return [NSData data];
    }
    NSInteger crcWord = 0xffff;
    Byte *dataArray = (Byte *)[data bytes];
    for (NSInteger i = 0; i < data.length; i ++) {
        Byte byte = dataArray[i];
        crcWord ^= (NSInteger)byte & 0x00ff;
        for (NSInteger j = 0; j < 8; j ++) {
            if ((crcWord & 0x0001) == 1) {
                crcWord = crcWord >> 1;
                crcWord = crcWord ^ 0xA001;
            }else{
                crcWord = (crcWord >> 1);
            }
        }
    }
    
    Byte crcL = (Byte)0xff & (crcWord >> 8);
    Byte crcH = (Byte)0xff & (crcWord);
    Byte arrayCrc[] = {crcH, crcL};
    NSData *dataCrc = [NSData dataWithBytes:arrayCrc length:sizeof(arrayCrc)];
    return dataCrc;
}

+ (NSString *)hexStringFromData:(NSData *)sourceData{
    if (!ValidData(sourceData)) {
        return @"";
    }
    Byte *bytes = (Byte *)[sourceData bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[sourceData length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+ (NSData *)stringToData:(NSString *)dataString{
    if (!ValidStr(dataString)) {
        return [NSData data];
    }
        
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([dataString length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [dataString length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [dataString substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

+ (BOOL)checkHexCharacter:(NSString *)character {
    if (!ValidStr(character)) {
        return NO;
    }
    NSString *regex = @"[a-fA-F0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:character];
}

+ (NSString *)binaryByhex:(NSString *)hex {
    if (!ValidStr(hex) || hex.length != 2 || ![self checkHexCharacter:hex]) {
        return @"";
    }
    NSDictionary *hexDic = @{
                             @"0":@"0000",@"1":@"0001",@"2":@"0010",
                             @"3":@"0011",@"4":@"0100",@"5":@"0101",
                             @"6":@"0110",@"7":@"0111",@"8":@"1000",
                             @"9":@"1001",@"A":@"1010",@"a":@"1010",
                             @"B":@"1011",@"b":@"1011",@"C":@"1100",
                             @"c":@"1100",@"D":@"1101",@"d":@"1101",
                             @"E":@"1110",@"e":@"1110",@"F":@"1111",
                             @"f":@"1111",
                             };
    NSString *binaryString = @"";
    for (int i=0; i<[hex length]; i++) {
        NSRange rage;
        rage.length = 1;
        rage.location = i;
        NSString *key = [hex substringWithRange:rage];
        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,
                        [NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    return binaryString;
}

+ (BOOL)asciiString:(NSString *)content {
    NSInteger strlen = content.length;
    NSInteger datalen = [[content dataUsingEncoding:NSUTF8StringEncoding] length];
    if (strlen != datalen) {
        return NO;
    }
    return YES;
}

+ (BOOL)isUUIDString:(NSString *)uuid{
    NSString *uuidPatternString = @"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:uuidPatternString
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSInteger numberOfMatches = [regex numberOfMatchesInString:uuid
                                                       options:kNilOptions
                                                         range:NSMakeRange(0, uuid.length)];
    return (numberOfMatches > 0);
}

+ (NSString *)getHexByBinary:(NSString *)binary {
    NSMutableDictionary *binaryDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [binaryDic setObject:@"0" forKey:@"0000"];
    [binaryDic setObject:@"1" forKey:@"0001"];
    [binaryDic setObject:@"2" forKey:@"0010"];
    [binaryDic setObject:@"3" forKey:@"0011"];
    [binaryDic setObject:@"4" forKey:@"0100"];
    [binaryDic setObject:@"5" forKey:@"0101"];
    [binaryDic setObject:@"6" forKey:@"0110"];
    [binaryDic setObject:@"7" forKey:@"0111"];
    [binaryDic setObject:@"8" forKey:@"1000"];
    [binaryDic setObject:@"9" forKey:@"1001"];
    [binaryDic setObject:@"A" forKey:@"1010"];
    [binaryDic setObject:@"B" forKey:@"1011"];
    [binaryDic setObject:@"C" forKey:@"1100"];
    [binaryDic setObject:@"D" forKey:@"1101"];
    [binaryDic setObject:@"E" forKey:@"1110"];
    [binaryDic setObject:@"F" forKey:@"1111"];
    
    if (binary.length % 4 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    NSString *hex = @"";
    for (int i=0; i<binary.length; i+=4) {
        
        NSString *key = [binary substringWithRange:NSMakeRange(i, 4)];
        NSString *value = [binaryDic objectForKey:key];
        if (value) {
            
            hex = [hex stringByAppendingString:value];
        }
    }
    return hex;
}

+ (NSString *)fetchHexValue:(unsigned long)value byteLen:(NSInteger)len {
    if (len <= 0) {
        return @"";
    }
    NSString *valueString = [NSString stringWithFormat:@"%1lx",(unsigned long)value];
    NSInteger needLen = 2 * len - valueString.length;
    for (NSInteger i = 0; i < needLen; i ++) {
        valueString = [@"0" stringByAppendingString:valueString];
    }
    return valueString;
}

+ (NSString *)fetchAsciiCode:(NSString *)value {
    if (!ValidStr(value)) {
        return @"";
    }
    NSString *tempString = @"";
    for (NSInteger i = 0; i < value.length; i ++) {
        int asciiCode = [value characterAtIndex:i];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    return tempString;
}

#pragma mark - private method

// 16进制转10进制
+ (NSNumber *) numberHexString:(NSString *)aHexString {
    if (nil == aHexString) {
        return nil;
    }
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    unsigned long long longlongValue;
    [scanner scanHexLongLong:&longlongValue];
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    return hexNumber;
}

+ (NSString *)headString:(NSString *)headStr trilString:(NSString *)trilStr strLenth:(NSInteger)lenth {
    if (!headStr || !trilStr) {
        return nil;
    }
    NSMutableString *string = [NSMutableString stringWithFormat:@"0x%@", headStr];
    for (int i = 0; i < lenth * 2 - 1; i++)
    {
        [string appendString:trilStr];
    }
    return string;
}

@end
