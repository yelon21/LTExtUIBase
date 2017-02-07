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

@property(nonatomic,assign) double maxValue;//default 100000.00
@property(nonatomic,assign,readonly) long long fenValue;

- (void)setContentAmount:(NSNumber *)amount;
@end
