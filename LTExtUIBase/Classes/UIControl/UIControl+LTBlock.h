//
//  UIControl+LTBlock.h
//  Pods
//
//  Created by yelon on 16/9/18.
//
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(id  _Nonnull target, UIControl * _Nonnull control, UIEvent * _Nonnull event);
typedef BOOL(^ConditionBlock)(id _Nonnull obj,_Nonnull ActionBlock actionBlock);

@interface UIControl (LTBlock)

- (void)lt_handleControlEvent:(UIControlEvents)controlEvent
                  actionBlock:(ActionBlock _Nonnull)actionBlock API_DEPRECATED_WITH_REPLACEMENT("lt_handleControlEvent:forTarget:action:", ios(0.0.1, 0.1.2));

- (void)lt_handleControlEvent:(UIControlEvents)controlEvent
                    forTarget:(_Nonnull id)target
                       action:(_Nonnull ActionBlock)action;
@end
