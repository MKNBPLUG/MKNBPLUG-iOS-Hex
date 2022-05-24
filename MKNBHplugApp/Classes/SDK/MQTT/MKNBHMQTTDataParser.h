//
//  MKNBHMQTTDataParser.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/5/10.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHMQTTDataParser : NSObject

#pragma mark - 读取回来的数据解析

/// 解析所有的状态，一个字节01表示打开，00表示关闭
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseStateData:(NSDictionary *)dic;

/// 解析上电默认开关状态
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadDefaultPowerOnModeData:(NSDictionary *)dic;

/// 解析开关状态和倒计时上报间隔
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadPeriodicalReportingData:(NSDictionary *)dic;

/// 解析电量上报间隔和阈值
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadPowerReportingData:(NSDictionary *)dic;

/// 解析电能存储和上报参数
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadEnergyReportingData:(NSDictionary *)dic;

/// 解析过载、过流、过压、欠压保护数据
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadOverProtectionData:(NSDictionary *)dic;

/// 解析连接成功网络指示灯状态
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadIndicatorConnectedData:(NSDictionary *)dic;

/// 解析NTP服务器参数
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadNTPServerParamsData:(NSDictionary *)dic;

/// 解析时区
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadTimezoneData:(NSDictionary *)dic;

/// 解析负载通知开关
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadloadNotificationData:(NSDictionary *)dic;

/// 解析服务器重连超时重启的时间间隔
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadConnectionTimeoutData:(NSDictionary *)dic;

/// 解析读取的设备开关状态
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadSwitchStateData:(NSDictionary *)dic;

/// 解析当前设备UTC时间
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadUTCTimeData:(NSDictionary *)dic;

/// 解析当前设备工作模式
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadDebugModeData:(NSDictionary *)dic;

/// 解析当前设备规格
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadSpecificationsData:(NSDictionary *)dic;

/// 解析当前设备功率指示灯参数
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadPowerIndicatorColorData:(NSDictionary *)dic;

#pragma mark - 解析MQTT服务器信息
/// 解析MQTT服务器地址
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadMQTTHostData:(NSDictionary *)dic;

/// 解析MQTT服务器端口号
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadMQTTPortData:(NSDictionary *)dic;

/// 解析 MQTT服务器/APN 用户名
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadMQTTUsernameData:(NSDictionary *)dic;

/// 解析 MQTT服务器/APN 密码
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadMQTTPasswordData:(NSDictionary *)dic;

/// 解析MQTT服务器Client id
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadMQTTClientIDData:(NSDictionary *)dic;

/// 解析MQTT服务器 KeepAlive
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadMQTTKeepAliveData:(NSDictionary *)dic;

/// 解析 Qos
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadQosData:(NSDictionary *)dic;

/// 解析MQTT服务器 订阅主题/发布主题/遗嘱主题
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadMQTTTopicData:(NSDictionary *)dic;

/// 解析MQTT服务器 遗嘱内容
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadMQTTLWTPayloadData:(NSDictionary *)dic;

/// 解析MQTT服务器 加密方式
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadMQTTSSLStatusData:(NSDictionary *)dic;

/// 解析APN
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadAPNData:(NSDictionary *)dic;

/// 解析网络制式
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadNetwordPriorityData:(NSDictionary *)dic;

/// 解析设备Mac地址
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadDeviceMacAddressData:(NSDictionary *)dic;

/// 解析设备信息里面的参数值
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadDeviceInfoData:(NSDictionary *)dic;

/// 解析设备当前状态
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadDeviceStateData:(NSDictionary *)dic;

/// 解析设备电量信息
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseReadElectricityData:(NSDictionary *)dic;

/// 解析设备电能数据(最近30天、当天每小时，读取和上报)
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseEnergyDataDic:(NSDictionary *)dic;

/// 解析设备总累计电能数据
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseTotalEnergyDataDic:(NSDictionary *)dic;

/// 解析设备出厂信息
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseDeviceInfoDic:(NSDictionary *)dic;

/// 解析设备当前MQTT服务器信息
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseDeviceMQTTServerInfoDic:(NSDictionary *)dic;

#pragma mark - 主动上报数据解析

/// 解析设备OTA结果
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseOTAResultData:(NSDictionary *)dic;

/// 解析设备主动上报的开关状态
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseSwitchStateData:(NSDictionary *)dic;

/// 解析设备主动上报的倒计时
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseCountdownData:(NSDictionary *)dic;

/// 解析设备主动上报的过载、过压、欠压、过流状态
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseOverStatusData:(NSDictionary *)dic;

/// 解析设备入网准备完成通知
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseDownMQTTParamsData:(NSDictionary *)dic;

/// 解析设备主动上报的电量信息
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseElectricityData:(NSDictionary *)dic;

/// 解析设备主动上报负载状态
/// @param dic 经过MKNBHMQTTSDKAdopter里面parseContentData:解析过的数据
+ (NSDictionary *)parseLoadStateData:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
