//
//  JFNumberView.m
//  JFKit
//
//  Created by joyFate on 16/7/28.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFNumberView.h"

#import <Masonry.h>

@interface JFNumberView ()

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *subButton;

@end

@implementation JFNumberView

- (instancetype)initWithNumber:(NSInteger)number viewHeight:(CGFloat)height
{
    if (self = [super init]) {
        
        self.canEdit = YES;
        
        self.number = number;
        
        self.subButton = [[UIButton alloc] init];
        [self.subButton setImage:[UIImage imageNamed:@"jf_icon_sub"] forState:UIControlStateNormal];
        [self.subButton addTarget:self action:@selector(subButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.subButton];
        [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.mas_equalTo(height);
        }];
        
        self.addButton = [[UIButton alloc] init];
        [self.addButton setImage:[UIImage imageNamed:@"jf_icon_add"] forState:UIControlStateNormal];
        [self.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self);
            make.width.mas_equalTo(height);
        }];
        
        self.numberLabel = [[UILabel alloc] init];
        [self.numberLabel setText:[NSString stringWithFormat:@"%ld",number]];
        [self.numberLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:self.numberLabel];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.subButton.mas_right);
            make.right.equalTo(self.addButton.mas_left);
        }];
        
    }
    return self;
}

- (void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    
    self.subButton.enabled = self.canEdit;
    self.addButton.enabled = self.canEdit;
}

#pragma mark - button click
// 减按钮点击
- (void)subButtonClick:(UIButton *)sender
{
    if (self.numberWillChangeBlock) {
        if (!self.numberWillChangeBlock(self.number, JFNumberChangeType_Sub)) {
            return;
        }
    }
    
    self.number--;
    if (self.number <= 0) {
        self.number++;
        return;
    }
    
    if (self.numberDidChangeBlock) {
        if (!self.numberDidChangeBlock(self.number, JFNumberChangeType_Sub)) {
            
            self.number++;
            
            return;
        }
    }
    
    [self.numberLabel setText:[NSString stringWithFormat:@"%ld",self.number]];
}

// 加按钮点击
- (void)addButtonClick:(UIButton *)sender
{
    if (self.numberWillChangeBlock) {
        if (!self.numberWillChangeBlock(self.number, JFNumberChangeType_Add)) {
            return;
        }
    }
    
    self.number++;
    if (self.maxNumber != 0) {
        if (self.number > self.maxNumber) {
            self.number--;
            if (self.numberOverMaxBlock) {
                self.numberOverMaxBlock(self.maxNumber);
            }
            return;
        }
    }
    
    if (self.numberDidChangeBlock) {
        if (!self.numberDidChangeBlock(self.number, JFNumberChangeType_Add)) {
            
            self.number--;
            
            return;
        }
    }
    
    [self.numberLabel setText:[NSString stringWithFormat:@"%ld",self.number]];
}

#pragma mark - Setter
- (void)setFontSize:(CGFloat)fontSize
{
    [self.numberLabel setFont:[UIFont systemFontOfSize:fontSize]];
}

- (void)setMaxNumber:(NSInteger)maxNumber
{
    _maxNumber = maxNumber;
    
    if (self.number > _maxNumber && _maxNumber != 0) {
        self.number = _maxNumber;
        [self.numberLabel setText:[NSString stringWithFormat:@"%ld",self.number]];
    }
}

- (void)setAddButtonImage:(NSString *)addButtonImage
{
    _addButtonImage = [addButtonImage copy];
    
    [self.addButton setImage:[UIImage imageNamed:addButtonImage] forState:UIControlStateNormal];
}

- (void)setSubButtonImage:(NSString *)subButtonImage
{
    _subButtonImage = [subButtonImage copy];
    
    [self.subButton setImage:[UIImage imageNamed:subButtonImage] forState:UIControlStateNormal];
}

@end
