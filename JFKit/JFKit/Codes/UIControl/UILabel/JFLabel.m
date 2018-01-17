//
//  JFLabel.m
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFLabel.h"

#import "NSAttributedString+JF.h"
#import "JFDeviceInfo.h"


@implementation JFLabel

- (instancetype)init
{
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}

- (void)initData
{
    self.width = 0;
    
    self.contentMode = UIViewContentModeTop;
}

- (void)addAttribute:(NSDictionary *)attribute range:(NSRange)range
{
    NSMutableAttributedString *tmpString = nil;
    
    if (self.attributedText.length != 0) {
        tmpString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    else if (self.text.length != 0) {
        tmpString = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    
    if (range.location < tmpString.length - 1) {
        if ((tmpString.length - 1 - range.location) >= range.length) {
            [tmpString addAttributes:attribute range:range];
            self.attributedText = tmpString;
        }
    }
}

#pragma mark - Setter
- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    
    self.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setBlodFontSize:(CGFloat)blodFontSize
{
    _blodFontSize = blodFontSize;
    
    self.font = [UIFont boldSystemFontOfSize:blodFontSize];
}

- (void)setLineSpace:(CGFloat)lineSpace
{
    _lineSpace = lineSpace;
    
    NSString *text = self.text.length == 0 ? @"填充" : self.text;
    self.attributedText = [NSAttributedString getAttributeString:text lineSpacing:lineSpace];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    if (self.lineSpace != 0) {
        NSMutableAttributedString *mAttrString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString getAttributeString:text lineSpacing:self.lineSpace]];
        NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
        style.alignment = self.textAlignment;
        style.lineSpacing = self.lineSpace;
        [mAttrString addAttributes:@{NSFontAttributeName : self.font,
                                     NSParagraphStyleAttributeName : style
                                     } range:NSMakeRange(0, text.length)];
        
        self.attributedText = mAttrString;
    }
}

- (CGFloat)textHeight
{
    if (self.width == 0) {
        self.width = kJFAppWidth;
    }
    
    CGSize size;
    if (self.attributedText.length != 0) {
        size = [self.attributedText boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine context:nil].size;
        
        // 当只有一行的时候,去除行间距的高度
        if (self.numberOfLines != 1 && size.height <= (self.font.pointSize + self.lineSpace + 4)) {
 
            NSMutableAttributedString *mAttrString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString getAttributeString:self.text lineSpacing:0]];
            [mAttrString addAttributes:@{NSFontAttributeName : self.font} range:NSMakeRange(0, self.text.length)];
            
            self.attributedText = mAttrString;
            
            size.height = self.font.pointSize;
        }
    }
    else {
        size = [self.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil].size;
    }
    
    
    return size.height + 1;
}

@end
