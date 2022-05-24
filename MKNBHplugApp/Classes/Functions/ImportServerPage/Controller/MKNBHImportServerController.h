//
//  MKNBHImportServerController.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/5/5.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKNBHImportServerControllerDelegate <NSObject>

- (void)nbh_selectedServerParams:(NSString *)fileName;

@end

@interface MKNBHImportServerController : MKBaseViewController

@property (nonatomic, weak)id <MKNBHImportServerControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
