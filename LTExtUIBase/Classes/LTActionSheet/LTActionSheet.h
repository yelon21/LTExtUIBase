//
//  LTActionSheet.h
//  Pods
//
//  Created by yelon on 2017/5/31.
//
//

#import <Foundation/Foundation.h>

@protocol LTActionSheetDelegate;

@interface LTActionSheet : UIView

@property(nonatomic,weak) id<LTActionSheetDelegate>delegate;

+ (id)LT_ShowActionSheet:(NSString *)title
                 buttons:(NSArray <NSString *> *)buttons
              clickBlock:(void(^)(NSString *buttonTitle,NSUInteger buttonIndex))clickBlock
             cancelBlock:(void(^)(void))cancelBlock;

- (void)lt_reload;

- (void)lt_show;
- (void)lt_hide;
@end

@protocol LTActionSheetDelegate <NSObject>

@required
- (NSUInteger)numberOfButtonsInActionSheet:(LTActionSheet *)actionSheet;

- (void)ltActionSheet:(LTActionSheet *)actionSheet
      buttonTextLabel:(UILabel *)label
              atIndex:(NSUInteger)index;
@optional

- (void)ltActionSheetDidCancel:(LTActionSheet *)actionSheet;

- (void)ltActionSheet:(LTActionSheet *)actionSheet
         clickAtIndex:(NSUInteger)index
          buttonTitle:(NSString *)buttonTitle;

- (void)ltActionSheet:(LTActionSheet *)actionSheet
      cancelButtonTextLabel:(UILabel *)label;
@end
