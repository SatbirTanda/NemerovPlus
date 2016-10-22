//
//  YinYang.m
//  test
//
//  Created by Satbir Tanda on 12/12/15.
//  Copyright © 2015 Satbir Tanda. All rights reserved.
//

#import "YinYang.h"

@implementation YinYang

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees)/ 180.0)


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIColor *)yinColor
{
    if (!_yinColor) {
        _yinColor = [UIColor whiteColor];
    }
    return _yinColor;
}

- (UIColor *)yangColor
{
    if (!_yangColor) {
        _yangColor = [UIColor blackColor];
    }
    return _yangColor;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *yinPath = [UIBezierPath bezierPath];
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    CGFloat arcRadius = rect.size.width/2.0 - yinPath.lineWidth;
    CGFloat arcStartAngle = DEGREES_TO_RADIANS(90);
    CGFloat arcEndAngle = DEGREES_TO_RADIANS(270);
    [self.yinColor setFill];
    [yinPath addArcWithCenter:CGPointMake(midX, midY)
                       radius:arcRadius
                   startAngle:arcStartAngle
                     endAngle:arcEndAngle
                    clockwise:YES];
    [yinPath addArcWithCenter:CGPointMake(midX, midY/2.0)
                       radius:arcRadius/2.0
                   startAngle:arcStartAngle
                     endAngle:arcEndAngle
                    clockwise:NO];
    [yinPath addArcWithCenter:CGPointMake(midX, maxY*3.0/4.0)
                       radius:arcRadius/2.0
                   startAngle:-arcStartAngle
                     endAngle:arcStartAngle
                    clockwise:NO];
    [yinPath closePath];
    [yinPath stroke];
    [yinPath fill];
    
    UIBezierPath *yinCirclePath = [UIBezierPath bezierPath];
    [self.yangColor setFill];
    [yinCirclePath addArcWithCenter:CGPointMake(midX, midY/2.0)
                             radius:arcRadius/8.0
                         startAngle:DEGREES_TO_RADIANS(0)
                           endAngle:DEGREES_TO_RADIANS(360)
                          clockwise:YES];
    [yinCirclePath closePath];
    [yinCirclePath fill];
}


@end
