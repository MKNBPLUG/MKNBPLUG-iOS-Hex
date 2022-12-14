//
//  MKNBHSwitchViewButton.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHSwitchViewButtonModel : NSObject

@property (nonatomic, strong)UIImage *icon;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIColor *msgColor;

@end

@interface MKNBHSwitchViewButton : UIControl

@property (nonatomic, strong)MKNBHSwitchViewButtonModel *dataModel;

@end

NS_ASSUME_NONNULL_END
