//
//  MKNBHSwitchViewButton.m
//  MKNBHplugApp_Example
//
//  Created by aa on 2022/4/20.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKNBHSwitchViewButton.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@implementation MKNBHSwitchViewButtonModel
@end

@interface MKNBHSwitchViewButton ()

@property (nonatomic, strong)UIImageView *icon;

@property (nonatomic, strong)UILabel *msgLabel;

@end

@implementation MKNBHSwitchViewButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.icon];
        [self addSubview:self.msgLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize iconSize = self.icon.image.size;
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(iconSize.width);
        make.top.mas_equalTo(1.f);
        make.height.mas_equalTo(iconSize.height);
    }];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(1.f);
        make.right.mas_equalTo(-1.f);
        make.bottom.mas_equalTo(-1.f);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKNBHSwitchViewButtonModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKNBHSwitchViewButtonModel.class]) {
        return;
    }
    self.icon.image = _dataModel.icon;
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.msgLabel.textColor = _dataModel.msgColor;
    [self setNeedsLayout];
}

#pragma mark - getter
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        _msgLabel.font = MKFont(11.f);
        _msgLabel.textColor = UIColorFromRGB(0x808080);
    }
    return _msgLabel;
}

@end
