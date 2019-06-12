//
//  AmountTextField.h
//  Pods
//
//  Created by yelon on 16/11/26.
//
//

#import <UIKit/UIKit.h>
#import "UITextField+LTCommon.h"

@interface AmountTextField : UITextField

@property(nonatomic,assign) double maxValue;//default 100000.00 单位：元
@property(nonatomic,assign,readonly) long long fenValue;//单位：分
@property(nonatomic,assign) BOOL hideCurrency;

@property(nonatomic,strong) void(^didChangeValueBlock)(long long fenValue);//单位：分
@property(nonatomic,strong) void(^didEndEditingBlock)(long long fenValue);//单位：分
//单位：元
- (void)setContentAmount:(NSNumber *)amount;
@end
