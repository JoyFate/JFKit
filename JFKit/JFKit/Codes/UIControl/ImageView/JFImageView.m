//
//  JFImageView.m
//  JFKit
//
//  Created by 胡丹 on 16/8/1.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFImageView.h"

@implementation JFImageView

- (void)setRadiusImage:(UIImage *)image radius:(CGFloat)radius
{
    CGRect rect = (CGRect){0.f, 0.f, image.size};
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newImage;
}

+ (instancetype)makeWithImage:(UIImage *)image radius:(CGFloat)radius
{
    JFImageView *imageView = [[JFImageView alloc] initWithImage:image];
    
    if (radius != 0) {
        imageView.layer.cornerRadius = radius;
        imageView.layer.masksToBounds = YES;
    }
    
    return imageView;
}

- (void)addTarget:(id)target action:(SEL)action
{
    if (target && action) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGtr = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:tapGtr];
    }
}
@end
