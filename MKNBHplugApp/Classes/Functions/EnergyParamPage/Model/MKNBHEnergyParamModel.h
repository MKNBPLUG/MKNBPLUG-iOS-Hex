//
//  MKNBHEnergyParamModel.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/22.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHEnergyParamModel : NSObject

@property (nonatomic, copy)NSString *storageInterval;

@property (nonatomic, copy)NSString *threshold;

@property (nonatomic, copy)NSString *reportInterval;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
