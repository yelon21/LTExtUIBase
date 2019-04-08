//
//  UIScrollView+LTLongImage.m
//  WY
//
//  Created by yelon on 2017/5/12.
//  Copyright © 2017年 yelon. All rights reserved.
//

#import "UIScrollView+LTLongImage.h"
#import "UIView+LTCommon.h"

NSString *TempImagePathByImageName(NSString *fileName){
    
    NSString *dirPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/imageParts/"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL *isDirectory = nil;
    
    BOOL dirExist = [fileManager fileExistsAtPath:dirPath isDirectory:isDirectory];
    
    if (!isDirectory||!dirExist) {
        
        [fileManager createDirectoryAtPath:dirPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    
    NSString *dbPath = [dirPath stringByAppendingFormat:@"/%@",fileName];
    
    return dbPath;
}

@implementation UIScrollView (LTLongImage)

- (CGFloat)imagePartHeight{
    
    CGFloat imagePartHeight = 1000.0;
    
    imagePartHeight = MIN(imagePartHeight, self.ltHeight);
    
    return imagePartHeight;
}

-(void)lt_screenshotScrollView:(void(^)(UIImage *image))completionBlock{
    
    if (self) {
        
        if (self.ltWidth * self.ltHeight == 0.0) {
            
            if (completionBlock) {
                
                completionBlock(nil);
            }
            return ;
        }
        
        CGPoint contentOffset = self.contentOffset;//记录contentOffset
        CGRect frame = self.frame;
        
        CGFloat imagePartHeight = [self imagePartHeight];
        
        if (imagePartHeight != self.ltHeight) {
            
            CGRect rect = self.frame;
            rect.size.height = imagePartHeight;
            self.frame = rect;
        }
        
        CGSize size = self.bounds.size;
        
        CGSize contentSize = self.contentSize;
        
        if (contentSize.width<size.width) {
            
            contentSize.width = size.width;
        }
        
        if (contentSize.height<size.height) {
            
            contentSize.height= size.height;
        }
        
        CGFloat imageTotalHeight = contentSize.height;
        
        NSUInteger totalImageCountsH = ceilf(imageTotalHeight / imagePartHeight);//H
        
        
        if (totalImageCountsH == 0) {
            
            if (completionBlock) {
                
                completionBlock(nil);
            }
            return ;
        }
        
        __weak typeof(self)weakSelf = self;
        
        [self getImage:0
       imagePartHeight:imagePartHeight
     totalImageCountsH:totalImageCountsH
                 block:^(UIImage *img) {
                     
                     weakSelf.frame = frame;
                     weakSelf.contentOffset = contentOffset;
                     
                     if (completionBlock) {
                         
                         completionBlock(img);
                     }
                 }];
    }
}

- (void)getImage:(NSUInteger)index
 imagePartHeight:(CGFloat)imagePartHeight
totalImageCountsH:(NSUInteger)totalImageCountsH
           block:(void(^)(UIImage *image))completionBlock{
    
    CGFloat offsetX = 0;
    
    CGFloat offsetY = imagePartHeight*index;
    
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    self.contentOffset = offset;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        UIImage *image = [self lt_screenshot];
        
        if (image) {
            
            NSString *fileName = [NSString stringWithFormat:@"%@",@(index)];
            //        [imageParts addObject:fileName];
            NSData *data = UIImageJPEGRepresentation(image, 0.5);
            
            NSString *path = TempImagePathByImageName(fileName);
            [data writeToFile:path atomically:NO];
        }
        
        if (index == totalImageCountsH - 1) {
            
            UIImage *imageResult = [self lt_screenshotCombine:totalImageCountsH];
            
            if (completionBlock) {
                completionBlock(imageResult);
            }
        }
        else{
            
            [self getImage:index+1
           imagePartHeight:imagePartHeight
         totalImageCountsH:totalImageCountsH
                     block:completionBlock];
        }
    });
}
//
- (UIImage *)lt_screenshotCombine:(NSUInteger)totalImageCountsH{
    
    NSUInteger count = totalImageCountsH;
    
    if (count==0) {
        
        return nil;
    }
    
    CGFloat imagePartHeight = [self imagePartHeight];
    
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    CGFloat height = self.contentSize.height;
    CGFloat width = self.contentSize.width;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height),
                                           YES,
                                           scale);
    
    for (NSUInteger index = 0;index<count;index++) {
        
        @autoreleasepool {
            
            NSData *imageData = [[NSData alloc] initWithContentsOfFile:TempImagePathByImageName([@(index) description])];
            
            UIImage *imagePart = [UIImage imageWithData:imageData scale:scale];
            
            CGRect drawRect = CGRectMake(0, imagePartHeight*index, width, imagePart.size.height);
            [imagePart drawInRect:drawRect];
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    return image;
}

@end
