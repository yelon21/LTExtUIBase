//
//  NumberTextField.m
//  Pods
//
//  Created by yelon on 17/2/10.
//
//

#import "NumberTextField.h"

@interface NumberTextField (){
    
    NSString *contentString;
}

@end

@implementation NumberTextField

- (void)setup {
    
    self.maxLength = 11;
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
    
    [self setup];
}

- (void)textDidChanged:(UITextField *)textField{
    
    NSString *filterString = @"0123456789";
    
    NSString *string = [self numberString:textField.text
                             filterString:filterString];
    if ([string length]<=self.maxLength) {
        
        contentString = string;
    }
    
    textField.text = contentString;
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
