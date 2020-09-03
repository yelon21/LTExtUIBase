//
//  LTLengthTextField.m
//  LTExtUIBase
//
//  Created by 龙 on 2020/9/3.
//

#import "LTLengthTextField.h"

//IB_DESIGNABLE
@implementation LTLengthTextField

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

- (void)setup{
    
    [self addTarget:self
             action:@selector(lt_textDidChanged:)
   forControlEvents:UIControlEventEditingChanged];
}

-(void)setText:(NSString *)text{
    
    if (self.maxLength==0) {
        [super setText:text];
    }
    else{
        
        if ([text length]>self.maxLength) {
            
            [super setText:[text substringToIndex:self.maxLength]];
        }
        else{
            [super setText:text];
        }
    }
}

- (void)lt_textDidChanged:(UITextField *)textField{
    
    self.text = textField.text;
}

@end
