//
//  MKNBHModifyServerSettingView.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2021/12/6.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHModifyServerSettingViewModel : NSObject

/// 0-128 Characters
@property (nonatomic, copy)NSString *apn;

/// 0-128 Characters
@property (nonatomic, copy)NSString *networkUsername;

/// 0-128 Characters
@property (nonatomic, copy)NSString *networkPassword;

/*
 0:eMTC->NB-IOT->GSM
 1:eMTC-> GSM -> NB-IOT
 2:NB-IOT->GSM-> eMTC
 3:NB-IOT-> eMTC-> GSM
 4:GSM -> NB-IOT-> eMTC
 5:GSM -> eMTC->NB-IOT
 6:eMTC->NB-IOT
 7:NB-IOT-> eMTC
 8:GSM
 9:NB-IOT
 10:eMTC
 */
@property (nonatomic, assign)NSInteger networkPriority;

@end

@protocol MKNBHModifyServerSettingViewDelegate <NSObject>

/// 输入框内容发生改变
/// @param text 当前输入框内容
/// @param textID 0:APN  1:UserName  2:Password
- (void)nbh_mqtt_modifyDevice_textChanged:(NSString *)text textID:(NSInteger)textID;

/*
 0:eMTC->NB-IOT->GSM
 1:eMTC-> GSM -> NB-IOT
 2:NB-IOT->GSM-> eMTC
 3:NB-IOT-> eMTC-> GSM
 4:GSM -> NB-IOT-> eMTC
 5:GSM -> eMTC->NB-IOT
 6:eMTC->NB-IOT
 7:NB-IOT-> eMTC
 8:GSM
 9:NB-IOT
 10:eMTC
 */
- (void)nbh_mqtt_modifyDevice_networkPriorityChanged:(NSInteger)priority;

@end

@interface MKNBHModifyServerSettingView : UIView

@property (nonatomic, strong)MKNBHModifyServerSettingViewModel *dataModel;

@property (nonatomic, weak)id <MKNBHModifyServerSettingViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
