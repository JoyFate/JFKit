//
//  ViewController.m
//  JFKit
//
//  Created by hudan on 2017/6/28.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "ViewController.h"

#import <Masonry.h>

#import "JFButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    JFButton *button = [JFButton make];
    button.bgColor = [UIColor redColor];
    button.frame = CGRectMake(0, 0, 200, 200);
    
    [button addTarget:self action:@selector(buttonClick)];
    [self.view addSubview:button];
    
}

- (void)buttonClick
{
    NSLog(@"click!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
