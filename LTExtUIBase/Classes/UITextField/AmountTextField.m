//
//  AmountTextField.m
//  Pods
//
//  Created by yelon on 16/11/26.
//
//

#import "AmountTextField.h"

@interface AmountTextField (){

    NSString *numberString;
}

@end

@implementation AmountTextField

-(id)initWithFrame:(CGRect)frame {
    
    if ( !(self = [super initWithFrame:frame]) )
        return nil;
    
    [self setup];
    return self;
}

-(void)awakeFromNib {
    
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    
    self.maxValue       = 100000.00;
    
    numberString = @"";
    
    self.keyboardType   = UIKeyboardTypeDecimalPad;
    
    [self addTarget:self
             action:@selector(updateDispalyText)
   forControlEvents:UIControlEventEditingDidEnd];
    
    [self addTarget:self
             action:@selector(beginEditingAction)
   forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self
             action:@selector(textDidChanged:)
   forControlEvents:UIControlEventEditingChanged];
}

- (void)beginEditingAction{

    self.text = numberString;
}

- (void)textDidChanged:(UITextField *)textField{
    
    if ([textField.text doubleValue]>self.maxValue) {
        
        if ([numberString doubleValue]>self.maxValue) {
            
            numberString = [NSString stringWithFormat:@"%0.2lf",self.maxValue];
        }
        textField.text = numberString;
        return;
    }
    
    NSString *filterString = @"0123456789.";
    
    numberString = [self numberString:textField.text
                         filterString:filterString];
    
    NSArray *components = [numberString componentsSeparatedByString:@"."];
    
    if ([components count]>=2) {
        
        NSString *components2 = [NSString stringWithFormat:@"%@",components[1]];
        
        NSUInteger length = [components2 length];
        if (length>2) {
            components2 = [components2 substringToIndex:2];
        }
        
        NSArray *stringComponents = @[components[0],components2];
        
        numberString = [stringComponents componentsJoinedByString:@"."];
    }
    
    textField.text = numberString;
}

-(void)setText:(NSString *)text{

    [super setText:text];
    
    if (text == nil || [text length] == 0) {
        
        numberString = @"";
    }
}

- (void)setContentAmount:(NSNumber *)amount{
    
    if (amount.doubleValue>self.maxValue) {
        
        numberString = [NSString stringWithFormat:@"%0.2lf",self.maxValue];
    }
    else{
    
        numberString = [NSString stringWithFormat:@"%0.2lf",[amount doubleValue]];
        
        NSString *filterString = @"0123456789.";
        
        numberString = [self numberString:numberString
                             filterString:filterString];
    }
    
    [self updateDispalyText];
}

- (void)updateDispalyText{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"]];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumber *num = @([numberString doubleValue]);
    
    self.text = [formatter stringFromNumber:num];
}

-(long long)fenValue{
    
    NSNumber *num = @(round([numberString doubleValue]*100.0));
    return [num longLongValue];
}

- (NSString *)numberString:(NSString *)string filterString:(NSString *)filterString{
    
    NSString *text = [string stringByReplacingOccurrencesOfString:@" "
                                                               withString:@""];
    
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:filterString]
                                   invertedSet];
    
    text = [text stringByTrimmingCharactersInSet:setToRemove];
    return text;
}
@end
