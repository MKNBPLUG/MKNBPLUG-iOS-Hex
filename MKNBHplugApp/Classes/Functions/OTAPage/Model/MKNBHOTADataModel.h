//
//  MKNBHOTADataModel.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2021/12/4.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Firmware
@interface MKNBHOTAFirmwareModel : NSObject

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *filePath;

@end


@interface MKNBHOTACACertificateModel : NSObject

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *filePath;

@end


@interface MKNBHOTASelfSignedModel : NSObject

@property (nonatomic, copy)NSString *host;

@property (nonatomic, copy)NSString *port;

@property (nonatomic, copy)NSString *caFilePath;

@property (nonatomic, copy)NSString *clientKeyPath;

@property (nonatomic, copy)NSString *clientCertPath;

@end


@interface MKNBHOTADataModel : NSObject

/// 当前用户选择的OTA类型.   0:Firmware     1:CA certificate     2:Self signed server certificates
@property (nonatomic, assign)NSInteger type;

@property (nonatomic, strong, readonly)MKNBHOTAFirmwareModel *firmwareModel;

@property (nonatomic, strong, readonly)MKNBHOTACACertificateModel *caFileModel;

@property (nonatomic, strong, readonly)MKNBHOTASelfSignedModel *signedModel;

- (void)startUpdateWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
