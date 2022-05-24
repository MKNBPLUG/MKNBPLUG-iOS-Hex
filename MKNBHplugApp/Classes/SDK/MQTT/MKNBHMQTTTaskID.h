
typedef NS_ENUM(NSInteger, mk_nbh_serverOperationID) {
    mk_nbh_defaultServerOperationID,
    
#pragma mark - 配置
    mk_nbh_server_taskConfigPowerOnSwitchStatusOperation,       //配置开关上电状态
    mk_nbh_server_taskConfigPeriodicalReportOperation,          //配置开关和倒计时上报间隔
    mk_nbh_server_taskConfigPowerReportOperation,               //配置电量上报信息
    mk_nbh_server_taskConfigEnergyReportOperation,              //配置电能上报信息
    mk_nbh_server_taskConfigOverloadOperation,                  //配置过载保护参数
    mk_nbh_server_taskConfigOvervoltageOperation,               //配置过压保护参数
    mk_nbh_server_taskConfigUndervoltageOperation,              //配置欠压保护参数
    mk_nbh_server_taskConfigOvercurrentOperation,               //配置过流保护参数
    mk_nbh_server_taskConfigPowerIndicatorColorOperation,       //配置功率指示灯颜色
    mk_nbh_server_taskConfigNTPServerParamsOperation,           //配置NTP服务器参数
    mk_nbh_server_taskConfigDeviceTimeZoneOperation,            //配置时区
    mk_nbh_server_taskConfigLoadNotificationSwitchOperation,    //配置负载接入通知开关
    mk_nbh_server_taskConfigServerConnectingIndicatorStatusOperation,       //配置连接中网络指示灯开关
    mk_nbh_server_taskConfigServerConnectedIndicatorStatusOperation,        //配置连接成功网络指示灯状态
    mk_nbh_server_taskConfigIndicatorStatusOperation,           //配置电源指示灯开关指示
    mk_nbh_server_taskConfigIndicatorProtectionSignalOperation, //配置电源指示灯保护触发指示
    mk_nbh_server_taskConfigConnectionTimeoutOperation,         //配置服务器重连超时重启时间
    mk_nbh_server_taskConfigSwitchByButtonStatusOperation,      //配置按键开关机功能
    mk_nbh_server_taskClearOverloadStatusOperation,             //清除过载状态
    mk_nbh_server_taskClearOvervoltageStatusOperation,          //清除过压状态
    mk_nbh_server_taskClearUndervoltageStatusOperation,         //清除欠压状态
    mk_nbh_server_taskClearOvercurrentStatusOperation,          //清除过流状态
    mk_nbh_server_taskConfigSwitchStatusOperation,              //配置开关状态
    mk_nbh_server_taskConfigCountdownOperation,                 //配置倒计时
    mk_nbh_server_taskClearAllEnergyDatasOperation,             //清除电能数据
    mk_nbh_server_taskResetDeviceOperation,                     //恢复出厂设置
    mk_nbh_server_taskConfigOTAFirmwareOperation,               //OTA固件
    mk_nbh_server_taskConfigOTACACertificateOperation,          //OTA单项认证
    mk_nbh_server_taskConfigOTASelfSignedCertificatesOperation, //OTA双向认证
    mk_nbh_server_taskConfigDeviceUTCTimeOperation,             //配置UTC时间
    
#pragma mark - 服务器参数
    mk_nbh_server_taskConfigMQTTHostOperation,                  //配置MQTT服务器地址
    mk_nbh_server_taskConfigMQTTPortOperation,                  //配置MQTT端口号
    mk_nbh_server_taskConfigMQTTUsernameOperation,              //配置MQTT用户名
    mk_nbh_server_taskConfigMQTTPasswordOperation,              //配置MQTT密码
    mk_nbh_server_taskConfigMQTTClientIDOperation,              //配置MQTT ClientID
    mk_nbh_server_taskConfigCleanSessionOperation,              //配置MQTT Clean Session
    mk_nbh_server_taskConfigMQTTKeepAliveOperation,             //配置keep alive
    mk_nbh_server_taskConfigMQTTQosOperation,                   //配置Qos
    mk_nbh_server_taskConfigMQTTSubscribeTopicOperation,        //配置订阅主题
    mk_nbh_server_taskConfigMQTTPublishTopicOperation,          //配置发布主题
    mk_nbh_server_taskConfigLWTStatusOperation,                 //配置遗嘱功能开关
    mk_nbh_server_taskConfigLWTQosOperation,                    //配置遗嘱 Qos
    mk_nbh_server_taskConfigLWTRetainOperation,                 //配置遗嘱 Retain
    mk_nbh_server_taskConfigLWTTopicOperation,                  //配置遗嘱主题
    mk_nbh_server_taskConfigLWTPayloadOperation,                //配置遗嘱内容
    mk_nbh_server_taskConfigSSLStatusOperation,                 //配置加密方式
    mk_nbh_server_taskConfigAPNOperation,                       //配置APN
    mk_nbh_server_taskConfigAPNUsernameOperation,               //配置APN用户名
    mk_nbh_server_taskConfigAPNPasswordOperation,               //配置APN密码
    mk_nbh_server_taskConfigNetworkPriorityOperation,           //配置网络制式
    mk_nbh_server_taskConfigCACertificateOperation,             //配置单向认证证书
    mk_nbh_server_taskConfigSelfSignedCertificatesOperation,    //配置双向认证证书
    mk_nbh_server_taskConfigMQTTServerParamsCompleteOperation,  //配置MQTT参数完成
    mk_nbh_server_taskReconnectMQTTServerOperation,             //设备切网
    
#pragma mark - 读取
    mk_nbh_server_taskReadPowerOnSwitchStatusOperation,         //读取开关上电状态
    mk_nbh_server_taskReadPeriodicalReportingOperation,         //读取开关和倒计时上报间隔
    mk_nbh_server_taskReadPowerReportingOperation,              //读取电量上报信息
    mk_nbh_server_taskReadEnergyReportingOperation,             //读取电能上报信息
    mk_nbh_server_taskReadOverloadProtectionDataOperation,      //读取过载保护参数
    mk_nbh_server_taskReadOvervoltageProtectionDataOperation,   //读取过压保护参数
    mk_nbh_server_taskReadUndervoltageProtectionDataOperation,  //读取欠压保护参数
    mk_nbh_server_taskReadOvercurrentProtectionDataOperation,   //读取过流保护参数
    mk_nbh_server_taskReadPowerIndicatorColorOperation,         //读取功率指示灯颜色
    mk_nbh_server_taskReadNTPServerParamsOperation,             //读取NTP服务器参数
    mk_nbh_server_taskReadTimeZoneOperation,                    //读取时区
    mk_nbh_server_taskReadLoadNotificationSwitchOperation,      //读取负载接入通知开关状态
    mk_nbh_server_taskReadServerConnectingIndicatorStatusOperation, //读取连接中网络指示灯开关
    mk_nbh_server_taskReadServerConnectedIndicatorStatusOperation,  //读取连接成功网络指示灯状态
    mk_nbh_server_taskReadIndicatorStatusOperation,                 //读取电源指示灯开关状态
    mk_nbh_server_taskReadIndicatorProtectionSignalOperation,       //读取电源指示灯保护触发指示
    mk_nbh_server_taskReadConnectionTimeoutOperation,           //读取服务器重连超时重启时间
    mk_nbh_server_taskReadSwitchByButtonStatusOperation,        //读取按键开关机功能
    mk_nbh_server_taskReadSwitchStatusOperation,                //读取开关状态
    mk_nbh_server_taskReadDeviceUpdateStateOperation,           //读取当前设备状态
    mk_nbh_server_taskReadElectricityDataOperation,             //读取电量信息
    mk_nbh_server_taskReadTotalEnergyDataOperation,             //读取总累计电能
    mk_nbh_server_taskReadMonthlyEnergyDataOperation,           //读取最近30天电能数据
    mk_nbh_server_taskReadHourlyEnergyDataOperation,            //读取当天每小时电能
    mk_nbh_server_taskReadSpecificationsOfDeviceOperation,      //读取设备规格
    mk_nbh_server_taskReadManufacturerOperation,                //读取厂商信息
    mk_nbh_server_taskReadDeviceModeOperation,                  //读取产品型号
    mk_nbh_server_taskReadHardwareOperation,                    //读取硬件版本
    mk_nbh_server_taskReadFirmwareOperation,                    //读取固件版本
    mk_nbh_server_taskReadMacAddressOperation,                  //读取mac地址
    mk_nbh_server_taskReadDeviceIEMIOperation,                  //读取IEMI
    mk_nbh_server_taskReadDeviceICCIDOperation,                 //读取ICCID
    mk_nbh_server_taskReadDeviceUTCTimeOperation,               //读取设备UTC时间
    mk_nbh_server_taskReadDeviceWorkModeOperation,              //读取设备工作模式
    mk_nbh_server_taskReadDeviceInfoOperation,                  //读取设备出厂信息
    
#pragma mark - MQTT服务器参数
    mk_nbh_server_taskReadMQTTHostOperation,        //读取MQTT服务器地址
    mk_nbh_server_taskReadMQTTPortOperation,         //读取MQTT服务器端口号
    mk_nbh_server_taskReadMQTTUsernameOperation,    //读取MQTT服务器登录用户名
    mk_nbh_server_taskReadMQTTPasswordOperation,    //读取MQTT服务器登录密码
    mk_nbh_server_taskReadMQTTClientIDOperation,    //读取Client ID
    mk_nbh_server_taskReadMQTTCleanSessionOperation,    //读取Clean Session
    mk_nbh_server_taskReadMQTTKeepAliveOperation,   //读取KeepAlive
    mk_nbh_server_taskReadMQTTQosOperation,         //读取Qos
    mk_nbh_server_taskReadMQTTSubscribeTopicOperation,  //读取订阅主题
    mk_nbh_server_taskReadMQTTPublishTopicOperation,    //读取发布主题
    mk_nbh_server_taskReadMQTTLWTStatusOperation,       //读取遗嘱功能开关
    mk_nbh_server_taskReadMQTTLWTQosOperation,          //读取遗嘱Qos
    mk_nbh_server_taskReadMQTTLWTRetainOperation,       //读取遗嘱Retain
    mk_nbh_server_taskReadMQTTLWTTopicOperation,        //读取遗嘱主题
    mk_nbh_server_taskReadMQTTLWTPayloadOperation,      //读取遗嘱内容
    mk_nbh_server_taskReadMQTTSSLStatusOperation,       //读取SSL加密状态
    mk_nbh_server_taskReadAPNOperation,                 //读取APN
    mk_nbh_server_taskReadAPNUsernameOperation,         //读取APN用户名
    mk_nbh_server_taskReadAPNPasswordOperation,         //读取APN密码
    mk_nbh_server_taskReadNetwordPriorityOperation,     //读取网络制式
    mk_nbh_server_taskReadDeviceMQTTServerInfoOperation,    //读取设备当前的MQTT服务器信息
};
