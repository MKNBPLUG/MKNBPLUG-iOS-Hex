//
//  MKNBHBaseViewController.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/28.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHBaseViewController.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKNBHBasePageModel.h"

@interface MKNBHBaseViewController ()

@property (nonatomic, strong)MKNBHBasePageModel *monitorModel;

@end

@implementation MKNBHBaseViewController

- (void)dealloc {
    NSLog(@"MKNBHBaseViewController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startDataMonitor];
}

- (void)startDataMonitor {
    @weakify(self);
    self.monitorModel.receiveLoadStatusChangedBlock = ^(BOOL load) {
        //设备负载状态发生改变
        @strongify(self);
        if (![MKBaseViewController isCurrentViewControllerVisible:self]) {
            return;
        }
        NSString *msg = (load ? @"Load starts working now!" : @"Load stops working now!");
        [self.view showCentralToast:msg];
    };
    self.monitorModel.receiveOverloadBlock = ^(BOOL overload) {
      //设备过载保护发生改变
        @strongify(self);
        if (![MKBaseViewController isCurrentViewControllerVisible:self] || !overload) {
            return;
        }
        [self deviceOverState];
    };
    self.monitorModel.receiveOvervoltageBlock = ^(BOOL overvoltage) {
      //设备过压保护发生改变
        @strongify(self);
        if (![MKBaseViewController isCurrentViewControllerVisible:self] || !overvoltage) {
            return;
        }
        [self deviceOverState];
    };
    self.monitorModel.receiveUndervoltageBlock = ^(BOOL undervoltage) {
      //设备欠压保护发生改变
        @strongify(self);
        if (![MKBaseViewController isCurrentViewControllerVisible:self] || !undervoltage) {
            return;
        }
        [self deviceOverState];
    };
    self.monitorModel.receiveOvercurrentBlock = ^(BOOL overcurrent) {
        //设备过流保护发生改变
        @strongify(self);
        if (![MKBaseViewController isCurrentViewControllerVisible:self] || !overcurrent) {
            return;
        }
        [self deviceOverState];
    };
}

- (void)deviceOverState {
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_nbh_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    [self performSelector:@selector(backToSwitchPage) withObject:nil afterDelay:0.5f];
}

- (void)backToSwitchPage {
    [self popToViewControllerWithClassName:@"MKNBHSwitchStateController"];
}

#pragma mark - getter
- (MKNBHBasePageModel *)monitorModel {
    if (!_monitorModel) {
        _monitorModel = [[MKNBHBasePageModel alloc] init];
    }
    return _monitorModel;
}

@end
