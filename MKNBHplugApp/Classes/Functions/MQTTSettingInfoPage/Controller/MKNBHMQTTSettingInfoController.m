//
//  MKNBHMQTTSettingInfoController.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/25.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHMQTTSettingInfoController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"

#import "MKNBHMQTTSettingForDeviceCell.h"

#import "MKNBHMQTTSettingInfoModel.h"

@interface MKNBHMQTTSettingInfoController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKNBHMQTTSettingInfoModel *dataModel;

@end

@implementation MKNBHMQTTSettingInfoController

- (void)dealloc {
    NSLog(@"MKNBHMQTTSettingInfoController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKNBHMQTTSettingForDeviceCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKNBHMQTTSettingForDeviceCell *cell = [MKNBHMQTTSettingForDeviceCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - interface
#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKNBHMQTTSettingForDeviceCellModel *cellModel1 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel1.msg = @"Type";
    cellModel1.rightMsg = SafeStr(self.dataModel.type);
    [self.dataList addObject:cellModel1];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel2 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel2.msg = @"Host";
    cellModel2.rightMsg = SafeStr(self.dataModel.host);
    [self.dataList addObject:cellModel2];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel3 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel3.msg = @"Port";
    cellModel3.rightMsg = SafeStr(self.dataModel.port);
    [self.dataList addObject:cellModel3];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel4 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel4.msg = @"Client Id";
    cellModel4.rightMsg = SafeStr(self.dataModel.clientID);
    [self.dataList addObject:cellModel4];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel5 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel5.msg = @"Username";
    cellModel5.rightMsg = SafeStr(self.dataModel.userName);
    [self.dataList addObject:cellModel5];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel6 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel6.msg = @"Password";
    cellModel6.rightMsg = SafeStr(self.dataModel.password);
    [self.dataList addObject:cellModel6];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel7 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel7.msg = @"Clean Session";
    cellModel7.rightMsg = SafeStr(self.dataModel.cleanSession);
    [self.dataList addObject:cellModel7];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel8 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel8.msg = @"Qos";
    cellModel8.rightMsg = SafeStr(self.dataModel.qos);
    [self.dataList addObject:cellModel8];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel9 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel9.msg = @"Keep Alive";
    cellModel9.rightMsg = SafeStr(self.dataModel.keepAlive);
    [self.dataList addObject:cellModel9];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel10 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel10.msg = @"LWT";
    cellModel10.rightMsg = SafeStr(self.dataModel.lwt);
    [self.dataList addObject:cellModel10];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel11 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel11.msg = @"LWT Retain";
    cellModel11.rightMsg = SafeStr(self.dataModel.lwtRetain);
    [self.dataList addObject:cellModel11];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel12 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel12.msg = @"LWT Qos";
    cellModel12.rightMsg = SafeStr(self.dataModel.lwtQos);
    [self.dataList addObject:cellModel12];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel13 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel13.msg = @"LWT Topic";
    cellModel13.rightMsg = SafeStr(self.dataModel.lwtTopic);
    [self.dataList addObject:cellModel13];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel14 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel14.msg = @"LWT Payload";
    cellModel14.rightMsg = SafeStr(self.dataModel.lwtPayload);
    [self.dataList addObject:cellModel14];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel15 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel15.msg = @"Device Id";
    cellModel15.rightMsg = SafeStr(self.dataModel.deviceID);
    [self.dataList addObject:cellModel15];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel16 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel16.msg = @"Published Topic";
    cellModel16.rightMsg = SafeStr(self.dataModel.publishedTopic);
    [self.dataList addObject:cellModel16];
    
    MKNBHMQTTSettingForDeviceCellModel *cellModel17 = [[MKNBHMQTTSettingForDeviceCellModel alloc] init];
    cellModel17.msg = @"Subscribed Topic";
    cellModel17.rightMsg = SafeStr(self.dataModel.subscribedTopic);
    [self.dataList addObject:cellModel17];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Settings for Device";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (MKNBHMQTTSettingInfoModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKNBHMQTTSettingInfoModel alloc] init];
    }
    return _dataModel;
}

@end
