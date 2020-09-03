//
//  NumberTextField.m
//  Pods
//
//  Created by yelon on 17/2/10.
//
//

#import "LTNumberTextField.h"

@implementation LTNumberTextField

-(void)setText:(NSString *)text{
    
    NSString *filterString = @"0123456789";
    
    NSString *string = [self numberString:text
                             filterString:filterString];
    
    [super setText:string];
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
