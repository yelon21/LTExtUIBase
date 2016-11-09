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

-(void)layoutSubviews{

    [super layoutSubviews];
    
    if (self.timeOutSeconds==0.0) {
        
        self.timeOutSeconds = 120.0;
    }
}

- (void)resetTime{
    
    NSLog(@"resetTime");
    self.enabled = YES;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor]
               forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
}

- (void)startCountdown{
    
    self.enabled = NO;
    
    if (self.timeOutSeconds==0) {
        
        self.timeOutSeconds = 120.0;
    }
    
    self.startDate = [NSDate date];
    
    [self countDown];
}

- (void)countDown{

    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.startDate];
    
    NSTimeInterval deltInterval = self.timeOutSeconds - interval;
    
    if (deltInterval>0.0) {
        
//        NSLog(@"deltInterval == %f",deltInterval);
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             [self setTitle:[NSString stringWithFormat:@"%0.0fS",deltInterval]
                                   forState:UIControlStateDisabled];
                         }];
        
        
        [self performSelector:@selector(countDown) withObject:nil afterDelay:1.0];
    }
    else{

        [self resetTime];
    }
}
@end
