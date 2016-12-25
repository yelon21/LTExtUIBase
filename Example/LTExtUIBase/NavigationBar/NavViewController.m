//
//  NavViewController.m
//  LTExtUIBase
//
//  Created by yelon on 16/12/25.
//  Copyright © 2016年 yelon21. All rights reserved.
//

#import "NavViewController.h"
#import "UINavigationBar+LTUtil.h"
#import "UIViewController+LTUtil.h"

@interface NavViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"12121";
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar lt_setBackgroundImageByColor:[UIColor blackColor]];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar lt_setNavigationBarBackgroundAlpha:8.0];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem LT_itemImage:[UIImage imageNamed:@"nav_back"]
                                                                highlight:nil
                                                                   target:self
                                                                      sel:@selector(lt_closeSelfAction)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text= NSStringFromCGPoint(CGPointMake(indexPath.section, indexPath.row));
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    NSArray *views = [self.navigationController.navigationBar subviews];
    //NSLog(@"views=%@",views);
    
    NSInteger row = indexPath.row;
    
    if (row%2==0) {
        
        [self.navigationController.navigationBar lt_setNavigationBarBackgroundAlpha:(18-indexPath.row)/20.0];
        [self.navigationController.navigationBar lt_setNavigationBarItemAlpha:1.0];
    }
    else{
    
        [self.navigationController.navigationBar lt_setNavigationBarBackgroundAlpha:1.0];
        [self.navigationController.navigationBar lt_setNavigationBarItemAlpha:(19-indexPath.row)/20.0];
    }
    
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    CGFloat y = scrollView.contentOffset.y;
//    
//    
//}

@end
