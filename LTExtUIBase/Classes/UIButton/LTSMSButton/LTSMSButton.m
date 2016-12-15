//
//  LTSMSButton.m
//  ipos
//
//  Created by yelon on 16/3/15.
//
//

#import "LTSMSButton.h"

@interface LTSMSButton ()

@property(nonatomic,strong) NSDate *startDate;

@end

@implementation LTSMSButton

-(instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{

    [super awakeFromNib];
    
    [self setup];
}

- (void)setup{

    if (self.timeOutSeconds>0.0) {
        
        return;
    }
    self.timeOutSeconds = 120.0;
    self.defaultMessage = @"获取验证码";
    self.defaultColor = [UIColor blackColor];
    [self resetTime];
}

- (void)resetTime{
    
    NSLog(@"resetTime");
    self.enabled = YES;
    [self setTitle:self.defaultMessage forState:UIControlStateNormal];
    [self setTitleColor:self.defaultColor
               forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor]
               forState:UIControlStateDisabled];
    
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = self.defaultColor.CGColor;
}

- (void)startCountdown{
    
    [self startCountdown:NO];
}

- (void)startCountdown:(BOOL)silently{
    
    self.enabled = NO;
    
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
    if (self.timeOutSeconds==0) {
        
        self.timeOutSeconds = 120.0;
    }
    
    self.startDate = [NSDate date];
    
    [self countDown:silently];
}

- (void)countDown:(BOOL)silently{

    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.startDate];
    
    NSTimeInterval deltInterval = self.timeOutSeconds - interval;
    
    if (deltInterval>0.0) {
        
        if (!silently) {
            
            [UIView animateWithDuration:0.5
                             animations:^{
                                 
                                 [self setTitle:[NSString stringWithFormat:@"%0.0fS",deltInterval]
                                       forState:UIControlStateDisabled];
                             }];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self countDown:silently];
        });
    }
    else{

        [self resetTime];
    }
}
@end
