//
//  MKNBHEnergyDataCell.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/1.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHEnergyDataCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@implementation MKNBHEnergyDataCellModel
@end

@interface MKNBHEnergyDataCell ()

@property (nonatomic, strong)UILabel *leftMsgLabel;

@property (nonatomic, strong)UILabel *rightMsgLabel;

@end

@implementation MKNBHEnergyDataCell

+ (MKNBHEnergyDataCell *)initCellWithTableView:(UITableView *)tableView {
    MKNBHEnergyDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKNBHEnergyDataCellIdenty"];
    if (!cell) {
        cell = [[MKNBHEnergyDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKNBHEnergyDataCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftMsgLabel];
        [self.contentView addSubview:self.rightMsgLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.leftMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-5.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.rightMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(5.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKNBHEnergyDataCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKNBHEnergyDataCellModel.class]) {
        return;
    }
    self.leftMsgLabel.text = SafeStr(_dataModel.leftMsg);
    self.rightMsgLabel.text = SafeStr(_dataModel.rightMsg);
}

#pragma mark - getter
- (UILabel *)leftMsgLabel {
    if (!_leftMsgLabel) {
        _leftMsgLabel = [[UILabel alloc] init];
        _leftMsgLabel.textAlignment = NSTextAlignmentLeft;
        _leftMsgLabel.textColor = DEFAULT_TEXT_COLOR;
        _leftMsgLabel.font = MKFont(13.f);
    }
    return _leftMsgLabel;
}

- (UILabel *)rightMsgLabel {
    if (!_rightMsgLabel) {
        _rightMsgLabel = [[UILabel alloc] init];
        _rightMsgLabel.textAlignment = NSTextAlignmentRight;
        _rightMsgLabel.textColor = DEFAULT_TEXT_COLOR;
        _rightMsgLabel.font = MKFont(13.f);
    }
    return _rightMsgLabel;
}

@end
