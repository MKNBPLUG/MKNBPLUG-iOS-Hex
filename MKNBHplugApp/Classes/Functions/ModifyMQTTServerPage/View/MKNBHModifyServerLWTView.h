//
//  MKNBHModifyServerLWTView.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHModifyServerLWTViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKNBHModifyServerLWTViewDelegate <NSObject>

- (void)nbh_lwt_modifyDevice_statusChanged:(BOOL)isOn;

- (void)nbh_lwt_modifyDevice_retainChanged:(BOOL)isOn;

- (void)nbh_lwt_modifyDevice_qosChanged:(NSInteger)qos;

- (void)nbh_lwt_modifyDevice_topicChanged:(NSString *)text;

- (void)nbh_lwt_modifyDevice_payloadChanged:(NSString *)text;

@end

@interface MKNBHModifyServerLWTView : UIView

@property (nonatomic, strong)MKNBHModifyServerLWTViewModel *dataModel;

@property (nonatomic, weak)id <MKNBHModifyServerLWTViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
