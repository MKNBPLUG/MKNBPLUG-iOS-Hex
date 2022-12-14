//
//  MKNBHStartDFUCell.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/15.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHStartDFUCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"

@implementation MKNBHStartDFUCellModel
@end

@interface MKNBHStartDFUCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *startButton;

@end

@implementation MKNBHStartDFUCell

+ (MKNBHStartDFUCell *)initCellWithTableView:(UITableView *)tableView {
    MKNBHStartDFUCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKNBHStartDFUCellIdenty"];
    if (!cell) {
        cell = [[MKNBHStartDFUCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKNBHStartDFUCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.startButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(65.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.startButton.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)startButtonPressed {
    if ([self.delegate respondsToSelector:@selector(nbh_startDfuButtonPressed)]) {
        [self.delegate nbh_startDfuButtonPressed];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKNBHStartDFUCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKNBHStartDFUCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [MKCustomUIAdopter customButtonWithTitle:@"Start"
                                                         target:self
                                                         action:@selector(startButtonPressed)];
    }
    return _startButton;
}

@end
