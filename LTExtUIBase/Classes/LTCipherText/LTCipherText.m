//
//  LTCipherText.m
//  YJNew
//
//  Created by yelon on 16/1/12.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTCipherText.h"

@interface LTCipherText ()

@end

@implementation LTCipherText
@synthesize cellCount = _cellCount;

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

- (void)setup{
    
    self.backgroundColor = [UIColor redColor];
    self.boundInsets = UIEdgeInsetsZero;
    
    self.gridBackgroundColor = [UIColor whiteColor];
    self.gridLineColor = [UIColor grayColor];
    self.pointColor = [UIColor darkGrayColor];
    
    _pointsCount = 1;
}

- (void)setCellCount:(NSUInteger)count{

    if (_cellCount==0) {
        
        _cellCount = count;
    }
}

-(NSUInteger)cellCount{

    if (_cellCount == 0) {
        
        return 6;
    }
    return _cellCount;
}

-(void)layoutSubviews{

    [self setNeedsDisplay];
}

-(void)setPointsCount:(NSUInteger)pointsCount{
    
    if (pointsCount>self.cellCount) {
        
        return;
    }
    
    _pointsCount = pointsCount;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    [self drawGridLine];
    [self drawPoints];
}

- (void)drawPoints{
    
    CGFloat viewW = CGRectGetWidth(self.bounds);
    CGFloat viewH = CGRectGetHeight(self.bounds);
    
    CGFloat left = _boundInsets.left;
    CGFloat top = _boundInsets.top;
    
    CGFloat cellW = (viewW - left - _boundInsets.right)/self.cellCount;
    
    CGFloat grideH = viewH - top - _boundInsets.bottom;
    CGFloat cellH = MIN(cellW, grideH);
    
    CGFloat radius = cellH/4;
    
    for (NSInteger i = 0; i < _pointsCount; i++) {
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathAddArc(path, NULL, left+cellW/2.0+cellW*i, top+grideH/2.0, radius, 0.0, M_PI*2, YES);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        CGContextSetLineWidth(context, 1);
        
        [self.pointColor setFill];
        
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathFill);
        CGPathRelease(path);
        
        CGContextRestoreGState(context);
    }
}

- (void)drawGridLine{
    
    CGFloat viewW = CGRectGetWidth(self.bounds);
    CGFloat viewH = CGRectGetHeight(self.bounds);
    
    CGFloat left = _boundInsets.left;
    CGFloat top = _boundInsets.top;
    
    CGFloat cellW = (viewW - left - _boundInsets.right)/self.cellCount;
    CGFloat cellH = viewH - top - _boundInsets.bottom;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRoundedRect(path, NULL, CGRectMake(left, top, cellW*self.cellCount, cellH), 2.5, 2.5);
    
    for (NSInteger i = 1; i < self.cellCount; i++) {
        
        CGPathMoveToPoint(path, NULL, left+i*cellW, top);
        CGPathAddLineToPoint(path, NULL, left+i*cellW, top+cellH);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, 0.5);
    
    [self.gridLineColor setStroke];
    [self.gridBackgroundColor setFill];
    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);
    
    CGContextRestoreGState(context);
}

@end
