//
//  MKNBHDeviceListCell.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class MKNBHDeviceModel;

@protocol MKNBHDeviceListCellDelegate <NSObject>

/// 用户点击开关按钮
/// @param deviceModel deviceModel
- (void)nbh_deviceStateChanged:(MKNBHDeviceModel *)deviceModel;

/**
 删除
 
 @param index 所在index
 */
- (void)nbh_cellDeleteButtonPressed:(NSInteger)index;

@end

@interface MKNBHDeviceListCell : MKBaseCell

@property (nonatomic, strong)MKNBHDeviceModel *dataModel;

@property (nonatomic, weak)id <MKNBHDeviceListCellDelegate>delegate;

+ (MKNBHDeviceListCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
