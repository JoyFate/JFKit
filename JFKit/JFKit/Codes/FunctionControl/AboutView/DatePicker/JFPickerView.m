//
//  JFPickerView.m
//  ZXBuilding
//
//  Created by hudan on 2017/5/16.
//  Copyright © 2017年 zxwl. All rights reserved.
//

#import "JFPickerView.h"
#import "JFButton.h"
#import "JFDeviceInfo.h"

@interface JFPickerView ()

@property (nonatomic, strong) UIView *pickerSuperView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) JFButton *sureButton;

@end

@implementation JFPickerView

- (instancetype)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    
}

- (void)hideSelf
{
    [self setHidden:YES];
}

#pragma mark - Getter
- (UIView *)pickerSuperView
{
    if (!_pickerSuperView) {
        UIView *superView = [[UIView alloc] init];
        superView.backgroundColor = [UIColor whiteColor];
        
        JFButton *sureButton = [[JFButton alloc] init];
        sureButton.title = @"确定";
        sureButton.titleColor = [UIColor blackColor];
        sureButton.titleFontSize = fJFFontSize(30);
        
        __weak typeof(self) weakSelf = self;
        sureButton.clickBlock = ^(UIButton *sender) {
            [weakSelf hideSelf];
        };
        
        _pickerSuperView = superView;
    }
    return _pickerSuperView;
}

@end
