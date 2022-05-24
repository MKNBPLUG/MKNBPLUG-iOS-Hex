//
//  MKNBHMQTTLWTForDeviceView.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/15.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHMQTTLWTForDeviceViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKNBHMQTTLWTForDeviceViewDelegate <NSObject>

- (void)nbh_lwt_statusChanged:(BOOL)isOn;

- (void)nbh_lwt_retainChanged:(BOOL)isOn;

- (void)nbh_lwt_qosChanged:(NSInteger)qos;

- (void)nbh_lwt_topicChanged:(NSString *)text;

- (void)nbh_lwt_payloadChanged:(NSString *)text;

@end

@interface MKNBHMQTTLWTForDeviceView : UIView

@property (nonatomic, strong)MKNBHMQTTLWTForDeviceViewModel *dataModel;

@property (nonatomic, weak)id <MKNBHMQTTLWTForDeviceViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
