//
//  MKNBHDebuggerCell.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKNBHDebuggerCellDelegate <NSObject>

- (void)nbh_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKNBHDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKNBHDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKNBHDebuggerCellDelegate>delegate;

+ (MKNBHDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
