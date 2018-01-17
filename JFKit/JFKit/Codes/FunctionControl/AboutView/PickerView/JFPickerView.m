//
//  JFPickerView.m
//  JFKit
//
//  Created by MAC on 2018/1/17.
//  Copyright © 2018年 JoyFate. All rights reserved.
//

#import "JFPickerView.h"

#import "JFButton.h"
#import <Masonry.h>

#define kButtonHeight 40

@interface JFPickerView ()
<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, assign) JFPickerType pickerType;
@property (nonatomic, strong) JFPickerModel *currModel;
@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation JFPickerView

- (instancetype)initWithPickerType:(JFPickerType)type
{
    if (self = [super init]) {
        self.pickerType = type;
        
        [self initUI];
    }
    return self;
}

#pragma mark - UI
- (void)initUI
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4f];
    self.frame = [UIScreen mainScreen].bounds;
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.mas_centerY).offset(30);
    }];
    
    JFButton *escButton = [self makeButtonWithTag:0 title:@"取消"];
    [contentView addSubview:escButton];
    [escButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentView);
        make.height.equalTo(@(kButtonHeight));
        make.width.equalTo(@80);
    }];
    
    JFButton *okButton = [self makeButtonWithTag:1 title:@"确定"];
    [contentView addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(contentView);
        make.height.width.mas_equalTo(escButton);
    }];
    
    if (self.pickerType == JFPickerType_Picker) {
        // 选择器
        [contentView addSubview:self.pickerView];
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(contentView);
            make.top.equalTo(contentView).offset(kButtonHeight);
        }];
    }
    else {
        // 时间选择器
        [contentView addSubview:self.datePicker];
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(contentView);
            make.top.equalTo(contentView).offset(kButtonHeight);
        }];
    }
}

- (JFButton *)makeButtonWithTag:(NSInteger)tag title:(NSString *)title
{
    JFButton *button = [JFButton make];
    button.title = title;
    button.titleColor = [UIColor blackColor];
    button.titleFontSize = 20;
    
    if (tag == 0) {
        [button addTarget:self action:@selector(escButtonClick)];
    }
    else {
        [button addTarget:self action:@selector(okButtonClick)];
    }
    
    return button;
}

#pragma mark - Button Click
- (void)escButtonClick
{
    self.hidden = YES;
}

- (void)okButtonClick
{
    self.hidden = YES;
    
    JFPickerModel *model;
    
    if (self.pickerType == JFPickerType_Picker) {
        model = self.currModel;
    }
    else {
        NSDate *date = self.datePicker.date;
        model = [JFPickerModel new];
        model.title = [self.formatter stringFromDate:date];
    }
    
    if (self.selectBlock) {
        self.selectBlock(model);
    }
}

#pragma mark - PickerView DataSource & Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    JFPickerModel *model = [self.dataArray objectAtIndex:row];
    return model.title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    JFPickerModel *model = [self.dataArray objectAtIndex:row];
    self.currModel = model;
}

#pragma mark - Setter
- (void)setDataArray:(NSArray<JFPickerModel *> *)dataArray
{
    _dataArray = dataArray;
    
    // 设置 currModel 的默认值
    if (dataArray.count > 0) {
        self.currModel = [dataArray objectAtIndex:0];
    }
    else {
        self.currModel = nil;
    }
    
    [self.pickerView reloadAllComponents];
}

- (void)setDateMode:(UIDatePickerMode)dateMode
{
    _dateMode = dateMode;
    
    self.datePicker.datePickerMode = _dateMode;
}

- (void)setFormatString:(NSString *)formatString
{
    _formatString = formatString;
    
    self.formatter.dateFormat = _formatString;
}

- (void)setMinDate:(NSDate *)minDate
{
    _minDate = minDate;
    
    self.datePicker.minimumDate = _minDate;
}

- (void)setMaxDate:(NSDate *)maxDate
{
    _maxDate = maxDate;
    
    self.datePicker.maximumDate = _maxDate;
}

#pragma mark - Getter
- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        UIPickerView *picker = [UIPickerView new];
        picker.dataSource = self;
        picker.delegate = self;
        
        _pickerView = picker;
    }
    return _pickerView;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        UIDatePicker *picker = [UIDatePicker new];
        picker.datePickerMode = self.dateMode;
        
        _datePicker = picker;
    }
    return _datePicker;
}

- (NSDateFormatter *)formatter
{
    if (!_formatter) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = self.formatString ? : @"yyyy-MM-dd";
        
        _formatter = formatter;
    }
    return _formatter;
}

@end
