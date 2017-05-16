//
//  UIScrollView+LTLongImage.h
//  WY
//
//  Created by yelon on 2017/5/12.
//  Copyright © 2017年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LTLongImage)

-(void)lt_screenshotScrollView:(void(^)(UIImage *image))completionBlock;
@end
