//
//  AmountTextField.m
//  Pods
//
//  Created by yelon on 16/11/26.
//
//

#import "AmountTextField.h"

@interface AmountTextField ()<UITextFieldDelegate>{

    NSMutableString *numberString;
}

@end

@implementation AmountTextField

- (void)setup {

    _amountType = -1;
    self.amountType     = AmountTypeDefault;
    self.maxValue       = 100000.00;
    
    numberString = [[NSMutableString alloc]init];
    
    self.delegate       = self;
}

-(void)setAmountType:(AmountType)amountType{

    if (amountType == _amountType) {
        
        return;
    }
    
    _amountType = amountType;
    
    if (_amountType == AmountTypeDefault) {
        
        self.keyboardType   = UIKeyboardTypeDecimalPad;
        
        [self addTarget:self
                 action:@selector(updateDispalyText)
       forControlEvents:UIControlEventEditingDidEnd];
        
        [self addTarget:self
                 action:@selector(beginEditingAction)
       forControlEvents:UIControlEventEditingDidBegin];
    }
    else{
        
        self.keyboardType   = UIKeyboardTypeNumberPad;
        
        [self removeTarget:self
                    action:@selector(updateDispalyText)
          forControlEvents:UIControlEventEditingDidEnd];
        [self removeTarget:self
                    action:@selector(beginEditingAction)
          forControlEvents:UIControlEventEditingDidBegin];
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

- (void)beginEditingAction{

    if (_amountType == AmountTypeDefault) {
        
        self.text = numberString;
    }
}

- (void)setContentAmount:(long long)amount{

    numberString = [NSString stringWithFormat:@"%@",[@([@(amount) longLongValue]) stringValue]];
    
    [self updateDispalyText];
}

- (void)updateDispalyText{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"]];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumber *num = nil;
    
    if (self.amountType == AmountTypeATM) {
        
        num = @([numberString doubleValue]/100.0);
    }
    else{
        
        num = @([numberString doubleValue]);
    }
    self.text = [formatter stringFromNumber:num];
}

-(long long)fenValue{
    
    NSNumber *num = @([numberString doubleValue]*100.0);
    return [num longLongValue];
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{

    NSUInteger length = [numberString length];
    
    if ([string length]==0 && length > 0) {
        
        [numberString deleteCharactersInRange:NSMakeRange(length-1, 1)];
        
        self.text = numberString;
        return NO;
    }
    
    BOOL containPoint = [numberString containsString:@"."];
    
    NSString *filterString = @"0123456789.";
    
    if (containPoint || self.amountType == AmountTypeATM) {
       
        filterString = @"0123456789";
    }
    
    string = [self numberString:string
                   filterString:filterString];
    
    if ([string length] == 0) {
        
        return NO;
    }
    
    switch (self.amountType) {
        
        case AmountTypeATM:{
            
            [self checkATMAppendString:string];
            break;
        }
        default:{
            
            [self checkDefaultAppendString:string];
            break;
        }
    }
    
    return NO;
}

- (void)checkDefaultAppendString:(NSString *)appendString{
    
    NSString *resultString = [NSString stringWithFormat:@"%@%@",numberString,appendString];
    
    double currentValue = [resultString doubleValue];
    
    if (currentValue>self.maxValue) {
        
        return;
    }
    
    NSArray *components = [resultString componentsSeparatedByString:@"."];
    
    if ([components count]>=2) {
        
        NSString *component2 = components[1];
        if ([component2 length]>2) {
            
            return;
        }
    }
    
    [numberString appendString:appendString];
    
    self.text = numberString;
}

- (void)checkATMAppendString:(NSString *)appendString{
    
    NSMutableString *tmpString = [numberString copy];
    
    tmpString = [tmpString stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    NSString *resultString = [NSString stringWithFormat:@"%@%@",tmpString,appendString];
    
    double currentValue = [resultString doubleValue]/100.0;
    
    if (currentValue > self.maxValue) {
        
        return;
    }

    [numberString setString:resultString];
    
    [self updateDispalyText];
}

- (NSString *)numberString:(NSString *)string filterString:(NSString *)filterString{
    
    NSString *text = string;
    
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:filterString]
                                   invertedSet];
    
    text = [text stringByTrimmingCharactersInSet:setToRemove];
    return text;
}
@end
