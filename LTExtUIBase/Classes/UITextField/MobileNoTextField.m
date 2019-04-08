//
//  MobileNoTextField.m
//  Pods
//
//  Created by yelon on 16/11/26.
//
//

#import "MobileNoTextField.h"

@implementation MobileNoTextField

-(id)initWithFrame:(CGRect)frame {
    
    if ( !(self = [super initWithFrame:frame]) )
        return nil;
    
    self.maxLength = 11;
    return self;
}

-(void)awakeFromNib {
    
    [super awakeFromNib];
    self.maxLength = 11;
}

@end
