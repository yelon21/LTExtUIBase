//
//  LTLengthTextField.h
//  LTExtUIBase
//
//  Created by 龙 on 2020/9/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTLengthTextField : UITextField

@property(nonatomic,assign)IBInspectable NSUInteger maxLength;

- (void)setup;
@end

NS_ASSUME_NONNULL_END
