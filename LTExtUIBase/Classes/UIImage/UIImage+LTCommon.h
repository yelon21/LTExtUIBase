//
//  UIImage+LTCommon.h
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ImageNamed(imageName_) [UIImage imageNamed:imageName_]
#define ImageWithPath(imagePath)[UIImage lt_imageWithPath:imagePath]

@interface UIImage (LTCommon)

/**
 *  @author yelon
 *
 *  根据颜色返回相应图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage*_Nullable) lt_imageWithColor:(UIColor*_Nonnull)color;
/**
 *  @author yelon
 *
 *  将图片内容转换为相应颜色
 *
 *  @param tintColor 设置的目标颜色
 *
 *  @return 图片
 */
- (UIImage *_Nonnull) lt_imageWithTintColor:(UIColor *_Nonnull)tintColor;
/**
 *  @author yelon
 *
 *  将图片压缩到指定大小之下
 *
 *  @param max 设置的图片最大值
 *
 *  @return NSData类型的图片
 */
- (NSData *_Nonnull)lt_fitImageMaxData:(float)max;
/**
 *  @author yelon
 *
 *  将图片压缩成指定尺寸
 *
 *  @param size 设置的尺寸
 *
 *  @return 图片数据
 */
- (UIImage *_Nonnull)lt_thumbImage:(CGSize)size;

+ (UIImage *_Nullable)lt_imageName:(NSString *_Nonnull)name;
+ (UIImage *_Nullable)lt_imageWithPath:(NSString *_Nonnull)imagePath;

/**
 根据高度 比例缩放
 
 @param size 指定最大边长
 @return 新图片
 */
- (UIImage *_Nonnull)lt_scaleImageToMaxSize:(CGFloat)size;
/**
根据高度 比例缩放

 @param height 指定高度
 @return 新图片
 */
- (UIImage *_Nonnull)lt_scaleImageByDefaultHeight:(CGFloat)height;
/**
 根据宽度 比例缩放
 
 @param width 指定宽度
 @return 新图片
 */
- (UIImage *_Nonnull)lt_scaleImageByDefaultWidth:(CGFloat)width;

/**
 添加文字水印

 @param markString 文字内容
 @param color 文本颜色
 @param font 字体
 @return 添加后的图片
 */
- (UIImage *_Nonnull)lt_imageWithMarkString:(NSString *_Nullable)markString
                              color:(UIColor *_Nullable)color
                               font:(UIFont *_Nonnull)font;

/**
  添加文字水印

 @param markString 文字内容
 @param inRect 文本所在图片位置
 @param attrs 文本修饰属性
 @return 添加后的图片
 */
- (UIImage *_Nonnull)lt_imageWithMarkString:(NSString *_Nullable)markString
                             inRect:(CGRect)inRect
                     withAttributes:(nullable NSDictionary<NSString *, id> *)attrs;
@end
