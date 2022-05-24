//
//  MKNBHUserCredentialsView.h
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/19.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNBHUserCredentialsViewModel : NSObject

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@end

@protocol MKNBHUserCredentialsViewDelegate <NSObject>

- (void)nbh_mqtt_userCredentials_userNameChanged:(NSString *)userName;

- (void)nbh_mqtt_userCredentials_passwordChanged:(NSString *)password;

@end

@interface MKNBHUserCredentialsView : UIView

@property (nonatomic, strong)MKNBHUserCredentialsViewModel *dataModel;

@property (nonatomic, weak)id <MKNBHUserCredentialsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
