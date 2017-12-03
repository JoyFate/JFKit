//
//  JFSingleInputView.m
//  ZXDressingMirror
//
//  Created by hudan on 2017/9/12.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "JFSingleInputView.h"

#import "JFTextField.h"
#import "JFDeviceInfo.h"
#import "NSArray+JF.h"
#import <Masonry.h>

#define kDefaultFieldWith fJFScreen(80)
#define kDefaultFieldMargin fJFScreen(10)

@interface JFSingleInputView () <UITextFieldDelegate>

@property (nonatomic, assign) NSInteger count;            // 输入框的数量

@property (nonatomic, strong) NSArray *fieldsArray;       // 输入框的存放数组

@end

@implementation JFSingleInputView

#pragma mark - LifeCycle
- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public
- (instancetype)initWithNumber:(NSInteger)number frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.count = number;
        
        [self initUI];
    }
    return self;
}

- (instancetype)initWithNumber:(NSInteger)number attributes:(NSDictionary *)attributes frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.count = number;
        self.attributes = attributes;
        
        [self initUI];
    }
    return self;
}

#pragma mark - UI

- (void)initUI
{    
    // 创建输入框
    self.fieldsArray = [self makeFields];
    
    // 界面编排
    if (self.fieldsArray.count > 0) {
        // 判断是否会超过APP界面
        CGFloat width = self.count * (self.fieldSize.width == 0 ? kDefaultFieldWith : self.fieldSize.width);
        
        if (self.count > 1) {
            width += (self.count - 1) * (self.fieldMargin == 0 ? kDefaultFieldMargin : self.fieldMargin);
        }
        
        // 检验是否会超出界面显示范围
        if (self.frame.size.width > 0) {
            if (width > self.frame.size.width) {
#ifdef DEBUG
                NSAssert(NO, @"超过了屏幕的最大宽度, 请重新设定");
                return;
#endif
            }
        }
        else if (width > kJFAppWidth) {
#ifdef DEBUG
            NSAssert(NO, @"超过了屏幕的最大宽度, 请重新设定");
            return;
#endif
        }
        
        if (width > 0) {
            // 居中布局
            // 第一个输入框的位置
            CGFloat x = (kJFAppWidth - width)/2;
            CGFloat fieldWidth = self.fieldSize.width == 0 ? kDefaultFieldWith : self.fieldSize.width;
            CGFloat fieldMargin = self.fieldMargin == 0 ? kDefaultFieldMargin : self.fieldMargin;
            
            for (NSInteger index = 0; index < self.fieldsArray.count; index++) {
                
                JFTextField *field = [self.fieldsArray objectAtIndexSafe:index];
                
                [self addSubview:field];
                [field mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(x + (fieldWidth + fieldMargin)*index);
                    make.width.height.mas_equalTo(fieldWidth);
                    make.centerY.equalTo(self);
                }];
            }
        }
    }
    
    // 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (NSArray *)makeFields
{
    if (self.count > 0) {
        
        NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:self.count];
        
        for (NSInteger index = 0; index < self.count; index++) {
            JFTextField *field = [self makeFieldWithTag:index];
            [tmpArray addObject:field];
        }
        
        return [tmpArray copy];
    }
    else {
        return @[];
    }
}

- (JFTextField *)makeFieldWithTag:(NSInteger)tag
{
    JFTextField *field = [[JFTextField alloc] init];
    
    [self initializeField:field tag:tag];
    
    if (self.attributes) {
        
        NSDictionary *attributes = self.attributes;
        
        if ([attributes objectForKey:JFSingleInputBorderColor]) {
            field.layer.borderColor = ((UIColor *)[attributes objectForKey:JFSingleInputBorderColor]).CGColor;
        }
        if ([attributes objectForKey:JFSingleInputTintColor]) {
            field.tintColor = (UIColor *)[attributes objectForKey:JFSingleInputTintColor];
        }
        if ([attributes objectForKey:JFSingleInputTextColor]) {
            field.textColor = (UIColor *)[attributes objectForKey:JFSingleInputTextColor];
        }
        if ([attributes objectForKey:JFSingleInputFontSize]) {
            field.fontSize = [[attributes objectForKey:JFSingleInputFontSize] floatValue];
        }
        if ([[attributes objectForKey:JFSingleInputBorderWidth] floatValue] != 0) {
            field.layer.borderWidth = [[attributes objectForKey:JFSingleInputBorderWidth] floatValue];
        }
        if ([attributes objectForKey:JFSingleInputCornerRadius]) {
            field.layer.cornerRadius = [[attributes objectForKey:JFSingleInputCornerRadius] floatValue];
        }
        if (self.fieldSize.width > 0) {
            CGRect frame = CGRectMake(0, 0, self.fieldSize.width, self.fieldSize.height);
            field.frame = frame;
        }
    }
    
    return field;
}

// 默认值设置
- (void)initializeField:(JFTextField *)field tag:(NSInteger)tag
{
    __weak typeof(self) weakself = self;
    
    field.textAlignment = NSTextAlignmentCenter;

    field.layer.borderWidth = 0.5f;
    field.layer.borderColor = [UIColor blackColor].CGColor;
    CGRect frame = CGRectMake(0, 0, kDefaultFieldWith, kDefaultFieldWith);
    field.frame = frame;
    
    field.delegate = self;
    field.keyboardType = UIKeyboardTypeNumberPad;
    field.tag = tag;
    field.deleteBackwardBlock = ^(JFTextField *textField) {
        [weakself fieldBackForward:textField];
    };
    
    if (tag == 0) {
        [field becomeFirstResponder];
    }
}

#pragma mark - Focus on Field

- (void)fieldDidChanged:(NSNotification *)noti
{
    JFTextField *currField = noti.object;
    
    if (currField.text.length == 0) {
        // 删除动作
        
    }
    else if (currField.text.length == 1) {
        
        // 当每个输入框都有数据说明填完了
        BOOL finish = YES;
        NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:self.count];
        
        for (NSInteger index = 0; index < self.count; index++) {
            
            JFTextField *field = [self.fieldsArray objectAtIndexSafe:index];
            
            [tmpArray addObject:field.text];
            
            if (field.text.length == 0) {
                finish = NO;
                [tmpArray removeAllObjects];
                tmpArray = nil;
                break;
            }
        }
        
        if (finish == YES) {
            if (self.finishBlock) {
                self.finishBlock(tmpArray);
            }
        }
        
        // 如果有下一个, 聚焦下一个
        if (currField.tag < self.count - 1) {
            
            JFTextField *nextField = [self.fieldsArray objectAtIndexSafe:(currField.tag + 1)];
            
            // 如果下一个输入框内容为空, 则聚焦
            if (nextField.text.length == 0) {
                [nextField becomeFirstResponder];
            }
        }
    }
    else {
        // 最后一个, 不能输入多余的数据, 除去第一个以外的内容
        NSMutableString *tmpString = [NSMutableString stringWithString:currField.text];
        currField.text = [tmpString substringWithRange:NSMakeRange(0, 1)];
    }
}

- (void)fieldBackForward:(JFTextField *)field
{
    // 如果有上一个, 聚焦上一个
    if (field.tag > 0) {
        JFTextField *lastField = [self.fieldsArray objectAtIndexSafe:(field.tag - 1)];
        [lastField becomeFirstResponder];
    }
    else {
        [field becomeFirstResponder];
    }
}

#pragma mark - Setter
- (void)setAttributes:(NSDictionary *)attributes
{
    _attributes = [attributes copy];
    
    if ([attributes objectForKey:JFSingleInputSize]) {
        self.fieldSize = [[attributes objectForKey:JFSingleInputSize] CGSizeValue];
    }
    if ([attributes objectForKey:JFSingleInputMargin]) {
        self.fieldMargin = [[attributes objectForKey:JFSingleInputMargin] floatValue];
    }
}

- (void)setCloseFirstFoucsOn:(BOOL)closeFirstFoucsOn
{
    _closeFirstFoucsOn = closeFirstFoucsOn;
    
    if (closeFirstFoucsOn) {
        if (self.fieldsArray.count > 0) {
            JFTextField *field = [self.fieldsArray objectAtIndexSafe:0];
            [field resignFirstResponder];
        }
    }
}

@end
