//
//  UITextField+LTCommon.m
//  YYYJJJ
//
//  Created by yelon on 16/10/12.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "UITextField+LTCommon.h"

@implementation UITextField (LTCommon)

- (void)lt_setLeftSpace{

    [self lt_setLeftSpace:20.0];
}
- (void)lt_setLeftSpace:(CGFloat)width{

    UIView *leftV = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, width, 5.0)];
    self.leftView = leftV;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
