//
//  AmountTextField.m
//  Pods
//
//  Created by yelon on 16/11/26.
//
//

#import "AmountTextField.h"

@interface AmountTextField ()<UITextFieldDelegate>

@end

@implementation AmountTextField

- (void)setup {

    self.amountType     = AmountTypeDefault;
    self.maxValue       = 100000.00;
    
    self.keyboardType   = UIKeyboardTypeDecimalPad;
    self.delegate       = self;
}

-(void)setAmountType:(AmountType)amountType{

    if (amountType == _amountType) {
        
        return;
    }
    
    _amountType = amountType;
    
    if (_amountType == AmountTypeDefault) {
        
        self.keyboardType   = UIKeyboardTypeDecimalPad;
        
        [self removeTarget:self
                    action:@selector(textDidChanged:)
          forControlEvents:UIControlEventEditingChanged];
    }
    else{
        
        self.keyboardType   = UIKeyboardTypeNumberPad;
        
        [self addTarget:self
                 action:@selector(textDidChanged:)
       forControlEvents:UIControlEventEditingChanged];
    }
}

-(id)initWithFrame:(CGRect)frame {
    
    if ( !(self = [super initWithFrame:frame]) )
        return nil;
    
    [self setup];
    return self;
}

-(void)awakeFromNib {
   
    [self setup];
}

- (void)textDidChanged:(UITextField *)textField{

    if (self.amountType == AmountTypeATM) {
        
        NSString *text = textField.text;
        text = [text stringByReplacingOccurrencesOfString:@"." withString:@""];
        text = [NSString stringWithFormat:@"%0.2lf",[text longLongValue]/100.0];
        
        textField.text = text;
    }
}

-(long long)fenValue{

    NSNumber *num = @([self.text doubleValue]*100.0);
    return [num longLongValue];
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{

    switch (self.amountType) {
        
        case AmountTypeATM:{
            
            return [self checkATMSourceString:textField.text
                          appendString:string];
        }
        default:{
            
            return [self checkDefaultSourceString:textField.text
                              appendString:string];
        }
    }
}

- (BOOL)checkDefaultSourceString:(NSString *)sourceString
                    appendString:(NSString *)appendString{
    
    BOOL containPoint = [sourceString containsString:@"."];
    
    BOOL flag = YES;
    
    NSUInteger length = [appendString length];
    
    for (NSUInteger index = 0; index < length; index++) {
        
        char ch = [appendString characterAtIndex:index];
        
        if (ch == '.'){
            
            if (containPoint) {
                
                flag = NO;
                break;
            }
            else{
                
                containPoint = YES;
            }
        }
        else if (ch<'0' || ch>'9') {
            
            flag = NO;
            break;
        }
    }
    
    if (flag == NO) {
        
        return NO;
    }
    
    NSString *resultString = [NSString stringWithFormat:@"%@%@",sourceString,appendString];
    double currentValue = [resultString doubleValue];
    
    if (currentValue>self.maxValue) {
        
        return NO;
    }
    
    NSArray *components = [resultString componentsSeparatedByString:@"."];
    
    if ([components count]<2) {
        
        return YES;
    }
    
    NSString *component2 = components[1];
    if ([component2 length]>2) {
        
        return NO;
    }
    
    return YES;
}

- (BOOL)checkATMSourceString:(NSString *)sourceString
                appendString:(NSString *)appendString{
    
    BOOL flag = YES;
    
    NSUInteger length = [appendString length];
    
    for (NSUInteger index = 0; index < length; index++) {
        
        char ch = [appendString characterAtIndex:index];
        
        if (ch<'0' || ch>'9') {
            
            flag = NO;
            break;
        }
    }
    
    if (flag == NO) {
        
        return NO;
    }
    
    sourceString = [sourceString stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *resultString = [NSString stringWithFormat:@"%@%@",sourceString,appendString];
    double currentValue = [resultString doubleValue]/100.0;
    
    if (currentValue > self.maxValue) {
        
        return NO;
    }
    return YES;
}

@end
