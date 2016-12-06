//
//  LTSMSButton.h
//  ipos
//
//  Created by yelon on 16/3/15.
//
//

#import <UIKit/UIKit.h>

@interface LTSMSButton : UIButton

@property(nonatomic,assign) CGFloat timeOutSeconds;

- (void)resetTime;
- (void)startCountdown;

@end
