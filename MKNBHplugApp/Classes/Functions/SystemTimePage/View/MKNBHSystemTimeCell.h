//
//  MKNBHSystemTimeCell.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2021/12/3.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHSystemTimeCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *buttonTitle;

@end

@protocol MKNBHSystemTimeCellDelegate <NSObject>

- (void)nbh_systemTimeButtonPressed:(NSInteger)index;

@end

@interface MKNBHSystemTimeCell : MKBaseCell

@property (nonatomic, strong)MKNBHSystemTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKNBHSystemTimeCellDelegate>delegate;

+ (MKNBHSystemTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
