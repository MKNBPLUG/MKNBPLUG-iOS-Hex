
typedef NS_ENUM(NSInteger, MKNBHMQTTSessionManagerState) {
    MKNBHMQTTSessionManagerStateStarting,
    MKNBHMQTTSessionManagerStateConnecting,
    MKNBHMQTTSessionManagerStateError,
    MKNBHMQTTSessionManagerStateConnected,
    MKNBHMQTTSessionManagerStateClosing,
    MKNBHMQTTSessionManagerStateClosed
};

typedef NS_ENUM(NSInteger, mk_nbh_switchStatus) {
    mk_nbh_switchStatusPowerOff,        //the switch state is off when the device is just powered on.
    mk_nbh_switchStatusPowerOn,         //the switch state is on when the device is just powered on
    mk_nbh_switchStatusRevertLast,      //when the device is just powered on, the switch returns to the state before the power failure.
};

typedef NS_ENUM(NSInteger, mk_nbh_productModel) {
    mk_nbh_productModel_FE,                        //Europe and France
    mk_nbh_productModel_America,                  //America
    mk_nbh_productModel_UK,                      //UK
};

typedef NS_ENUM(NSInteger, mk_nbh_indicatorBleConnectedStatus) {
    mk_nbh_indicatorBleConnectedStatus_off,                            //off
    mk_nbh_indicatorBleConnectedStatus_solidBlueForFiveSeconds,        //Solid blue for 5 seconds
    mk_nbh_indicatorBleConnectedStatus_solidBlue,                      //Solid blue
};

typedef NS_ENUM(NSInteger, mk_nbh_ledColorType) {
    mk_nbh_ledColorTransitionDirectly,
    mk_nbh_ledColorTransitionSmoothly,
    mk_nbh_ledColorWhite,
    mk_nbh_ledColorRed,
    mk_nbh_ledColorGreen,
    mk_nbh_ledColorBlue,
    mk_nbh_ledColorOrange,
    mk_nbh_ledColorCyan,
    mk_nbh_ledColorPurple,
};

typedef NS_ENUM(NSInteger, mk_nbh_mqtt_networkPriority) {
    mk_nbh_mqtt_networkPriority_eMTC_NB_IOT_GSM,
    mk_nbh_mqtt_networkPriority_eMTC_GSM_NB_IOT,
    mk_nbh_mqtt_networkPriority_NB_IOT_GSM_eMTC,
    mk_nbh_mqtt_networkPriority_NB_IOT_eMTC_GSM,
    mk_nbh_mqtt_networkPriority_GSM_NB_IOT_eMTC,
    mk_nbh_mqtt_networkPriority_GSM_eMTC_NB_IOT,
    mk_nbh_mqtt_networkPriority_eMTC_NB_IOT,
    mk_nbh_mqtt_networkPriority_NB_IOT_eMTC,
    mk_nbh_mqtt_networkPriority_GSM,
    mk_nbh_mqtt_networkPriority_NB_IOT,
    mk_nbh_mqtt_networkPriority_eMTC,
};

@protocol mk_nbh_ledColorConfigProtocol <NSObject>

/*
 Blue.
 European and French specifications:2 <=  b_color <= 4411.
 American specifications:2 <=  b_color <= 2155.
 British specifications:2 <=  b_color <= 3584.
 */
@property (nonatomic, assign)NSInteger b_color;

/*
 Green.
 European and French specifications:b_color < g_color <= 4412.
 American specifications:b_color < g_color <= 2156.
 British specifications:b_color < g_color <= 3584.
 */
@property (nonatomic, assign)NSInteger g_color;

/*
 Yellow.
 European and French specifications:g_color < y_color <= 4413.
 American specifications:g_color < y_color <= 2157.
 British specifications:g_color < y_color <= 3585.
 */
@property (nonatomic, assign)NSInteger y_color;

/*
 Orange.
 European and French specifications:y_color < o_color <= 4414.
 American specifications:y_color < o_color <= 2158.
 British specifications:y_color < o_color <= 3586.
 */
@property (nonatomic, assign)NSInteger o_color;

/*
 Red.
 European and French specifications:o_color < r_color <= 4415.
 American specifications:o_color < r_color <= 2159.
 British specifications:o_color < r_color <= 3587.
 */
@property (nonatomic, assign)NSInteger r_color;

/*
 Purple.
 European and French specifications:r_color < p_color <=  4416.
 American specifications:r_color < p_color <=  2160.
 British specifications:r_color < p_color <=  3588.
 */
@property (nonatomic, assign)NSInteger p_color;

@end

#pragma mark ****************************************????????????************************************************

@protocol MKNBHServerParamsProtocol <NSObject>

/// 1-64 Characters
@property (nonatomic, copy)NSString *host;

/// 1~65535
@property (nonatomic, copy)NSString *port;

/// 1-64 Characters
@property (nonatomic, copy)NSString *clientID;

/// 0-128 Characters
@property (nonatomic, copy)NSString *subscribeTopic;

/// 0-128 Characters
@property (nonatomic, copy)NSString *publishTopic;

@property (nonatomic, assign)BOOL cleanSession;

/// 0???1???2
@property (nonatomic, assign)NSInteger qos;

/// 10-120
@property (nonatomic, copy)NSString *keepAlive;

/// 0-128 Characters
@property (nonatomic, copy)NSString *userName;

/// 0-128 Characters
@property (nonatomic, copy)NSString *password;

@property (nonatomic, assign)BOOL sslIsOn;

/// 0:CA certificate     1:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

/// ?????????
@property (nonatomic, copy)NSString *caFileName;

/// ??????app???.p12??????
@property (nonatomic, copy)NSString *clientFileName;

@end
