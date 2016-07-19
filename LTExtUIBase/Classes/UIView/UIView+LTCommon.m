//
//  UIView+LTCommon.m
//  Pods
//
//  Created by yelon on 15/7/21.
//
//

#import "UIView+LTCommon.h"

@implementation UIView (LTCommon)
@dynamic ltWidth;
@dynamic ltHeight;

-(CGFloat)ltWidth{
    
    return CGRectGetWidth(self.frame);
}

-(CGFloat)ltHeight{
    
    return CGRectGetHeight(self.frame);
}

- (void)lt_setCornerRadius:(CGFloat)radius{
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)lt_setBorder:(CGFloat)borderWidth color:(UIColor *)color{
    
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;
}

- (UIImage *)lt_screenshot{
    
    if (self) {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [[UIScreen mainScreen] scale]);
        if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
        } else {
            [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    return nil;
}
@end
