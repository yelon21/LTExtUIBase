//
//  UIControl+LTBlock.m
//  Pods
//
//  Created by yelon on 16/9/18.
//
//

#import "UIControl+LTBlock.h"
#import <objc/runtime.h>

#define FunctionName(tag) [NSString stringWithFormat:@"%@_newFuction",@(tag)]

#define kCondition(tag) [NSString stringWithFormat:@"%@_condition",@(tag)]
#define kAction(tag) [NSString stringWithFormat:@"%@_action",@(tag)]

typedef void(^CheckedBlock)(UIControlEvents resultEvent);

@interface UIControl ()

@property(nonatomic,strong) NSMutableDictionary *blockDic;

@end

@implementation UIControl (LTBlock)

static char *block_dic_Key = "Block_DIC_Key";

- (void)setBlockDic:(NSMutableDictionary *)blockDic{
    
    objc_setAssociatedObject(self, &block_dic_Key, blockDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableDictionary *)blockDic{
    
    NSMutableDictionary *dic = objc_getAssociatedObject(self, &block_dic_Key);
    
    if (!dic || ![dic isKindOfClass:[NSMutableDictionary class]]) {
        
        if ([dic isKindOfClass:[NSDictionary class]]) {
            
            dic = [NSMutableDictionary dictionaryWithDictionary:dic];
        }
        else{
            
            dic = [NSMutableDictionary dictionary];
        }
    }
    return dic;
}

void enumerateAddedControlEvents(UIControlEvents controlEvent,CheckedBlock checkedBlock){
    
    if (checkedBlock) {
        
        for (NSInteger move = 0; move < 20; move++) {
            
            NSUInteger event = 1<<move;
            NSUInteger resultEvent = event & controlEvent;
            
            if (resultEvent == event) {
                
                checkedBlock(resultEvent);
            }
        }
    }
}

void lt_blockButtonPressed(UIButton *btn,SEL _cmd){
    
    NSString *funcName = NSStringFromSelector(_cmd);
    UIControlEvents controlEvent = [funcName integerValue];
    
    
    enumerateAddedControlEvents(controlEvent, ^(UIControlEvents resultEvent) {
        
        NSMutableDictionary *dic = btn.blockDic;
        
        ConditionBlock conditionBlock = dic[kCondition(resultEvent)];
        
        ActionBlock actionBlock = dic[kAction(resultEvent)];
        
        BOOL condition = YES;
        
        if (conditionBlock) {
            
            condition = conditionBlock(btn,actionBlock);
        }
        
        if (condition && actionBlock) {
            
            actionBlock(btn);
        }
    });
}

- (void)lt_handleControlEvent:(UIControlEvents)controlEvent
                  actionBlock:(ActionBlock)actionBlock{
    
    [self lt_handleControlEvent:controlEvent
                 conditionBlock:nil
                    actionBlock:actionBlock];
}

- (void)lt_handleControlEvent:(UIControlEvents)controlEvent
               conditionBlock:(ConditionBlock)conditionBlock
                  actionBlock:(ActionBlock)actionBlock{
    
    enumerateAddedControlEvents(controlEvent
                                , ^(UIControlEvents resultEvent) {
                                    
                                    NSMutableDictionary *dic = self.blockDic;
                                    
                                    dic[kCondition(resultEvent)] = conditionBlock;
                                    dic[kAction(resultEvent)] = actionBlock;
                                    
                                    self.blockDic = dic;
                                    
                                    NSString *functionName = FunctionName(resultEvent);
                                    NSLog(@"%@",functionName);
                                    
                                    SEL selector = NSSelectorFromString(functionName);
                                    
                                    NSLog(@"selector=%@",NSStringFromSelector(selector));
                                    class_replaceMethod([UIButton class],
                                                        selector,
                                                        (IMP)lt_blockButtonPressed,
                                                        "v@:@");
                                    
                                    [self addTarget:self
                                             action:selector
                                   forControlEvents:controlEvent];
                                });
}

@end
