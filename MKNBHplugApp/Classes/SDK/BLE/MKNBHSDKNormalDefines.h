
typedef NS_ENUM(NSInteger, mk_nbh_centralConnectStatus) {
    mk_nbh_centralConnectStatusUnknow,                                           //未知状态
    mk_nbh_centralConnectStatusConnecting,                                       //正在连接
    mk_nbh_centralConnectStatusConnected,                                        //连接成功
    mk_nbh_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_nbh_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_nbh_centralManagerStatus) {
    mk_nbh_centralManagerStatusUnable,                           //不可用
    mk_nbh_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_nbh_connectMode) {
    mk_nbh_connectMode_TCP,                                          //TCP
    mk_nbh_connectMode_CACertificate,                                //SSL.Verify the server's certificate
    mk_nbh_connectMode_SelfSignedCertificates,                       //SSL.Two-way authentication
};

//Quality of MQQT service
typedef NS_ENUM(NSInteger, mk_nbh_mqttServerQosMode) {
    mk_nbh_mqttQosLevelAtMostOnce,      //At most once. The message sender to find ways to send messages, but an accident and will not try again.
    mk_nbh_mqttQosLevelAtLeastOnce,     //At least once.If the message receiver does not know or the message itself is lost, the message sender sends it again to ensure that the message receiver will receive at least one, and of course, duplicate the message.
    mk_nbh_mqttQosLevelExactlyOnce,     //Exactly once.Ensuring this semantics will reduce concurrency or increase latency, but level 2 is most appropriate when losing or duplicating messages is unacceptable.
};

typedef NS_ENUM(NSInteger, mk_nbh_networkPriority) {
    mk_nbh_networkPriority_eMTC_nbh_IOT_GSM,
    mk_nbh_networkPriority_eMTC_GSM_nbh_IOT,
    mk_nbh_networkPriority_nbh_IOT_GSM_eMTC,
    mk_nbh_networkPriority_nbh_IOT_eMTC_GSM,
    mk_nbh_networkPriority_GSM_nbh_IOT_eMTC,
    mk_nbh_networkPriority_GSM_eMTC_nbh_IOT,
    mk_nbh_networkPriority_eMTC_nbh_IOT,
    mk_nbh_networkPriority_nbh_IOT_eMTC,
    mk_nbh_networkPriority_GSM,
    mk_nbh_networkPriority_nbh_IOT,
    mk_nbh_networkPriority_eMTC,
};

typedef NS_ENUM(NSInteger, mk_nbh_dataFormat) {
    mk_nbh_dataFormat_json,                   //JSON
    mk_nbh_dataFormat_hex,                    //HEX
};

typedef NS_ENUM(NSInteger, mk_nbh_workMode) {
    mk_nbh_workMode_rc,                       //RC
    mk_nbh_workMode_debug,                    //Debug
};



@class CBCentralManager,CBPeripheral;

@protocol mk_nbh_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
/*
 @{
     @"rssi":rssi,
     @"peripheral":peripheral,
     @"deviceName":@"MOKO",
     @"macAddress":@"AA:BB:CC:DD:EE:FF",
     @"deviceType":@"00",
     @"firmware":@"V1.2.3",
     @"connectable":@(YES),
     @"mode":@"0",      //@"0":Production test mode.    @"1":configuration mode.    @"2":Debug mode.
 };
 */
- (void)mk_nbh_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_nbh_startScan;

/// Stops scanning equipment.
- (void)mk_nbh_stopScan;

@end

@protocol mk_nbh_centralManagerLogDelegate <NSObject>

- (void)mk_nbh_receiveLog:(NSString *)deviceLog;

@end
