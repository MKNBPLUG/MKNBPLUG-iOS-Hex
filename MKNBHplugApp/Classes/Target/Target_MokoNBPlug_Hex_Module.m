//
//  Target_MokoNBPlug_Hex_Module.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "Target_MokoNBPlug_Hex_Module.h"

#import "MKNBHDeviceListController.h"

@implementation Target_MokoNBPlug_Hex_Module

- (UIViewController *)Action_MokoNBPlug_Hex_Module_DeviceListController:(NSDictionary *)params {
    MKNBHDeviceListController *vc = [[MKNBHDeviceListController alloc] init];
    vc.connectServer = [params[@"connect"] boolValue];
    return vc;
}

@end
