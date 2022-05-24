//
//  MKNBHIndicatorColorCell.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHIndicatorColorCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *placeholder;

@property (nonatomic, copy)NSString *textValue;

@property (nonatomic, assign)NSInteger index;

@end

@protocol MKNBHIndicatorColorCellDelegate <NSObject>

- (void)nbh_ledColorChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKNBHIndicatorColorCell : MKBaseCell

@property (nonatomic, strong)MKNBHIndicatorColorCellModel *dataModel;

@property (nonatomic, weak)id <MKNBHIndicatorColorCellDelegate>delegate;

+ (MKNBHIndicatorColorCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
