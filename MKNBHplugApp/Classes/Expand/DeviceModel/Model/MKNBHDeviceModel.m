//
//  MKNBHDeviceModel.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/14.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHDeviceModel.h"

#import "MKMacroDefines.h"

#import "MKNBHMQTTServerManager.h"

NSString *const MKNBHDeviceModelOfflineNotification = @"MKNBHDeviceModelOfflineNotification";

@interface MKNBHDeviceModel ()

/**
 超过40s没有接收到信息，则认为离线
 */
@property (nonatomic, strong)dispatch_source_t receiveTimer;

@property (nonatomic, assign)NSInteger receiveTimerCount;

@property (nonatomic, assign)BOOL offline;

@end

@implementation MKNBHDeviceModel

- (void)dealloc{
    NSLog(@"MKNBHDeviceModel销毁");
}

#pragma mark - public method

- (void)startStateMonitoringTimer{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.receiveTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.receiveTimerCount = 0;
    dispatch_source_set_timer(self.receiveTimer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
    @weakify(self);
    dispatch_source_set_event_handler(self.receiveTimer, ^{
        @strongify(self);
        if (self.receiveTimerCount >= 91.f) {
            //接受数据超时
            dispatch_cancel(self.receiveTimer);
            self.receiveTimerCount = 0;
            self.offline = YES;
            self.state = MKNBHDeviceModelStateOffline;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHDeviceModelOfflineNotification
                                                                    object:nil
                                                                  userInfo:@{@"deviceID":self.deviceID}];
                if ([self.delegate respondsToSelector:@selector(nbh_deviceOfflineWithDeviceID:)]) {
                    [self.delegate nbh_deviceOfflineWithDeviceID:self.deviceID];
                }
            });
            return ;
        }
        self.receiveTimerCount ++;
    });
    dispatch_resume(self.receiveTimer);
}

- (void)resetTimerCounter{
    if (self.offline) {
        //需要重新开启定时器
        self.offline = NO;
        [self startStateMonitoringTimer];
        return;
    }
    self.receiveTimerCount = 0;
}

/**
 取消定时器
 */
- (void)cancel{
    self.receiveTimerCount = 0;
    self.offline = NO;
    if (self.receiveTimer) {
        dispatch_cancel(self.receiveTimer);
    }
}

- (NSString *)currentSubscribedTopic {
    if (ValidStr([MKNBHMQTTServerManager shared].serverParams.publishTopic)) {
        return [MKNBHMQTTServerManager shared].serverParams.publishTopic;
    }
    return self.subscribedTopic;
}

- (NSString *)currentPublishedTopic {
    if (ValidStr([MKNBHMQTTServerManager shared].serverParams.subscribeTopic)) {
        return [MKNBHMQTTServerManager shared].serverParams.subscribeTopic;
    }
    return self.publishedTopic;
}

- (void)updateWithProtocol:(MKNBHDeviceModel *)deviceModel {
    self.deviceID = deviceModel.deviceID;
    self.clientID = deviceModel.clientID;
    self.macAddress = deviceModel.macAddress;
    self.deviceName = deviceModel.deviceName;
    self.deviceType = deviceModel.deviceType;
    self.subscribedTopic = deviceModel.subscribedTopic;
    self.publishedTopic = deviceModel.publishedTopic;
    self.state = deviceModel.state;
}

@end
