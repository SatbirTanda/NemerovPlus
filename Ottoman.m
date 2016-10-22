//
//  Ottoman.m
//  test
//
//  Created by Satbir Tanda on 12/4/15.
//  Copyright © 2015 Satbir Tanda. All rights reserved.
//

#import "Ottoman.h"
#import "Star.h"

@implementation Ottoman

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees)/ 180.0)

- (UIColor *)ottomanColor
{
    if (!_crescentColor) {
        _crescentColor = [UIColor greenColor];
    }
    return _crescentColor;
}

- (UIColor *)starColor
{
    if (!_starColor) {
        _starColor = [UIColor greenColor];
    }
    return _starColor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    CGFloat arcRadius = rect.size.width/2.0;
    CGFloat arcStartAngle = DEGREES_TO_RADIANS(0);
    CGFloat arcEndAngle = DEGREES_TO_RADIANS(270);
    UIBezierPath *crescentPath = [UIBezierPath bezierPath];
    [self.ottomanColor setFill];
    
    [crescentPath addArcWithCenter:CGPointMake(midX, midY)
                           radius: arcRadius
                       startAngle: arcStartAngle
                         endAngle: arcEndAngle
                        clockwise:YES];
    [crescentPath addCurveToPoint:CGPointMake(maxX, midY)
                    controlPoint1:CGPointMake(0, midY)
                    controlPoint2:CGPointMake(midX, maxY)];

    
    [crescentPath closePath];
    [crescentPath fill];
    
    CGFloat starSide = rect.size.width/3.0;
    Star *star = [[Star alloc] initWithFrame:CGRectMake(2.0*rect.size.width/3.0, 0, starSide, starSide)];
    star.starColor = [self starColor];
    star.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45));
    [self addSubview:star];

}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
