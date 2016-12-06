//
//  LTLoadingButton.m
//  Pods
//
//  Created by yelon on 16/12/3.
//
//

#import "LTLoadingButton.h"
#import "UIColor+LTCommon.h"

typedef NS_ENUM(NSUInteger, LTLoadingButtonStatus) {
   
    LTLoadingButtonStatusReady,
    LTLoadingButtonStatusLoading,
    LTLoadingButtonStatusFinishing,
    LTLoadingButtonStatusFinished
};

@interface LTLoadingButton ()<CAAnimationDelegate>{

    LTLoadingButtonStatus loadingStatus;
    
    CGFloat defaultRadius;
    CGRect defaultBounds;
    UIImage *defaultBackImage;
    
    CGFloat prepareLoadingAnimDuration;
    CGFloat finishLoadingAnimDuration;
    CGFloat lineWidth;
}

@property(nonatomic,assign) CGRect circleBounds;
@property(nonatomic,strong) dispatch_group_t prepareGroup;

@property(nonatomic,strong) CALayer *bootomCorverLayer;
@property(nonatomic,strong) CAShapeLayer *animationLayer;
@end


@implementation LTLoadingButton

#pragma make overwrite
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    
    return self;
}

-(void)awakeFromNib{

    [super awakeFromNib];
    
    [self setup];
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    if (loadingStatus == LTLoadingButtonStatusReady) {
        
        defaultBounds = self.bounds;
    }
    
}

#pragma mark getter & setter
-(UIColor *)progressColor{

    if (!_progressColor) {
        
        _progressColor = [UIColor greenColor];
    }
    return _progressColor;
}

-(UIColor *)progressBgColor{

    if (!_progressBgColor) {
        
        _progressBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0.35];
    }
    
    return _progressBgColor;
}

-(CAShapeLayer *)animationLayer{

    if (!_animationLayer) {
        
        _animationLayer = [CAShapeLayer layer];
        _animationLayer.bounds = self.circleBounds;
        _animationLayer.position = self.bootomCorverLayer.position;
        _animationLayer.cornerRadius = self.bootomCorverLayer.cornerRadius;
        _animationLayer.backgroundColor = nil;
        [self.bootomCorverLayer addSublayer:_animationLayer];
    }
    return _animationLayer;
}

-(CALayer *)bootomCorverLayer{

    if (!_bootomCorverLayer) {
        
        _bootomCorverLayer = [CALayer layer];
        [self.layer addSublayer:_bootomCorverLayer];
    }
    return _bootomCorverLayer;
}

-(CGRect)circleBounds{

    CGFloat width = CGRectGetWidth(defaultBounds);
    CGFloat height = CGRectGetHeight(defaultBounds);
    
    CGFloat bound = MIN(width, height);
    
    CGRect newRect = defaultBounds;
    newRect.size.width = bound;
    newRect.size.height = bound;
    
    return newRect;
}
#pragma mark private
- (void)setup{

    defaultBackImage = [self backgroundImageForState:UIControlStateNormal];
    
    prepareLoadingAnimDuration = 0.35;
    finishLoadingAnimDuration = 0.35;
    lineWidth = 5.0;
    
    loadingStatus = LTLoadingButtonStatusReady;
    
    defaultRadius = self.layer.cornerRadius;
    
    self.prepareGroup = dispatch_group_create();
}

- (void)resetLayer{

    self.layer.bounds = defaultBounds;
    self.layer.cornerRadius = defaultRadius;
    
    self.bootomCorverLayer.bounds = defaultBounds;
    self.bootomCorverLayer.cornerRadius = defaultRadius;
    
    self.bootomCorverLayer.position = CGPointMake(CGRectGetMidX(defaultBounds), CGRectGetMidY(defaultBounds));
    self.bootomCorverLayer.backgroundColor = nil;
}
//
- (void)startLoading{

    NSLog(@"startLoading");

    [self startSetting];
    [self prepareForLoadingAnimation];
    
}

- (void)startSetting{

    loadingStatus = LTLoadingButtonStatusLoading;
    
    self.userInteractionEnabled = NO;
    
    self.titleLabel.alpha = 0.0;
    
    [super setBackgroundImage:nil
                     forState:UIControlStateNormal];
    
    [self resetLayer];
    
    if (defaultBackImage) {
        
        self.bootomCorverLayer.backgroundColor = [UIColor colorWithPatternImage:defaultBackImage].CGColor;
    }
    else{
    
        self.bootomCorverLayer.backgroundColor = [[self.backgroundColor lt_inverseColor] colorWithAlphaComponent:0.35].CGColor;
    }
    
}

- (void)prepareForLoadingAnimation{

    NSTimeInterval delay = prepareLoadingAnimDuration;
    
    CGFloat radius = CGRectGetMidX(self.circleBounds);
    
    //layer
    CABasicAnimation *layerBoundsAnimate = [CABasicAnimation animationWithKeyPath:@"bounds"];
    layerBoundsAnimate.toValue = [NSValue valueWithCGRect:self.circleBounds];
    
    CABasicAnimation *layerCornerRadiusAnimate = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    layerCornerRadiusAnimate.toValue = @(radius);
    
    CAAnimationGroup *layerGroup = [CAAnimationGroup animation];
    layerGroup.animations = @[layerBoundsAnimate,layerCornerRadiusAnimate];
    
    layerGroup.duration = delay;
    layerGroup.delegate = self;
    layerGroup.fillMode = kCAFillModeForwards;
    layerGroup.removedOnCompletion = NO;
    
    layerGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.layer addAnimation:layerGroup forKey:nil];
    
    dispatch_group_enter(self.prepareGroup);
    
    CABasicAnimation *boundsAnimate = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimate.toValue = [NSValue valueWithCGRect:self.circleBounds];
    
    CABasicAnimation *cornerRadiusAnimate = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAnimate.toValue = @(radius);
    
    CABasicAnimation *borderBackgroundColorAnimate = [CABasicAnimation animationWithKeyPath:@"position"];
    borderBackgroundColorAnimate.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.circleBounds), CGRectGetMidY(self.circleBounds))];

    CAAnimationGroup *borderGroup = [CAAnimationGroup animation];
    borderGroup.animations = @[boundsAnimate,cornerRadiusAnimate,borderBackgroundColorAnimate];
    
    borderGroup.duration = delay;
    borderGroup.delegate = self;
    borderGroup.fillMode = kCAFillModeForwards;
    borderGroup.removedOnCompletion = NO;
    
    borderGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.bootomCorverLayer addAnimation:borderGroup forKey:nil];
    
    dispatch_group_enter(self.prepareGroup);
    
    dispatch_group_notify(self.prepareGroup
                          , dispatch_get_main_queue()
                          , ^{
                              
                              NSLog(@"prepare动画结束");
                             
                              self.layer.bounds = self.circleBounds;
                              self.layer.cornerRadius = radius;
                              
                              
                              self.bootomCorverLayer.bounds = self.circleBounds;
                              self.bootomCorverLayer.position = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
                              
                              self.bootomCorverLayer.cornerRadius = radius;
                              
                              [self.bootomCorverLayer removeAllAnimations];
                              [self.layer removeAllAnimations];
                              
                              [self startLoadingAnimation];
                          });
}

- (void)startLoadingAnimation{
    
    NSUInteger pointCount = 4;
    
    CGFloat radius = CGRectGetMidX(self.circleBounds);
    CGPoint center = CGPointMake(radius, radius);
    radius = radius - lineWidth/2.0;
    
    
    CGFloat angle = 2*M_PI/pointCount;
    CGFloat deltAngle = M_PI/6;
    
    for (NSInteger i = 0; i < pointCount; i++) {
        
        
        CAShapeLayer *point = [CAShapeLayer layer];
        
        point.bounds    = self.circleBounds;
        point.position  = center;
        point.fillColor = nil;
        point.strokeColor = self.progressColor.CGColor;
        point.lineWidth = lineWidth;
        
        CGFloat startAngle = angle*i;
        CGFloat endAngle = angle*i + deltAngle;
        
        point.path = [UIBezierPath bezierPathWithArcCenter:center
                                                    radius:radius
                                                startAngle:startAngle
                                                  endAngle:endAngle
                                                 clockwise:YES].CGPath;
        
        [self.animationLayer addSublayer:point];
        
        CAShapeLayer *pointSpace = [CAShapeLayer layer];
        
        pointSpace.bounds    = self.circleBounds;
        pointSpace.position  = center;
        pointSpace.fillColor = nil;
        pointSpace.strokeColor = self.progressBgColor.CGColor;
        pointSpace.lineWidth = lineWidth;
        
        pointSpace.path = [UIBezierPath bezierPathWithArcCenter:center
                                                    radius:radius
                                                startAngle:endAngle
                                                  endAngle:startAngle+angle
                                                 clockwise:YES].CGPath;
        
        [self.animationLayer addSublayer:pointSpace];
        
    }
    
    for (CAShapeLayer *point in self.animationLayer.sublayers) {
        
        if (point == self.animationLayer) {
            
            return;
        }
            CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnimation.byValue = @(M_PI*2.0);
            rotationAnimation.duration = 1.0;
            rotationAnimation.repeatCount = INFINITY;
        
        [point addAnimation:rotationAnimation forKey:nil];
    }
    
}
//停止
- (void)stopLoading{
    
    NSLog(@"stopLoading");
    
    [self prepareForStop];
}

- (void)prepareForStop{
    
    [self.animationLayer removeFromSuperlayer];
    self.animationLayer = nil;
    
    loadingStatus = LTLoadingButtonStatusFinishing;
    NSTimeInterval delay = finishLoadingAnimDuration;
    
    //layer
    CABasicAnimation *layerBoundsAnimate = [CABasicAnimation animationWithKeyPath:@"bounds"];
    layerBoundsAnimate.toValue = [NSValue valueWithCGRect:defaultBounds];
    
    CABasicAnimation *layerCornerRadiusAnimate = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    layerCornerRadiusAnimate.toValue = @(defaultRadius);
    
    CAAnimationGroup *layerGroup = [CAAnimationGroup animation];
    layerGroup.animations = @[layerBoundsAnimate,layerCornerRadiusAnimate];
    
    layerGroup.duration = delay;
    layerGroup.delegate = self;
    layerGroup.fillMode = kCAFillModeForwards;
    layerGroup.removedOnCompletion = NO;
    
    layerGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.layer addAnimation:layerGroup forKey:nil];
    
    dispatch_group_enter(self.prepareGroup);
    
    CABasicAnimation *boundsAnimate = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimate.toValue = [NSValue valueWithCGRect:defaultBounds];
    
    CABasicAnimation *cornerRadiusAnimate = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAnimate.toValue = @(defaultRadius);
    
    CABasicAnimation *borderBackgroundColorAnimate = [CABasicAnimation animationWithKeyPath:@"position"];
    borderBackgroundColorAnimate.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(defaultBounds), CGRectGetMidY(defaultBounds))];
    
    CAAnimationGroup *borderGroup = [CAAnimationGroup animation];
    borderGroup.animations = @[boundsAnimate,cornerRadiusAnimate,borderBackgroundColorAnimate];
    
    borderGroup.duration = delay;
    borderGroup.delegate = self;
    borderGroup.fillMode = kCAFillModeForwards;
    borderGroup.removedOnCompletion = NO;
    
    borderGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.bootomCorverLayer addAnimation:borderGroup forKey:nil];
    
    dispatch_group_enter(self.prepareGroup);
    
    dispatch_group_notify(self.prepareGroup
                          , dispatch_get_main_queue()
                          , ^{
                              
                              NSLog(@"prepare动画结束");
                              
                              [self resetLayer];
                              
                              [self.bootomCorverLayer removeAllAnimations];
                              [self.layer removeAllAnimations];
                              
                              [self stopSetting];
                          });
}

- (void)stopSetting{

    self.titleLabel.alpha = 1.0;
    
    [super setBackgroundImage:defaultBackImage
                     forState:UIControlStateNormal];
    
    [self.bootomCorverLayer removeFromSuperlayer];
    self.bootomCorverLayer = nil;
    
    loadingStatus = LTLoadingButtonStatusFinished;
    
    self.userInteractionEnabled = YES;
}

#pragma mark CAAnimationDelegate
/* Called when the animation begins its active duration. */
- (void)animationDidStart:(CAAnimation *)anim{

}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    dispatch_group_leave(self.prepareGroup);
}
@end
