//
//  JFAlertView.m
//  JFKit
//
//  Created by hudan on 2017/8/28.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "JFAlertView.h"

@interface JFAlertView () <UIAlertViewDelegate>

@end

@implementation JFAlertView

- (void)setButtonClickBlock:(JFAlertViewButtonBlock)buttonClickBlock
{
    _buttonClickBlock = [buttonClickBlock copy];
    
    if (self.delegate == nil || self.delegate != self) {
        self.delegate = self;
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.buttonClickBlock) {
        self.buttonClickBlock(self, buttonIndex);
    }
}


@end
