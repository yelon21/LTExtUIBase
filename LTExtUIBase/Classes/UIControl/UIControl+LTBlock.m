//
//  UIControl+LTBlock.m
//  Pods
//
//  Created by yelon on 16/9/18.
//
//

#import "UIControl+LTBlock.h"
#import <objc/runtime.h>

typedef void(^CheckedBlock)(UIControlEvents event);

@interface UIControl ()

@end

@implementation UIControl (LTBlock)

- (void)lt_handleControlEvent:(UIControlEvents)controlEvent
                  actionBlock:(ActionBlock)actionBlock{
    
    [self lt_handleControlEvent:controlEvent
                      forTarget:self
                         action:actionBlock];
}

void enumerateControlEvents(UIControlEvents controlEvent,CheckedBlock ckeckedEvent){
    
    if (ckeckedEvent) {
        
        for (NSInteger move = 0; move < 20; move++) {
            
            NSUInteger event = 1<<move;
            NSUInteger resultEvent = event & controlEvent;
            
            if (resultEvent == event) {
                
                ckeckedEvent(resultEvent);
            }
        }
    }
}

- (void)lt_handleControlEvent:(UIControlEvents)controlEvent
                    forTarget:(_Nonnull id)target
                       action:(_Nonnull ActionBlock)action{
    
    if (!action || !target) {
        
        return;
    }
    enumerateControlEvents(controlEvent, ^(UIControlEvents controlEvent) {
        
        NSString *targetAddress = [NSString stringWithFormat:@"%p", self];
        
        NSString *funcName = LTFunctionName(targetAddress, controlEvent);
        
        SEL sel = NSSelectorFromString(funcName);
        
        [self addTarget:target
                 action:sel
       forControlEvents:controlEvent];
        
        IMP blockImp = imp_implementationWithBlock(action);
        
        if (!class_addMethod([target class], sel, blockImp, "v@:@")) {
            
            IMP orgImp = class_getMethodImplementation([target class], sel);
            imp_removeBlock(orgImp);
            class_replaceMethod([target class], sel, blockImp, "v@:@");
        }
    });
}

@end
