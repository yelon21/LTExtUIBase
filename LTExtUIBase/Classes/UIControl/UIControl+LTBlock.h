//
//  UIControl+LTBlock.h
//  Pods
//
//  Created by yelon on 16/9/18.
//
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(id obj);
typedef BOOL(^ConditionBlock)(id obj,ActionBlock actionBlock);

@interface UIControl (LTBlock)

- (void)lt_handleControlEvent:(UIControlEvents)controlEvent
                  actionBlock:(ActionBlock)actionBlock;

- (void)lt_handleControlEvent:(UIControlEvents)controlEvent
               conditionBlock:(ConditionBlock)conditionBlock
                  actionBlock:(ActionBlock)actionBlock;
@end
