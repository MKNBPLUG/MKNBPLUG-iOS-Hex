typedef NS_ENUM(NSInteger, mk_nbh_taskOperationID) {
    mk_nbh_defaultTaskOperationID,
    
#pragma mark - 读取
    mk_nbh_taskReadDeviceNameOperation,                  //读取设备广播名称
    mk_nbh_taskReadDeviceMacAddressOperation,            //读取mac地址
    
#pragma mark - 密码特征
    mk_nbh_connectPasswordOperation,                     //连接设备时候发送密码
    
#pragma mark - 配置
    mk_nbh_taskConfigServerHostOperation,                //配置MQTT服务器地址
    mk_nbh_taskConfigServerPortOperation,                //配置MQTT服务器端口号
    mk_nbh_taskConfigServerUserNameOperation,            //配置MQTT服务器用户名
    mk_nbh_taskConfigServerPasswordOperation,            //配置MQTT服务器密码
    mk_nbh_taskConfigClientIDOperation,                  //配置MQTT通信的ClientID
    mk_nbh_taskConfigServerCleanSessionOperation,        //配置MQTT服务器cleanSession状态
    mk_nbh_taskConfigServerKeepAliveOperation,           //配置Keep Alive
    mk_nbh_taskConfigServerQosOperation,                 //配置MQTT Qos
    mk_nbh_taskConfigSubscibeTopicOperation,             //配置MQTT Subscibe Topic
    mk_nbh_taskConfigPublishTopicOperation,              //配置MQTT Publish Topic
    mk_nbh_taskConfigLWTStatusOperation,                 //配置LWT开关状态
    mk_nbh_taskConfigLWTQosOperation,                    //配置LWT Qos
    mk_nbh_taskConfigLWTRetainOperation,                 //配置LWT Retain
    mk_nbh_taskConfigLWTTopicOperation,                  //配置LWT Topic
    mk_nbh_taskConfigLWTMessageOperation,                //配置LWT Message
    mk_nbh_taskConfigDeviceIDOperation,                  //配置DeviceID
    mk_nbh_taskConfigConnectModeOperation,               //配置加密方式
    mk_nbh_taskConfigCAFileOperation,                    //配置CA File
    mk_nbh_taskConfigClientCertOperation,                //配置设备证书
    mk_nbh_taskConfigClientPrivateKeyOperation,          //配置设备私钥
    mk_nbh_taskConfigNTPServerHostOperation,             //配置NTP服务器地址
    mk_nbh_taskConfigTimeZoneOperation,                  //配置时区
    mk_nbh_taskConfigAPNOperation,                       //配置APN
    mk_nbh_taskConfigAPNUserNameOperation,               //配置APN用户名
    mk_nbh_taskConfigAPNPasswordOperation,               //配置APN密码
    mk_nbh_taskConfigNetworkPriorityOperation,           //配置网络制式
    mk_nbh_taskConfigDataFormatOperation,                //配置MQTT数据格式
    mk_nbh_taskConfigEnterProductTestModeOperation,      //配置设备进入产测模式
    mk_nbh_taskConfigWorkModeOperation,                  //配置工作模式
    mk_nbh_taskConfigExitDebugModeOperation,             //退出debug模式
};
