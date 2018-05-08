//
//  LTActionSheet.m
//  Pods
//
//  Created by yelon on 2017/5/31.
//
//

#import "LTActionSheet.h"
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface LTActionSheet ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{

    BOOL sourceFromListArray;
}

@property(nonatomic,strong) NSArray *listArray;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *contentView;

@property(nonatomic,strong) void(^clickBlock)(NSString *buttonTitle,NSUInteger buttonIndex);
@property(nonatomic,strong) void(^cancelBlock)(void);

@end

@implementation LTActionSheet

+ (id)LT_ShowActionSheet:(NSString *)title
                   buttons:(NSArray <NSString *> *)buttons
                clickBlock:(void(^)(NSString *buttonTitle,NSUInteger buttonIndex))clickBlock
               cancelBlock:(void(^)(void))cancelBlock{
    
    LTActionSheet *actionSheet = [LTActionSheet new];
    actionSheet.listArray = buttons;
    actionSheet.clickBlock = clickBlock;
    actionSheet.cancelBlock = cancelBlock;
    actionSheet->sourceFromListArray = YES;
    
    [actionSheet lt_show];
    
    return actionSheet;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup{

    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.35];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.tableView];
    });
}

#pragma mark setter

-(void)setListArray:(NSArray *)listArray{

    dispatch_async(dispatch_get_main_queue(), ^{
       
        _listArray = listArray;
        [self.tableView reloadData];
    });
    
}
#pragma mark getter

-(UIView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0.0,
                                                               CGRectGetHeight(self.bounds),
                                                               CGRectGetWidth(self.bounds),
                                                               88.0)];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _contentView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.35];
    }
    
    return _contentView;
}

-(UITableView *)tableView{

    if (!_tableView) {
        
        CGRect contentFrame = self.contentView.bounds;

        if (KIsiPhoneX) {
            
            contentFrame.size.height -= 34.0;
        }
        
        _tableView = [[UITableView alloc]initWithFrame:contentFrame
                                                 style:UITableViewStyleGrouped];
        
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        _tableView.bounces = NO;
        _tableView.estimatedRowHeight = 0.0;
        _tableView.estimatedSectionFooterHeight = 0.0;
        _tableView.estimatedSectionHeaderHeight = 0.0;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCellF"];
    }
    
    return _tableView;
}

#pragma mark action

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self cancelAction];
}

- (void)cancelAction{

    if (sourceFromListArray) {
        
        if (self.cancelBlock) {
            
            self.cancelBlock();
        }
    }
    else{
    
        if ([self.delegate respondsToSelector:@selector(ltActionSheetDidCancel:)]) {
            
            [self.delegate ltActionSheetDidCancel:self];
        }
    }
    
    [self lt_hide];
}

- (void)lt_reload{

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        [self lt_show];
    });
}

- (void)lt_show{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!sourceFromListArray) {
            
            [self.tableView reloadData];
        }
        
        CGFloat bgH = CGRectGetHeight(self.bounds);
        
        CGSize contentSize = [self.tableView contentSize];
        
        CGFloat deltBootom = KIsiPhoneX ? 34.0 : 0.0;
        
        CGFloat height = contentSize.height + deltBootom;
        
        if (height > bgH) {
            
            height = bgH;
        }
        
        self.contentView.frame = CGRectMake(0.0,
                                            bgH,
                                            contentSize.width,
                                            height);
        if (!self.superview) {
            
            UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
            [window addSubview:self];
        }
        
        [UIView animateWithDuration:0.25
                         animations:^{
                             
                             CGRect frame = self.contentView.frame;
                             frame.origin.y = bgH - height;
                             self.contentView.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             
                             
                         }];
    });
}

- (void)lt_hide{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.15
                         animations:^{
                             
                             CGRect frame = self.contentView.frame;
                             frame.origin.y = CGRectGetHeight(self.bounds);
                             self.contentView.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             
                             [self removeFromSuperview];
                         }];
    });
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 1;
    }
    
    NSUInteger count = 0;
    
    if (sourceFromListArray) {
        
        count = self.listArray.count;
    }
    else{
        
        if ([self.delegate respondsToSelector:@selector(numberOfButtonsInActionSheet:)]) {
            
            count = [self.delegate numberOfButtonsInActionSheet:self];
        }
    }
    
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        
        return 10.0;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

-(void)tableView:(UITableView *)tableView
 willDisplayCell:(nonnull UITableViewCell *)cell
forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    cell.separatorInset = UIEdgeInsetsZero;
    if (@available(iOS 8.0, *)) {
        cell.preservesSuperviewLayoutMargins = NO;
        cell.layoutMargins = UIEdgeInsetsZero;
    } else {
        // Fallback on earlier versions
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellF"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [UIColor blackColor];
        
        cell.textLabel.text = @"取消";
        
        if ([self.delegate respondsToSelector:@selector(ltActionSheet:cancelButtonTextLabel:)]) {
            
            [self.delegate ltActionSheet:self
                   cancelButtonTextLabel:cell.textLabel];
        }
        
        return cell;
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor blackColor];
    
    NSUInteger row = indexPath.row;
    
    if (sourceFromListArray) {
        
        if (row<self.listArray.count) {
            
            cell.textLabel.text = self.listArray[row];
        }
        else{
        
            cell.textLabel.text = @"";
        }
    }
    else{
    
        if ([self.delegate respondsToSelector:@selector(ltActionSheet:buttonTextLabel:atIndex:)]) {
            
            [self.delegate ltActionSheet:self
                         buttonTextLabel:cell.textLabel
                                 atIndex:row];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
        return [self cancelAction];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    NSString *title = cell.textLabel.text;
    NSUInteger row = indexPath.row;
    
    NSLog(@"ell.textLabel.text=%@",title);
    
    if (sourceFromListArray) {
        
        if (self.clickBlock) {
            
            self.clickBlock(title,row);
        }
    }
    else{
    
        if ([self.delegate respondsToSelector:@selector(ltActionSheet:clickAtIndex:buttonTitle:)]) {
            
            [self.delegate ltActionSheet:self
                            clickAtIndex:row
                             buttonTitle:title];
        }
    }
    
    [self lt_hide];
}
@end
