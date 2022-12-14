//
//  MKNBHMQTTServerManager.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/13.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHMQTTServerManager.h"

#import "MQTTSSLSecurityPolicyTransport.h"
#import "MQTTSSLSecurityPolicy.h"

#import "MKMacroDefines.h"

#import "MKMQTTServerSDKDefines.h"
#import "MKNetworkManager.h"

#import "MKNBHMQTTSDKAdopter.h"
#import "MKNBHMQTTDataParser.h"
#import "MKNBHServerParamsModel.h"
#import "MKNBHMQTTOperation.h"

NSString *const MKNBHMQTTSessionManagerStateChangedNotification = @"MKNBHMQTTSessionManagerStateChangedNotification";

//设备上报的状态信息
NSString *const MKNBHReceiveDeviceNetStateNotification = @"MKNBHReceiveDeviceNetStateNotification";

NSString *const MKNBHReceivedSwitchStateNotification = @"MKNBHReceivedSwitchStateNotification";
NSString *const MKNBHReceivedCountdownNotification = @"MKNBHReceivedCountdownNotification";
NSString *const MKNBHReceiveDeviceOTAResultNotification = @"MKNBHReceiveDeviceOTAResultNotification";
NSString *const MKNBHReceivedElectricityDataNotification = @"MKNBHReceivedElectricityDataNotification";
NSString *const MKNBHReceiveTotalEnergyDataNotification = @"MKNBHReceiveTotalEnergyDataNotification";
NSString *const MKNBHReceiveMonthlyEnergyDataNotification = @"MKNBHReceiveMonthlyEnergyDataNotification";
NSString *const MKNBHReceiveHourlyEnergyDataNotification = @"MKNBHReceiveHourlyEnergyDataNotification";

NSString *const MKNBHReceiveOverloadNotification = @"MKNBHReceiveOverloadNotification";
NSString *const MKNBHReceiveOvervoltageNotification = @"MKNBHReceiveOvervoltageNotification";
NSString *const MKNBHReceiveUndervoltageNotification = @"MKNBHReceiveUndervoltageNotification";
NSString *const MKNBHReceiveOverCurrentNotification = @"MKNBHReceiveOverCurrentNotification";
NSString *const MKNBHDeviceLoadStatusChangedNotification = @"MKNBHDeviceLoadStatusChangedNotification";

NSString *const MKNBHReceivedDownMQTTParamsDataCompleteNotification = @"MKNBHReceivedDownMQTTParamsDataCompleteNotification";


static MKNBHMQTTServerManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKNBHMQTTServerManager ()

@property (nonatomic, assign)MKNBHMQTTSessionManagerState state;

@property (nonatomic, strong)MKNBHServerParamsModel *paramsModel;

@property (nonatomic, strong)NSOperationQueue *operationQueue;

@property (nonatomic, strong)NSMutableDictionary *subscriptions;

@end

@implementation MKNBHMQTTServerManager

- (void)dealloc{
    NSLog(@"MKNBHMQTTServerManager销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init{
    if (self = [super init]) {
        [[MKMQTTServerManager shared] loadDataManager:self];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                       selector:@selector(networkStateChanged)
                                           name:MKNetworkStatusChangedNotification
                                         object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                       selector:@selector(networkStateChanged)
                                           name:UIApplicationDidBecomeActiveNotification
                                         object:nil];
    }
    return self;
}

+ (MKNBHMQTTServerManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKNBHMQTTServerManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKMQTTServerManager shared] removeDataManager:manager];
    onceToken = 0;
    manager = nil;
}

#pragma mark - MKMQTTServerProtocol

- (void)sessionManager:(MQTTSessionManager *)sessionManager
     didReceiveMessage:(NSData *)data
               onTopic:(NSString *)topic
              retained:(BOOL)retained {
    if (!ValidStr(topic) || !ValidData(data)) {
        return;
    }
    NSDictionary *dataDic = [MKNBHMQTTSDKAdopter parseContentData:data];
    if (!ValidDict(dataDic) || !ValidStr(dataDic[@"msg_id"]) || !ValidStr(dataDic[@"device_id"])) {
        return;
    }
    NSString *deviceID = dataDic[@"device_id"];
    //无论是什么消息，都抛出该通知，证明设备在线
    [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceiveDeviceNetStateNotification
                                                        object:nil
                                                      userInfo:@{@"deviceID":deviceID}];
    NSString *msgID = dataDic[@"msg_id"];
    if ([msgID isEqualToString:@"41"]) {
        //开关状态
        NSDictionary *dic = [MKNBHMQTTDataParser parseSwitchStateData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceivedSwitchStateNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    if ([msgID isEqualToString:@"42"]) {
        //倒计时
        NSDictionary *dic = [MKNBHMQTTDataParser parseCountdownData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceivedCountdownNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    if ([msgID isEqualToString:@"43"]) {
        //OTA结果
        NSDictionary *dic = [MKNBHMQTTDataParser parseOTAResultData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceiveDeviceOTAResultNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    
    if ([msgID isEqualToString:@"44"]) {
        //电量信息
        NSDictionary *dic = [MKNBHMQTTDataParser parseElectricityData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceivedElectricityDataNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    if ([msgID isEqualToString:@"45"]) {
        //总累计电能
        NSDictionary *dic = [MKNBHMQTTDataParser parseTotalEnergyDataDic:dataDic];
        NSString *energyValue = [NSString stringWithFormat:@"%.2f",([dic[@"data"][@"energy"] integerValue] * 0.01)];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceiveTotalEnergyDataNotification
                                                            object:nil
                                                          userInfo:@{@"total":energyValue}];
        return;
    }
    if ([msgID isEqualToString:@"46"]) {
        //最近30天电能
        NSDictionary *dic = [MKNBHMQTTDataParser parseEnergyDataDic:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceiveMonthlyEnergyDataNotification
                                                            object:nil
                                                          userInfo:dic[@"data"]];
        return;
    }
    if ([msgID isEqualToString:@"47"]) {
        //当天每小时电能
        NSDictionary *dic = [MKNBHMQTTDataParser parseEnergyDataDic:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceiveHourlyEnergyDataNotification
                                                            object:nil
                                                          userInfo:dic[@"data"]];
        return;
    }
    if ([msgID isEqualToString:@"48"]) {
        //过载保护
        NSDictionary *dic = [MKNBHMQTTDataParser parseOverStatusData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceiveOverloadNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    if ([msgID isEqualToString:@"49"]) {
        //过压保护
        NSDictionary *dic = [MKNBHMQTTDataParser parseOverStatusData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceiveOvervoltageNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    if ([msgID isEqualToString:@"4a"]) {
        //欠压保护
        NSDictionary *dic = [MKNBHMQTTDataParser parseOverStatusData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceiveUndervoltageNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    if ([msgID isEqualToString:@"4b"]) {
        //过流保护
        NSDictionary *dic = [MKNBHMQTTDataParser parseOverStatusData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceiveOverCurrentNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    if ([msgID isEqualToString:@"4c"]) {
        //负载状态改变
        NSDictionary *dic = [MKNBHMQTTDataParser parseLoadStateData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHDeviceLoadStatusChangedNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    if ([msgID isEqualToString:@"4d"]) {
        //入网准备完成通知
        NSDictionary *dic = [MKNBHMQTTDataParser parseDownMQTTParamsData:dataDic];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHReceivedDownMQTTParamsDataCompleteNotification
                                                            object:nil
                                                          userInfo:dic];
        return;
    }
    
    @synchronized(self.operationQueue) {
        NSArray *operations = [self.operationQueue.operations copy];
        for (NSOperation <MKNBHMQTTOperationProtocol>*operation in operations) {
            if (operation.executing) {
                [operation didReceiveMessage:dataDic onTopic:topic];
                break;
            }
        }
    }
}

- (void)sessionManager:(MQTTSessionManager *)sessionManager didChangeState:(MKMQTTSessionManagerState)newState {
    self.state = newState;
    if (newState != MKMQTTSessionManagerStateConnected) {
        if (self.operationQueue.operations.count > 0) {
            [self.operationQueue cancelAllOperations];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHMQTTSessionManagerStateChangedNotification object:nil];
}

#pragma mark - note
- (void)networkStateChanged{
    if (![self.paramsModel paramsCanConnectServer]) {
        //服务器连接参数缺失
        return;
    }
    if (![[MKNetworkManager sharedInstance] currentNetworkAvailable]) {
        //如果是当前网络不可用，则断开当前手机与mqtt服务器的连接操作
        [[MKMQTTServerManager shared] disconnect];
        self.state = MKNBHMQTTSessionManagerStateStarting;
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNBHMQTTSessionManagerStateChangedNotification object:nil];
        return;
    }
    if ([MKMQTTServerManager shared].managerState == MKMQTTSessionManagerStateConnected
        || [MKMQTTServerManager shared].managerState == MKMQTTSessionManagerStateConnecting) {
        //已经连接或者正在连接，直接返回
        return;
    }
    //如果网络可用，则连接
    [self connect];
}

#pragma mark - public method

- (BOOL)saveServerParams:(id <MKNBHServerParamsProtocol>)protocol {
    return [self.paramsModel saveServerParams:protocol];
}

- (BOOL)clearLocalData {
    return [self.paramsModel clearLocalData];
}

- (void)disconnect {
    if (self.operationQueue.operations.count > 0) {
        [self.operationQueue cancelAllOperations];
    }
    [[MKMQTTServerManager shared] disconnect];
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    for (NSString *topic in topicList) {
        if (ValidStr(topic)) {
            [self.subscriptions setObject:@(MQTTQosLevelAtLeastOnce) forKey:topic];
        }
    }
    [[MKMQTTServerManager shared] subscriptions:topicList qosLevel:MQTTQosLevelAtLeastOnce];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    for (NSString *topic in topicList) {
        if (ValidStr(topic)) {
            [self.subscriptions removeObjectForKey:topic];
        }
    }
    [[MKMQTTServerManager shared] unsubscriptions:topicList];
}

- (void)clearAllSubscriptions {
    if (!ValidDict(self.subscriptions)) {
        return;
    }
    [[MKMQTTServerManager shared] unsubscriptions:self.subscriptions.allKeys];
}

- (id<MKNBHServerParamsProtocol>)currentServerParams {
    return self.paramsModel;
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
        deviceID:(NSString *)deviceID
          taskID:(mk_nbh_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    
    MKNBHMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                                topic:topic
                                                             deviceID:deviceID
                                                                 data:data
                                                             sucBlock:sucBlock
                                                          failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    [self.operationQueue addOperation:operation];
}

- (void)sendCommand:(NSString *)command
              topic:(NSString *)topic
           deviceID:(NSString *)deviceID
             taskID:(mk_nbh_serverOperationID)taskID
           sucBlock:(void (^)(id returnData))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock {
    MKNBHMQTTOperation *operation = [self generateOperationWithID:taskID
                                                            topic:topic
                                                         deviceID:deviceID
                                                          command:command
                                                         sucBlock:sucBlock
                                                      failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    [self.operationQueue addOperation:operation];
}

- (void)startWork {
    [self networkStateChanged];
}

#pragma mark - *****************************服务器交互部分******************************

- (BOOL)connect {
    if (![self.paramsModel paramsCanConnectServer]) {
        return NO;
    }
    MQTTSSLSecurityPolicy *securityPolicy = nil;
    NSArray *certList = nil;
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    if (self.paramsModel.sslIsOn) {
        //需要ssl验证
//        if (self.paramsModel.certificate == 0) {
//            //不需要CA根证书
//            securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
//        }
        if (self.paramsModel.certificate == 0 || self.paramsModel.certificate == 1) {
            //需要CA证书
            NSString *filePath = [document stringByAppendingPathComponent:self.paramsModel.caFileName];
            NSData *clientCert = [NSData dataWithContentsOfFile:filePath];
            if (MKMQTTValidData(clientCert)) {
                securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeCertificate];
                securityPolicy.pinnedCertificates = @[clientCert];
            }else {
                //未加载到CA证书
                securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeNone];
            }
        }
        if (self.paramsModel.certificate == 1) {
            //双向验证
            NSString *filePath = [document stringByAppendingPathComponent:self.paramsModel.clientFileName];
            certList = [MQTTSSLSecurityPolicyTransport clientCertsFromP12:filePath passphrase:@"123456"];
        }
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        securityPolicy.validatesCertificateChain = NO;
    }
    [[MKMQTTServerManager shared] connectTo:self.paramsModel.host
                                       port:[self.paramsModel.port integerValue]
                                        tls:self.paramsModel.sslIsOn
                                  keepalive:[self.paramsModel.keepAlive integerValue]
                                      clean:self.paramsModel.cleanSession
                                       auth:YES
                                       user:self.paramsModel.userName
                                       pass:self.paramsModel.password
                                       will:NO
                                  willTopic:nil
                                    willMsg:nil
                                    willQos:0
                             willRetainFlag:NO
                               withClientId:self.paramsModel.clientID
                             securityPolicy:securityPolicy
                               certificates:certList
                              protocolLevel:MQTTProtocolVersion311
                             connectHandler:nil];
    return YES;
}

- (NSString *)currentSubscribeTopic {
    return [MKNBHMQTTServerManager shared].serverParams.subscribeTopic;
}

- (NSString *)currentPublishedTopic {
    return [MKNBHMQTTServerManager shared].serverParams.publishTopic;
}

#pragma mark - private method

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
        sucBlock:(void (^)(void))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    [[MKMQTTServerManager shared] sendData:data
                                     topic:topic
                                  qosLevel:MQTTQosLevelAtMostOnce
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

- (MKNBHMQTTOperation *)generateOperationWithTaskID:(mk_nbh_serverOperationID)taskID
                                              topic:(NSString *)topic
                                           deviceID:(NSString *)deviceID
                                               data:(NSDictionary *)data
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidDict(data)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failedBlock];
        return nil;
    }
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Topic error" failedBlock:failedBlock];
        return nil;
    }
    if (!ValidStr(deviceID) || deviceID.length > 32) {
        [self operationFailedBlockWithMsg:@"ClientID error" failedBlock:failedBlock];
        return nil;
    }
    if ([MKMQTTServerManager shared].managerState != MKMQTTSessionManagerStateConnected) {
        [self operationFailedBlockWithMsg:@"MTQQ Server disconnect" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKNBHMQTTOperation *operation = [[MKNBHMQTTOperation alloc] initOperationWithID:taskID deviceID:deviceID commandBlock:^{
        [self sendData:data topic:topic sucBlock:nil failedBlock:nil];
    } completeBlock:^(NSError * _Nonnull error, id  _Nonnull returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            moko_dispatch_main_safe(^{
                if (failedBlock) {
                    failedBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failedBlock];
            return ;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock(returnData);
            }
        });
    }];
    return operation;
}

- (MKNBHMQTTOperation *)generateOperationWithID:(mk_nbh_serverOperationID)taskID
                                          topic:(NSString *)topic
                                       deviceID:(NSString *)deviceID
                                        command:(NSString *)command
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(command)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failedBlock];
        return nil;
    }
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Topic error" failedBlock:failedBlock];
        return nil;
    }
    if ([MKMQTTServerManager shared].managerState != MKMQTTSessionManagerStateConnected) {
        [self operationFailedBlockWithMsg:@"MTQQ Server disconnect" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKNBHMQTTOperation *operation = [[MKNBHMQTTOperation alloc] initOperationWithID:taskID deviceID:deviceID commandBlock:^{
        [[MKMQTTServerManager shared] publishData:[MKNBHMQTTSDKAdopter stringToData:command] topic:topic qosLevel:MQTTQosLevelAtMostOnce sucBlock:nil failedBlock:nil];
    } completeBlock:^(NSError * _Nonnull error, id  _Nonnull returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            moko_dispatch_main_safe(^{
                if (failedBlock) {
                    failedBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failedBlock];
            return ;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock(returnData);
            }
        });
    }];
    return operation;
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.MKNBHMQTTManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

#pragma mark - getter
- (MKNBHServerParamsModel *)paramsModel {
    if (!_paramsModel) {
        _paramsModel = [[MKNBHServerParamsModel alloc] init];
    }
    return _paramsModel;
}

- (NSOperationQueue *)operationQueue{
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
}

- (NSMutableDictionary *)subscriptions {
    if (!_subscriptions) {
        _subscriptions = [NSMutableDictionary dictionary];
    }
    return _subscriptions;
}

@end
