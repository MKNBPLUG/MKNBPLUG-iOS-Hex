//
//  MKNBHInterface.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHInterface.h"

#import "MKNBHCentralManager.h"
#import "MKNBHOperationID.h"
#import "MKNBHOperation.h"
#import "CBPeripheral+MKNBHAdd.h"

#define centralManager [MKNBHCentralManager shared]
#define peripheral ([MKNBHCentralManager shared].peripheral)

@implementation MKNBHInterface

+ (void)nbh_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    
    [self readDataWithTaskID:mk_nbh_taskReadDeviceNameOperation
                     cmdFlag:@"4e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)nbh_readDeviceMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_nbh_taskReadDeviceMacAddressOperation
                     cmdFlag:@"4f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_nbh_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.nbh_paramConfig
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
