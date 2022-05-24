#
# Be sure to run `pod lib lint MKNBHplugApp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKNBHplugApp'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MKNBHplugApp.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/aadyx2007@163.com/MKNBHplugApp'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/aadyx2007@163.com/MKNBHplugApp.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  
  s.resource_bundles = {
    'MKNBHplugApp' => ['MKNBHplugApp/Assets/*.png']
  }
  
  s.subspec 'Target' do |ss|
    
    ss.source_files = 'MKNBHplugApp/Classes/Target/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKNBHplugApp/Functions'
  
  end
  
  s.subspec 'SDK' do |ss|
    
    ss.subspec 'BLE' do |sss|
      sss.source_files = 'MKNBHplugApp/Classes/SDK/BLE/**'
      
      sss.dependency 'MKBaseBleModule'
    end
    
    ss.subspec 'MQTT' do |sss|
      sss.source_files = 'MKNBHplugApp/Classes/SDK/MQTT/**'
      
      ss.dependency 'MKBaseModuleLibrary'
      ss.dependency 'MKBaseMQTTModule'
    end
  
  end
  
  s.subspec 'Expand' do |ss|
    ss.subspec 'BaseController' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Expand/BaseController/Controller/**'
        
        ssss.dependency 'MKNBHplugApp/Expand/BaseController/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Expand/BaseController/Model/**'
        
        ssss.dependency 'MKNBHplugApp/Expand/DeviceModel'
      end
    end
    
    ss.subspec 'DeviceModel' do |sss|
      sss.subspec 'Manager' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Expand/DeviceModel/Manager/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Expand/DeviceModel/Model/**'
      end
    end
    
    ss.subspec 'Manager' do |sss|
      sss.subspec 'DatabaseManager' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Expand/Manager/DatabaseManager/**'
        
        ssss.dependency 'MKNBHplugApp/Expand/DeviceModel/Model'
        ssss.dependency 'FMDB'
      end
      
      sss.subspec 'ExcelManager' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Expand/Manager/ExcelManager/**'
        
        ssss.dependency 'libxlsxwriter'
        ssss.dependency 'SSZipArchive'
      end
    end
    
    ss.subspec 'View' do |sss|
      sss.subspec 'UserCredentialsView' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Expand/View/UserCredentialsView/**'
      end
    end
    
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKNBHplugApp/SDK/MQTT'
    ss.dependency 'MKCustomUIModule'
    
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AddDevicePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/AddDevicePage/Controller/**'
        
        ssss.dependency 'MKNBHplugApp/Functions/AddDevicePage/View'
        
        ssss.dependency 'MKNBHplugApp/Functions/ServerForDevice/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/UpdatePage/Controller'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/AddDevicePage/View/**'
      end
    end
    
    ss.subspec 'ConnectSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ConnectSettingPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/ConnectSettingPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ConnectSettingPage/Model/**'
      end
    end
    
    ss.subspec 'ConnectSuccessPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ConnectSuccessPage/Controller/**'
      end
    end
    
    ss.subspec 'DebuggerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/DebuggerPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/DebuggerPage/View'
      end
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/DebuggerPage/View/**'
      end
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/DeviceInfoPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/DeviceInfoPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/DeviceInfoPage/Model/**'
      end
    end
    
    ss.subspec 'DeviceListPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/DeviceListPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/DeviceListPage/View'
      
        ssss.dependency 'MKNBHplugApp/Functions/ServerForApp/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/ScanPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/SwitchStatePage/Controller'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/DeviceListPage/View/**'
      end
    end
    
    ss.subspec 'ElectricityPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ElectricityPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/ElectricityPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ElectricityPage/Model/**'
      end
    end
    
    ss.subspec 'EnergyPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/EnergyPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/EnergyPage/Model'
        ssss.dependency 'MKNBHplugApp/Functions/EnergyPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/EnergyPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/EnergyPage/View/**'
      end
    end
    
    ss.subspec 'EnergyParamPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/EnergyParamPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/EnergyParamPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/EnergyParamPage/Model/**'
      end
    end
    
    ss.subspec 'ImportServerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ImportServerPage/Controller/**'
      end
    end
    
    ss.subspec 'IndicatorColorPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/IndicatorColorPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/IndicatorColorPage/Model'
        ssss.dependency 'MKNBHplugApp/Functions/IndicatorColorPage/View'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/IndicatorColorPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/IndicatorColorPage/View/**'
      end
    end
    
    ss.subspec 'IndicatorSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/IndicatorSettingPage/Controller/**'
        
        ssss.dependency 'MKNBHplugApp/Functions/IndicatorSettingPage/Model'
        
        ssss.dependency 'MKNBHplugApp/Functions/IndicatorColorPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/IndicatorSettingPage/Model/**'
      end
    end
    
    ss.subspec 'ModifyMQTTServerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ModifyMQTTServerPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/ModifyMQTTServerPage/Model'
        ssss.dependency 'MKNBHplugApp/Functions/ModifyMQTTServerPage/View'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ModifyMQTTServerPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ModifyMQTTServerPage/View/**'
      end
    end
    
    ss.subspec 'MQTTSettingInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/MQTTSettingInfoPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/MQTTSettingInfoPage/Model'
        ssss.dependency 'MKNBHplugApp/Functions/MQTTSettingInfoPage/View'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/MQTTSettingInfoPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/MQTTSettingInfoPage/View/**'
      end
    end
    
    ss.subspec 'NotificationSwitchPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/NotificationSwitchPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/NotificationSwitchPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/NotificationSwitchPage/Model/**'
      end
    end
    
    ss.subspec 'NTPServerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/NTPServerPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/NTPServerPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/NTPServerPage/Model/**'
      end
    end
    
    ss.subspec 'OTAPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/OTAPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/OTAPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/OTAPage/Model/**'
      end
    end
    
    ss.subspec 'PeriodicalReportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/PeriodicalReportPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/PeriodicalReportPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/PeriodicalReportPage/Model/**'
      end
    end
    
    ss.subspec 'PowerOnModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/PowerOnModePage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/PowerOnModePage/Model'
        ssss.dependency 'MKNBHplugApp/Functions/PowerOnModePage/View'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/PowerOnModePage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/PowerOnModePage/View/**'
      end
    end
    
    ss.subspec 'PowerReportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/PowerReportPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/PowerReportPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/PowerReportPage/Model/**'
      end
    end
    
    ss.subspec 'ProtectionConfigPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ProtectionConfigPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/ProtectionConfigPage/Model'
        ssss.dependency 'MKNBHplugApp/Functions/ProtectionConfigPage/Header'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ProtectionConfigPage/Model/**'
        
        ssss.dependency 'MKNBHplugApp/Functions/ProtectionConfigPage/Header'
      end
      
      sss.subspec 'Header' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ProtectionConfigPage/Header/**'
      end
    end
    
    ss.subspec 'ProtectionSwitchPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ProtectionSwitchPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/ProtectionConfigPage/Controller'
      end
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ScanPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/ScanPage/Model'
        ssss.dependency 'MKNBHplugApp/Functions/ScanPage/View'
        
        ssss.dependency 'MKNBHplugApp/Functions/AddDevicePage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/DebuggerPage/Controller'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ScanPage/View/**'
        
        ssss.dependency 'MKNBHplugApp/Functions/ScanPage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ScanPage/Model/**'
      end
    end
    
    ss.subspec 'ServerForApp' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ServerForApp/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/ServerForApp/Model'
        ssss.dependency 'MKNBHplugApp/Functions/ServerForApp/View'
        
        ssss.dependency 'MKNBHplugApp/Functions/ImportServerPage/Controller'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ServerForApp/View/**'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ServerForApp/Model/**'
      end
    end
    
    ss.subspec 'ServerForDevice' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ServerForDevice/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/ServerForDevice/Model'
        ssss.dependency 'MKNBHplugApp/Functions/ServerForDevice/View'
        
        ssss.dependency 'MKNBHplugApp/Functions/ImportServerPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/ConnectSuccessPage/Controller'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ServerForDevice/View/**'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/ServerForDevice/Model/**'
      end
    end
    
    ss.subspec 'SettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/SettingsPage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/SettingsPage/Model'
        
        ssss.dependency 'MKNBHplugApp/Functions/PowerOnModePage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/PeriodicalReportPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/PowerReportPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/EnergyParamPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/ConnectSettingPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/SystemTimePage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/ProtectionSwitchPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/NotificationSwitchPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/IndicatorSettingPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/ModifyMQTTServerPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/OTAPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/MQTTSettingInfoPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/DeviceInfoPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/DebuggerPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/SettingsPage/Model/**'
      end
    end
        
    ss.subspec 'SwitchStatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/SwitchStatePage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/SwitchStatePage/Model'
        ssss.dependency 'MKNBHplugApp/Functions/SwitchStatePage/View'
        
        ssss.dependency 'MKNBHplugApp/Functions/ElectricityPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/EnergyPage/Controller'
        ssss.dependency 'MKNBHplugApp/Functions/SettingsPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/SwitchStatePage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/SwitchStatePage/View/**'
      end
    end
    
    ss.subspec 'SystemTimePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/SystemTimePage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/SystemTimePage/Model'
        ssss.dependency 'MKNBHplugApp/Functions/SystemTimePage/View'
        
        ssss.dependency 'MKNBHplugApp/Functions/NTPServerPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/SystemTimePage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/SystemTimePage/View/**'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/UpdatePage/Controller/**'
      
        ssss.dependency 'MKNBHplugApp/Functions/UpdatePage/Model'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKNBHplugApp/Classes/Functions/UpdatePage/Model/**'
      end
    
      sss.dependency 'iOSDFULibrary'
    end
    
    ss.dependency 'MKNBHplugApp/SDK'
    ss.dependency 'MKNBHplugApp/Expand'
  
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'CTMediator'
    
  end
  
end
