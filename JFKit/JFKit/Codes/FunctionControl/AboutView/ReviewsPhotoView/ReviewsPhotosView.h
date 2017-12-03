//
//  ReviewsPhotosView.h
//  JFKit
//
//  Created by hudan on 16/12/15.
//  Copyright © 2016年 hudan. All rights reserved.
//

/**
    商品评价图片选择视图
 */

#import <UIKit/UIKit.h>

@interface ReviewsPhotosView : UIView

- (instancetype)initWithAddImage:(NSString *)addImage deleteImage:(NSString *)deleteImage;

@property (nonatomic, strong) UINavigationController *navController;    // 跳转相册的 navigationController

@property (nonatomic, strong, readonly) NSArray *images;                // 已选择的图片

@end


#pragma mark - reviewPhotoTmpObject 用于记录图片和对应的删除按钮
@interface ReviewPhotoTmpObject : NSObject

- (instancetype)initWithAddImage:(NSString *)addImage;

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, assign) BOOL hidden;

// 设置第一个为添加
- (void)setFirstAddButton;

@end
