//
//  MKNBHEnergyDataCell.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/1.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHEnergyDataCellModel : NSObject

@property (nonatomic, copy)NSString *leftMsg;

@property (nonatomic, copy)NSString *rightMsg;

@end

@interface MKNBHEnergyDataCell : MKBaseCell

@property (nonatomic, strong)MKNBHEnergyDataCellModel *dataModel;

+ (MKNBHEnergyDataCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
