//
//  Cross.m
//  test
//
//  Created by Satbir Tanda on 12/4/15.
//  Copyright © 2015 Satbir Tanda. All rights reserved.
//

#import "Cross.h"

@implementation Cross

- (UIColor *)crossColor
{
    if (!_crossColor) {
        _crossColor = [UIColor yellowColor];
    }
    return _crossColor;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *crossPath = [UIBezierPath bezierPath];
    crossPath.lineWidth = 0;
    [self.crossColor setFill];

    CGFloat midX = CGRectGetMidX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat quarterY = midY/2.0;
    CGFloat maxY = CGRectGetMaxY(rect);
    CGFloat offset = rect.size.width/10.0;
    [crossPath moveToPoint:CGPointMake(midX - offset, 0)];
    [crossPath addLineToPoint:CGPointMake(midX - offset, quarterY - offset)];
    [crossPath addLineToPoint:CGPointMake(0, quarterY - offset)];
    [crossPath addLineToPoint:CGPointMake(0, quarterY + offset)];
    [crossPath addLineToPoint:CGPointMake(midX - offset, quarterY + offset)];
    [crossPath addLineToPoint:CGPointMake(midX - offset, maxY)];
    [crossPath addLineToPoint:CGPointMake(midX + offset, maxY)];
    [crossPath addLineToPoint:CGPointMake(midX + offset, quarterY + offset)];
    [crossPath addLineToPoint:CGPointMake(maxX, quarterY + offset)];
    [crossPath addLineToPoint:CGPointMake(maxX, quarterY - offset)];
    [crossPath addLineToPoint:CGPointMake(midX + offset, quarterY - offset)];
    [crossPath addLineToPoint:CGPointMake(midX + offset, 0)];
    [crossPath closePath];
    
    [crossPath fill];
    [crossPath stroke];

}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
