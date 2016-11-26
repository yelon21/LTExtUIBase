//
//  MobileNoTextField.m
//  Pods
//
//  Created by yelon on 16/11/26.
//
//

#import "MobileNoTextField.h"

@interface MobileNoTextField ()<UITextFieldDelegate>

@end

@implementation MobileNoTextField

- (void)setup {
    
    self.keyboardType   = UIKeyboardTypeNumberPad;
    self.delegate       = self;
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

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    BOOL flag = YES;
    
    NSUInteger length = [string length];
    
    for (NSUInteger index = 0; index < length; index++) {
        
        char ch = [string characterAtIndex:index];
        
        if (ch<'0' || ch>'9') {
            
            flag = NO;
            break;
        }
    }
    
    if (flag == NO) {
        
        return NO;
    }
    
    NSString *resultString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    return [resultString length] <= 11;
}

@end
