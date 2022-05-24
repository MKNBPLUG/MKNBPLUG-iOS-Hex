//
//  MKNBHMQTTSettingForDeviceCell.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/27.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHMQTTSettingForDeviceCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *rightMsg;

- (CGFloat)fetchCellHeight;

@end

@interface MKNBHMQTTSettingForDeviceCell : MKBaseCell

@property (nonatomic, strong)MKNBHMQTTSettingForDeviceCellModel *dataModel;

+ (MKNBHMQTTSettingForDeviceCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
