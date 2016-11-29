//
//  CardTextField.m
//  Pods
//
//  Created by yelon on 16/11/29.
//
//

#import "CardTextField.h"

@interface CardTextField (){
    
    NSMutableString *contentString;
}

@end

@implementation CardTextField

- (void)setup {
    
    contentString = [[NSMutableString alloc]init];
    
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

- (NSString *)numberString:(NSString *)string{
    
    NSString *text = [string stringByReplacingOccurrencesOfString:@" "
                                                       withString:@""];
    
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"]
                                   invertedSet];
    
    text = [text stringByTrimmingCharactersInSet:setToRemove];
    
    
    
    return text;
}

- (void)textDidChanged:(UITextField *)textField{

    NSString *tmp = [self numberString:textField.text];
    
    BOOL flag = [tmp length]>4;
    
    NSInteger count = ceil([tmp length]/4.0);
    
    NSMutableArray *compnents = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i < count; i++) {
        
        if ([tmp length]>4) {
            
            [compnents addObject:[tmp substringToIndex:4]];
            tmp = [tmp substringFromIndex:4];
        }
        else{
        
            [compnents addObject:tmp];
        }
    }
    
    textField.text = [compnents componentsJoinedByString:@" "];
}

@end
