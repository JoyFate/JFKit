//
//  JFTextView.h
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JFTextViewOverMaxNumberBlock)();              // 超过最大限制字数的 block

@protocol JFTextViewDelegate <NSObject>

@optional
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;

- (void)textViewDidBeginEditing:(UITextView *)textView;
- (void)textViewDidEndEditing:(UITextView *)textView;

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)textViewDidChange:(UITextView *)textView;

- (void)textViewDidChangeSelection:(UITextView *)textView;

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0);
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0);

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead");
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead");

@end

@interface JFTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) CGFloat lineSpace;

@property (nonatomic, assign) NSInteger maxNumber;              // 最大字数 (默认为0,不限制)

@property (nonatomic, assign) CGFloat placeholderFontSize;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat contentWidth;

@property (nonatomic, assign) id<JFTextViewDelegate> jfDelegate;

@property (nonatomic, copy) JFTextViewOverMaxNumberBlock overMaxBlock;

@end
