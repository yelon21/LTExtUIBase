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
@property(nonatomic,strong) NSString *defaultMessage;
@property(nonatomic,strong) UIColor *defaultColor;

- (void)resetTime;
- (void)startCountdown;
- (void)startCountdown:(BOOL)silently;
@end
