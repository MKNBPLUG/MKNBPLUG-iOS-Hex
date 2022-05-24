//
//  MKNBHIndicatorColorHeaderView.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKNBHIndicatorColorHeaderViewDelegate <NSObject>

/// 用户选择了color
/// @param colorType 对应的结果如下:
/*
 nbh_ledColorTransitionDirectly,
 nbh_ledColorTransitionSmoothly,
 nbh_ledColorWhite,
 nbh_ledColorRed,
 nbh_ledColorGreen,
 nbh_ledColorBlue,
 nbh_ledColorOrange,
 nbh_ledColorCyan,
 nbh_ledColorPurple,
 */
- (void)nbh_colorSettingPickViewTypeChanged:(NSInteger)colorType;

@end

@interface MKNBHIndicatorColorHeaderView : UIView

@property (nonatomic, weak)id <MKNBHIndicatorColorHeaderViewDelegate>delegate;

/// 更新当前选中的color
/// @param colorType 对应的结果如下:
/*
 nbh_ledColorTransitionDirectly,
 nbh_ledColorTransitionSmoothly,
 nbh_ledColorWhite,
 nbh_ledColorRed,
 nbh_ledColorGreen,
 nbh_ledColorBlue,
 nbh_ledColorOrange,
 nbh_ledColorCyan,
 nbh_ledColorPurple,
 */
- (void)updateColorType:(NSInteger)colorType;

@end

NS_ASSUME_NONNULL_END
