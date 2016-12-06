//
//  LTLoadingButton.h
//  Pods
//
//  Created by yelon on 16/12/3.
//
//

#import <UIKit/UIKit.h>

@interface LTLoadingButton : UIButton

@property(nonatomic,strong) UIColor *progressColor;
@property(nonatomic,strong) UIColor *progressBgColor;

- (void)startLoading;
- (void)stopLoading;

@end
