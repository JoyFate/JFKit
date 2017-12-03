//
//  JFImageTool.h
//  JFKit
//
//  Created by joyFate on 16/7/28.
//  Copyright © 2016年 hudan. All rights reserved.
//

/**
 *  图片处理类
 */

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface JFImageTool : NSObject

#pragma mark - 图片生成
/**
 *  根据颜色生成纯色图片
 *
 *  @param color 图片的颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  视图转换成图片
 *
 *  @param converView 需要转换的视图
 *
 *  @return 转换后的生成的图片
 */
+ (UIImage *)converViewToImage:(UIView *)converView;

/**
 生成二维码
 
 @param string 数据
 @param Imagesize 图片大小
 @return 生成的二维码图片
 */
+ (UIImage *)qrImageForString:(NSString *)string
                    imageSize:(CGFloat)Imagesize;

#pragma mark - 图片基本处理

/**
 *  将图片旋转至正常方向
 *
 *  @param image 需要旋转的图片
 *
 *  @return 旋转后的图片
 */
+ (UIImage *)fixImageOrientation:(UIImage *)image;

/**
 压缩图片到指定大小
 
 @param targetSize 目标图片的大小
 @param sourceImage 原图
 @return 目标图片
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
                             withSourceImage:(UIImage *)sourceImage;

#pragma mark - 图片模糊
/**
 图片超出指定大小裁剪
 
 @param sourceImage 源图片
 @param targetSize 指定大小
 @return 裁剪后的图片
 */
+ (UIImage *)handleImage:(UIImage *)sourceImage withSize:(CGSize)targetSize;

/**
 根据像素范围裁剪图片
 
 @param image 需要裁剪的图片
 @param oritation 图片方向
 @param rect 裁剪的范围 (像素)
 @return 裁剪后的图片
 */
+ (UIImage *)clipImage:(UIImage *)image
        imageoritation:(UIImageOrientation)oritation
              withRect:(CGRect)rect;

/**
 图片按宽度等比处理

 @param sourceImage 原图片
 @param defineWidth 指定的宽度 (超过宽度就会进行处理)
 @return 处理后的图片
 */
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

/**
 图片按高度等比处理

 @param sourceImage 原图片
 @param defineHeight 指定的高度 (超过高度就会进行处理)
 @return 处理后的图片
 */
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetHeight:(CGFloat)defineHeight;

#pragma mark - 图片纹理处理

/**
 将图片生成高斯模糊图片(cgImage)
 
 @param image 图片
 @param blur 模糊指数 (1 ~ 10)
 @return 生成的图片
 */
+(UIImage *)makeBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/**
 将图片生成高斯模糊图片(cvImage)

 @param image 原图片
 @param blur 模糊度 (0 ~ 1)
 @return 生成的图片
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/**
 生成一张模糊的蒙版

 @return 生成的蒙版,用于添加到需要的视图上
 */
+ (UIVisualEffectView *)makeBlurCoverView;


/**
 在图片上添加文字

 @param image 图片
 @param text 文字
 @param textColor 文字颜色
 @param font 字体
 @return 生成的文字
 */
+(UIImage *)addTextInImage:(UIImage *)image
                      text:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font;


/**
 修改图片颜色

 @param image 图片
 @param tintColor 渲染色
 @param blendMode 模式
 @return 生成的图片
 */
+ (UIImage *)imageColorChanged:(UIImage *)image
                     tintColor:(UIColor *)tintColor
                     blendMode:(CGBlendMode)blendMode;



@end
