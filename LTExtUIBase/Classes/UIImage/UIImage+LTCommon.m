//
//  UIImage+LTCommon.m
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import "UIImage+LTCommon.h"

@implementation UIImage (LTCommon)
//根据颜色返回图片
+ (UIImage*) lt_imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
    //        [UIImage imageWithCIImage:[CIImage imageWithColor:[CIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]]];
}

- (UIImage *) lt_imageWithTintColor:(UIColor *)tintColor
{
    return [self lt_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
    
}

- (UIImage *) lt_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
//设定大小
- (NSData *)lt_fitImageMaxData:(float)max{
    
    NSData *imageData_ = UIImageJPEGRepresentation(self, 1.0);
    while ([imageData_ length] - max > 0) {
        
        UIImage *image_ = [UIImage imageWithData:imageData_];
        if (image_.size.width>320.0 || image_.size.height>240.0) {
            
            image_ = [self lt_thumbImage:CGSizeMake(320.0, 240.0)];
        }
        imageData_ = UIImageJPEGRepresentation(image_, 0.1);
    }
    
    return imageData_;
    
}
//缩略图
- (UIImage *)lt_thumbImage:(CGSize)size
{
    
    UIImage *newimage = nil;
    
    if (self) {
        
        UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
        
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
}

//获取图片
+ (UIImage *)lt_imageName:(NSString *)name{
    
    NSUInteger scale = [UIScreen mainScreen].scale;
    switch (scale) {
        case 1:
        {
            
            UIImage *image = [UIImage imageNamed:name scale:1];
            if (image == nil) {
                image = [UIImage imageNamed:name scale:2];
            }
            if (image == nil) {
                image = [UIImage imageNamed:name scale:3];
            }
            return image;
        }
            break;
        case 2:
        {
            
            UIImage *image = [UIImage imageNamed:name scale:2];
            if (image == nil) {
                image = [UIImage imageNamed:name scale:3];
            }
            if (image == nil) {
                image = [UIImage imageNamed:name scale:1];
            }
            return image;
        }
            break;
        default:
        {
            
            UIImage *image = [UIImage imageNamed:name scale:3];
            if (image == nil) {
                image = [UIImage imageNamed:name scale:2];
            }
            if (image == nil) {
                image = [UIImage imageNamed:name scale:1];
            }
            return image;
        }
            break;
    }
}

+ (UIImage *)imageNamed:(NSString *)name scale:(NSUInteger)scale{
    
    NSString *imageName = name;
    
    switch (scale) {
        case 1:
            imageName = [NSString stringWithFormat:@"%@",name];
            break;
        case 2:
            imageName = [NSString stringWithFormat:@"%@@2x",name];
            break;
        default:
            imageName = [NSString stringWithFormat:@"%@@3x",name];
    }
    
    return ImageWithPath([[NSBundle mainBundle]pathForResource:imageName ofType:@"png"]);
}

+ (UIImage *)lt_imageWithPath:(NSString *)imagePath{
    
    return [UIImage imageWithContentsOfFile:imagePath];
}

- (UIImage *)lt_scaleImageToMaxSize:(CGFloat)size{
    
    UIImage *newimage = nil;
    if (self) {
        
        CGFloat imageH = self.size.height;
        CGFloat imageW = self.size.width;
        
        if (imageH>imageW) {
            
            newimage = [self lt_scaleImageByDefaultHeight:size];
        }
        else{
            
            newimage = [self lt_scaleImageByDefaultWidth:size];
        }
    }
    return newimage;
}
/**
 根据高度 比例缩放
 
 @param height 指定高度
 @return 新图片
 */
- (UIImage *)lt_scaleImageByDefaultHeight:(CGFloat)height{
    
    UIImage *newimage = nil;
    if (self) {
        
        CGFloat imageH = self.size.height;
        
        if (imageH>height) {
            
            CGFloat width = height/self.size.height*self.size.width;
            newimage = [self lt_thumbImage:CGSizeMake(width, height)];
        }
        else{
            
            newimage = self;
        }
    }
    return newimage;
}

- (UIImage *)lt_scaleImageByDefaultWidth:(CGFloat)width{
    
    UIImage *newimage = nil;
    if (self) {
        
        CGFloat imageW = self.size.width;
        
        if (imageW>width) {
            
            CGFloat height = width/imageW*self.size.height;
            newimage = [self lt_thumbImage:CGSizeMake(width, height)];
        }
        else{
            
            newimage = self;
        }
        
    }
    return newimage;
}
#pragma mark add mark
- (UIImage *)lt_imageWithMarkString:(NSString *)markString
                              color:(UIColor *)color
                               font:(UIFont *)font{

    if (![color isKindOfClass:[UIColor class]]) {
        
        color = [UIColor whiteColor];
    }
    
    CGFloat imageH = self.size.height;
    
    CGSize size = [markString sizeWithFont:font constrainedToSize:self.size];

    CGRect rect = CGRectMake(10,
                             imageH - size.height-10,
                             size.width,
                             size.height);
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowBlurRadius = 1.0;
    shadow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    NSDictionary *att = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName:color,
                          NSShadowAttributeName:shadow,
                          NSVerticalGlyphFormAttributeName:@(0)
                          };
    
    UIImage *newPic = [self lt_imageWithMarkString:markString
                                            inRect:rect
                                    withAttributes:att];
    
    return newPic;
}
//test
- (UIImage *)lt_imageWithMarkString:(NSString *)markString
                             inRect:(CGRect)inRect
                              withAttributes:(nullable NSDictionary<NSString *, id> *)attrs{
    
    CGFloat imageW = self.size.width;
    CGFloat imageH = self.size.height;
    
    if (imageH*imageW==0.0) {
        
        return self;
    }
    
    if (![markString isKindOfClass:[NSString class]]) {
        
        NSLog(@"markString 非文本");
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    [markString drawInRect:inRect
            withAttributes:attrs];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

-(UIImage *)addText:(NSString *)text1
{
    //get image width and height
    int w = self.size.width;
    int h = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
    char* text = (char *)[text1 cStringUsingEncoding:NSUTF8StringEncoding];
    CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 0, 0, 1);
    CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

@end
