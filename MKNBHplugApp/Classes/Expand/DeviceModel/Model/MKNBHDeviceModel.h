//
//  MKNBHDeviceModel.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/14.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKNBHDeviceModelState) {
    MKNBHDeviceModelStateOffline,               //离线
    MKNBHDeviceModelStateOn,                    //开关打开
    MKNBHDeviceModelStateOff,                   //开关关闭
};

//对于MK117、MK117D设备，是否处于过载、过流、过压状态
typedef NS_ENUM(NSInteger, MKNBHDeviceOverState) {
    MKNBHDeviceOverState_normal,            //正常状态
    MKNBHDeviceOverState_overLoad,          //过载状态
    MKNBHDeviceOverState_overCurrent,       //过流状态
    MKNBHDeviceOverState_overVoltage,       //过压状态
    MKNBHDeviceOverState_underVoltage,      //欠压状态
};

//当设备离线的时候发出通知
extern NSString *const MKNBHDeviceModelOfflineNotification;

@protocol MKNBHDeviceModelDelegate <NSObject>

/// 当前设备离线
/// @param deviceID 当前设备的deviceID
- (void)nbh_deviceOfflineWithDeviceID:(NSString *)deviceID;

@end

@interface MKNBHDeviceModel : NSObject

/**
 数据交互可能存在多个设备订阅同一个topic的情况，这个时候只能通过deviceID区分设备，所以统一为topic+deviceID来区分通信数据
 */
@property (nonatomic, copy)NSString *deviceID;

/// MTQQ通信所需的ID，如果存在重复的，会出现交替上线的情况
@property (nonatomic, copy)NSString *clientID;

/**
 mac地址,对应设备读取信息参数的device_id
 */
@property (nonatomic, copy)NSString *macAddress;

/**
 设备广播名字
 */
@property (nonatomic, copy)NSString *deviceName;

/// 本地名字
@property (nonatomic, copy)NSString *localName;

@property (nonatomic, copy)NSString *deviceType;

/**
 订阅主题,当用户设置了app的订阅主题时，返回设置的订阅主题，否则返回当前model的订阅主题
 */
@property (nonatomic, copy)NSString *subscribedTopic;

/**
 发布主题,当用户设置了app的发布主题时，返回设置的发布主题，否则返回当前model的发布主题
 */
@property (nonatomic, copy)NSString *publishedTopic;

@property (nonatomic, assign)MKNBHDeviceModelState state;

/// 对于MK117、MK117D设备，是否处于过载、过流、过压状态
@property (nonatomic, assign)MKNBHDeviceOverState overState;

/// 是否有负载
@property (nonatomic, assign)BOOL loadStatus;

#pragma mark - 业务流程相关

@property (nonatomic, weak)id <MKNBHDeviceModelDelegate>delegate;

- (NSString *)currentSubscribedTopic;

- (NSString *)currentPublishedTopic;

/**
 设备列表页面的状态监控
 */
- (void)startStateMonitoringTimer;

/**
 接收到开关状态的时候，需要清除离线状态计数
 */
- (void)resetTimerCounter;

/**
 取消定时器
 */
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
