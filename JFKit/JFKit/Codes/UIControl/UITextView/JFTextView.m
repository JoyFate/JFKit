//
//  JFTextView.m
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFTextView.h"

#import "JFDeviceInfo.h"
#import "JFColor.h"

@interface JFTextView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation JFTextView

- (instancetype)init
{
    if (self = [super init]) {
        [self initData];
        
        // 先关闭可编辑,影响 placeholder 手势触发
//        [self setEditable:NO];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initData];
        
        self.contentWidth = frame.size.width;
    }
    return self;
}

- (void)initData
{
    self.delegate = self;
    
    self.leftMargin = 0;
    self.contentWidth = [[UIScreen mainScreen] bounds].size.width;
    self.placeholderFontSize = 0;
    self.lineSpace = 0;
    self.maxNumber = 0;
}

- (void)placeholderHideToBeginEdit
{
    [self.placeHolderLabel setHidden:YES];
    [self setEditable:YES];
    
    [self becomeFirstResponder];
}

- (NSAttributedString *)getAttributeString:(NSString *)text lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributeAtring =[[NSMutableAttributedString alloc]initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:fJFScreen6(lineSpacing)];
    [attributeAtring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [attributeAtring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.f] range:NSMakeRange(0, [text length])];
    
    return attributeAtring;
}

#pragma mark - Setter

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    if (self.placeHolderLabel) {
        
        [self.placeHolderLabel removeFromSuperview];
        
        self.placeHolderLabel = nil;
    }
    
    self.placeHolderLabel = [[UILabel alloc] init];
    [self.placeHolderLabel setFont:[UIFont systemFontOfSize:self.placeholderFontSize]];
    [self.placeHolderLabel setTextColor:HexColor(0x999999)];
    
    // 添加手势
    UITapGestureRecognizer *tapGtr = [[UITapGestureRecognizer alloc] init];
    [tapGtr addTarget:self action:@selector(placeholderHideToBeginEdit)];
    [self.placeHolderLabel addGestureRecognizer:tapGtr];
    [self.placeHolderLabel setUserInteractionEnabled:YES];
    
    [self.placeHolderLabel setText:placeholder];
    
    CGSize textSize = [placeholder sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.placeholderFontSize]}];
    
    [self.placeHolderLabel setFrame:CGRectMake(self.leftMargin, 5, textSize.width + 4, textSize.height)];
    
    [self addSubview:self.placeHolderLabel];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self.placeHolderLabel setFont:font];
    self.placeholderFontSize = font.pointSize;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.contentWidth = frame.size.width;
}

#pragma mark - Getter
- (CGFloat)placeholderFontSize
{
    if (_placeholderFontSize == 0) {
        _placeholderFontSize = 15.f;
        
//        self.font = [UIFont systemFontOfSize:_fontSize];
    }
    return _placeholderFontSize;
}

- (CGFloat)leftMargin
{
    if (_leftMargin == 0) {
        _leftMargin = 5.f;
    }
    return _leftMargin;
}

#pragma mark - textView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (!self.placeHolderLabel.hidden) {
        [self.placeHolderLabel setHidden:YES];
    }
    
    if ([textView.text isEqualToString:@""] && self.lineSpace != 0) {
        textView.attributedText = [self getAttributeString:@" " lineSpacing:self.lineSpace];    // 设置行间距
    }
    
    if ([self.jfDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        [self.jfDelegate textViewShouldBeginEditing:textView];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.jfDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        [self.jfDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // 去除设置行间距时的空白输入
    NSRange range = [textView.text rangeOfString:@" "];
    if (range.location == 0) {
        NSAttributedString *tmpString = textView.attributedText;
        
        tmpString = [tmpString attributedSubstringFromRange:NSMakeRange(1, tmpString.length - 1)];
        
        textView.attributedText = tmpString;
    }
    
    if ([self.jfDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.jfDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0 || [textView.text isEqualToString:@" "]) {
        [self.placeHolderLabel setHidden:NO];
//        [self setEditable:NO];
    }
    
    if ([self.jfDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.jfDelegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.jfDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        [self.jfDelegate textViewShouldEndEditing:textView];
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    // 不设置最大字数限制不进入判断
    if (self.maxNumber != 0) {
        if (textView.text.length > self.maxNumber) {
            
            NSString *tmpString = textView.text;
            textView.text = [tmpString substringToIndex:150];
            
            if (self.overMaxBlock) {
                self.overMaxBlock();
            }
        }
    }
    
    if ([self.jfDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.jfDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([self.jfDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.jfDelegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    if ([self.jfDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:interaction:)]) {
        [self.jfDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange interaction:interaction];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    if ([self.jfDelegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:interaction:)]) {
        [self.jfDelegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange interaction:interaction];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if ([self.jfDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        [self.jfDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    if ([self.jfDelegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        [self.jfDelegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    
    return YES;
}

@end
