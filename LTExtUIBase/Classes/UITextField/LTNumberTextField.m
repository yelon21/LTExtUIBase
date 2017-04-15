//
//  NumberTextField.m
//  Pods
//
//  Created by yelon on 17/2/10.
//
//

#import "LTNumberTextField.h"

@interface LTNumberTextField (){
    
    NSString *contentString;
}

@end

@implementation LTNumberTextField

- (void)setup {
    
    if (self.maxLength == 0) {
        
        self.maxLength = 11;
    }
    
    self.keyboardType   = UIKeyboardTypeNumberPad;
    [self addTarget:self
             action:@selector(textDidChanged:)
   forControlEvents:UIControlEventEditingChanged];
}

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

-(void)setText:(NSString *)text{
    
    NSString *filterString = @"0123456789";
    
    NSString *string = [self numberString:text
                             filterString:filterString];
    
    if ([string length]<=self.maxLength) {
        
        contentString = string;
    }
    
    [super setText:contentString];
}

- (void)textDidChanged:(UITextField *)textField{
    
    self.text = textField.text;
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
