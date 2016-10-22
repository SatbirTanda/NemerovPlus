//
//  Star.m
//  test
//
//  Created by Satbir Tanda on 12/4/15.
//  Copyright © 2015 Satbir Tanda. All rights reserved.
//

#import "Star.h"

@implementation Star

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
    
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [self.starColor setFill];
    
    CGFloat starExtrusion = CGRectGetMaxX(rect)/5.0;
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat pointsOnStar = 5;
    CGFloat angle = -M_PI_2;
    CGFloat angleIncrement = (2.0*M_PI / pointsOnStar);
    CGFloat radius = rect.size.width/2.0;
    
    BOOL firstPoint = YES;
    
    for (int i = 1; i <= pointsOnStar; i++)
    {
        CGPoint point = [self pointFrom:angle
                             withRadius:radius
                              andOffset:center];
        
        CGPoint nextPoint = [self pointFrom:angle + angleIncrement
                                 withRadius:radius
                                  andOffset:center];
        
        CGPoint midPoint = [self pointFrom:angle + angleIncrement/2.0
                                withRadius:starExtrusion
                                 andOffset:center];
        
        if (firstPoint)
        {
            firstPoint = NO;
            [starPath moveToPoint:point];
        }
        
        [starPath addLineToPoint:midPoint];
        [starPath addLineToPoint:nextPoint];
        
        angle += angleIncrement;
    }
    
    [starPath closePath];
    [starPath fill];
}

- (CGPoint)pointFrom:(CGFloat)angle withRadius:(CGFloat)radius andOffset:(CGPoint)offset
{
    return CGPointMake(radius *cos(angle) + offset.x, radius * sin(angle) + offset.y);
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



@end
