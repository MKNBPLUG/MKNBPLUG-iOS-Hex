//
//  MKNBHStartDFUCell.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/15.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHStartDFUCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKNBHStartDFUCellDelegate <NSObject>

- (void)nbh_startDfuButtonPressed;

@end

@interface MKNBHStartDFUCell : MKBaseCell

@property (nonatomic, strong)MKNBHStartDFUCellModel *dataModel;

@property (nonatomic, weak)id <MKNBHStartDFUCellDelegate>delegate;

+ (MKNBHStartDFUCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
