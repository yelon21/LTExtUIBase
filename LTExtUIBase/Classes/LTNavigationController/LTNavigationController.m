//
//  LTNavigationController.m
//  FBSnapshotTestCase
//
//  Created by yelon on 2018/4/27.
//

#import "LTNavigationController.h"

#pragma mark LTWrapNavigationController-内建NavigationController

@interface LTWrapNavigationController : UINavigationController

@end

@implementation LTWrapNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    
    if (self = [super initWithNavigationBarClass:nil
                                    toolbarClass:nil]) {
        if (rootViewController) {
            
            self.viewControllers = @[rootViewController];
        }
    }
    return self;
}

-(void)pushViewController:(UIViewController *)viewController
                 animated:(BOOL)animated{
    
    LTNavigationController *navCon = self.lt_NavigationController;
    
    if ([navCon isKindOfClass:[LTNavigationController class]]) {
        
        [navCon pushViewController:viewController animated:animated];
    }
    else{
        
        [super pushViewController:viewController animated:animated];
    }
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    LTNavigationController *navCon = self.lt_NavigationController;
    
    if ([navCon isKindOfClass:[LTNavigationController class]]) {
        
        return [navCon popViewControllerAnimated:animated];
    }
    else{
        
        return [super popViewControllerAnimated:animated];
    }
}

-(NSArray<UIViewController *> *)viewControllers{
    
    LTNavigationController *navCon = self.lt_NavigationController;
    
    if ([navCon isKindOfClass:[LTNavigationController class]]) {
        
        return [navCon viewControllers];
    }
    else{
        
        return [super viewControllers];
    }
}

-(BOOL)hidesBottomBarWhenPushed{
    
    return self.topViewController.hidesBottomBarWhenPushed;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)shouldAutorotate {
    
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end

#pragma mark LTWrapViewController-内建LTWrapViewController

@interface LTWrapViewController : UIViewController

@property (nonatomic,strong) UIViewController *contentViewController;
@property (nonatomic,strong) LTWrapNavigationController *wrapNavigationController;

@end

@implementation LTWrapViewController

+ (id)LT_WrapViewController:(UIViewController *)contentViewController{
    
    if (!contentViewController) {
        
        return nil;
    }
    
    LTWrapViewController *wrapViewController = [[LTWrapViewController alloc]init];
    
    if ([contentViewController isKindOfClass:[LTWrapNavigationController class]]) {
        
        wrapViewController.wrapNavigationController = (LTWrapNavigationController *)contentViewController;
        wrapViewController.contentViewController = wrapViewController.wrapNavigationController.topViewController;
    }
    else if([contentViewController isKindOfClass:[UIViewController class]]){
        
        wrapViewController.contentViewController = contentViewController;
        
        LTWrapNavigationController *wrapNavigationController = [[LTWrapNavigationController alloc]initWithRootViewController:contentViewController];
        wrapViewController.wrapNavigationController = wrapNavigationController;
    }
    
    [wrapViewController addChildViewController:wrapViewController.wrapNavigationController];
    [wrapViewController.wrapNavigationController didMoveToParentViewController:wrapViewController];
    
    return wrapViewController;
}

+ (NSArray *)LT_WrapViewControllers:(NSArray *)contentViewControllers{
    
    NSMutableArray *wrapViewControllers = [[NSMutableArray alloc]initWithCapacity:contentViewControllers.count];
    
    [contentViewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [wrapViewControllers addObject:[LTWrapViewController LT_WrapViewController:obj]];
    }];
    
    return [NSArray arrayWithArray:wrapViewControllers];
}

+ (UIViewController *)LT_ContentViewController:(UIViewController *)wrapViewController{
    
    if ([wrapViewController isKindOfClass:[LTWrapViewController class]]) {
        
        return [(LTWrapViewController *)wrapViewController contentViewController];
    }
    
    return wrapViewController;
}

+ (NSArray *)LT_ContentViewControllers:(NSArray *)wrapViewControllers{
    
    if (!wrapViewControllers) {
        
        return nil;
    }

    NSMutableArray *viewControllers = [[NSMutableArray alloc]initWithCapacity:wrapViewControllers.count];
    
    [wrapViewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [viewControllers addObject:[LTWrapViewController LT_ContentViewController:obj]];
    }];
    
    return [NSArray arrayWithArray:viewControllers];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.wrapNavigationController) {
        
        self.wrapNavigationController.view.frame = self.view.bounds;
        self.wrapNavigationController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.wrapNavigationController.view];
    }
    else {
        
        self.contentViewController.view.frame = self.view.bounds;
        self.contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.contentViewController.view];
    }
}

-(UITabBarController *)tabBarController{
    
    if (self.wrapNavigationController) {
        
        return self.wrapNavigationController.tabBarController;
    }
    return self.contentViewController.tabBarController;
}

-(UITabBarItem *)tabBarItem{
    
    if (self.wrapNavigationController) {
        
        return self.wrapNavigationController.tabBarItem;
    }
    return self.contentViewController.tabBarItem;
}

-(BOOL)hidesBottomBarWhenPushed{
    
//    if (self.wrapNavigationController) {
//        
//        return self.wrapNavigationController.hidesBottomBarWhenPushed;
//    }
    return self.contentViewController.hidesBottomBarWhenPushed;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    if (self.wrapNavigationController) {
        
        return self.wrapNavigationController.preferredStatusBarStyle;
    }
    return self.contentViewController.preferredStatusBarStyle;
}

- (BOOL)shouldAutorotate {
    
    if (self.wrapNavigationController) {
        
        return self.wrapNavigationController.shouldAutorotate;
    }
    return self.contentViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    if (self.wrapNavigationController) {
        
        return self.wrapNavigationController.supportedInterfaceOrientations;
    }
    return self.contentViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    if (self.wrapNavigationController) {
        
        return self.wrapNavigationController.preferredInterfaceOrientationForPresentation;
    }
    return self.contentViewController.preferredInterfaceOrientationForPresentation;
}

@end

#pragma mark LTNavigationController

@interface LTNavigationController ()<UINavigationControllerDelegate>

@property(nonatomic,weak) id <UINavigationControllerDelegate>ltDelegate;

@end

@implementation LTNavigationController

+ (LTNavigationController *)LT_NavigationController:(UIViewController *)rootViewController{
    
    LTNavigationController *controller = [[LTNavigationController alloc] initWithRootViewController:rootViewController];
    
    return controller;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [super setDelegate:self];
    
    self.navigationBar.hidden = YES;
}

-(void)setDelegate:(id<UINavigationControllerDelegate>)delegate{
    
    self.ltDelegate = delegate;
}

-(instancetype)init{
    
    if (self = [super init]) {
        
    }
    return self;
}

-(instancetype)initWithNavigationBarClass:(Class)navigationBarClass
                             toolbarClass:(Class)toolbarClass{

    if (self = [super initWithNavigationBarClass:navigationBarClass
                                    toolbarClass:toolbarClass]) {

    }
    return self;
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    
    if (self = [super initWithNavigationBarClass:nil
                                    toolbarClass:nil]) {
        if (rootViewController) {
            
            self.viewControllers = @[rootViewController];
//            [self pushViewController:rootViewController animated:NO];
        }
    }
    return self;
}

-(UIViewController *)lt_topContentViewController{
    
    return [LTWrapViewController LT_ContentViewController:self.topViewController];
}

-(void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
    
    [super setViewControllers:[LTWrapViewController LT_WrapViewControllers:viewControllers] animated:animated];
}

-(NSArray<UIViewController *> *)viewControllers{
    
    NSArray *viewControllers = [super viewControllers];
    
    return [LTWrapViewController LT_ContentViewControllers:viewControllers];
}

-(void)pushViewController:(UIViewController *)viewController
                 animated:(BOOL)animated{
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        [super pushViewController:viewController animated:animated];
    }
    else{
        
        LTWrapViewController *wrapViewController = [LTWrapViewController LT_WrapViewController:viewController];
        
        if (wrapViewController) {
            
            [super pushViewController:wrapViewController
                             animated:animated];
        }
    }
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    UIViewController *viewCon = [super popViewControllerAnimated:animated];
    
    return [LTWrapViewController LT_ContentViewController:viewCon];
}

-(NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    __block UIViewController *toViewController = viewController;
    
    [[super viewControllers] enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *currentVC = [LTWrapViewController LT_ContentViewController:obj];
        
        if (currentVC == viewController) {
            
            toViewController = obj;
            *stop = YES;
        }
    }];
    
    NSArray *popViewControllers = [super popToViewController:toViewController animated:animated];
    
    return [LTWrapViewController LT_ContentViewControllers:popViewControllers];
}

-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    
    NSArray *viewCons = [super popToRootViewControllerAnimated:animated];
    
    return [LTWrapViewController LT_ContentViewControllers:viewCons];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)shouldAutorotate {
    
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    
    UIViewController *contentVC = viewController;
    
    do {
        
        BOOL isRootVC = navigationController.viewControllers.firstObject == viewController;
        
        if (isRootVC) {
            
            break;
        }
        
        contentVC = [LTWrapViewController LT_ContentViewController:viewController];
        
        if (viewController == contentVC) {
            
            break;
        }
        
        
        if (contentVC.navigationItem.leftBarButtonItem != nil) {
            
            break;
        }

        contentVC.navigationItem.leftBarButtonItem = [contentVC lt_backItem];
        
    } while (NO);
    
    if ([self.ltDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        
        [self.ltDelegate navigationController:navigationController
                       willShowViewController:contentVC
                                     animated:animated];
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self.ltDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        
        [self.ltDelegate navigationController:navigationController
                       didShowViewController:viewController
                                     animated:animated];
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED{
    
    if ([self.ltDelegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)]) {
        
        return [self.ltDelegate navigationControllerSupportedInterfaceOrientations:navigationController];
    }
    
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED{
    
    if ([self.ltDelegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)]) {
        
        return [self.ltDelegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    }
    
    return UIInterfaceOrientationPortrait;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0){
    
    if ([self.ltDelegate respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)]) {
        
        return [self.ltDelegate navigationController:navigationController interactionControllerForAnimationController:animationController];
    }
    
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    
    if ([self.ltDelegate respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)]) {
        
        return [self.ltDelegate navigationController:navigationController
                     animationControllerForOperation:operation
                                  fromViewController:fromVC
                                    toViewController:toVC];
    }
    
    return nil;
}

@end

#pragma mark UIViewController(ltnavigationController)

@implementation UIViewController(ltnavigationController)

- (LTNavigationController *)lt_NavigationController{
    
    LTNavigationController *navCon = (LTNavigationController *)self;
    while (navCon && ![navCon isKindOfClass:[LTNavigationController class]] ) {
        
        navCon = (LTNavigationController *)navCon.parentViewController;
    }
    return navCon;
}

- (UIBarButtonItem *)lt_backItem{
    
    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"]
                                           style:UIBarButtonItemStylePlain
                                          target:self
                                          action:@selector(lt_backAction:)];
}

- (void)lt_backAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
