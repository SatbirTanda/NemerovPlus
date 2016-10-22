//
//  Sunburst.m
//  test
//
//  Created by Satbir Tanda on 12/12/15.
//  Copyright © 2015 Satbir Tanda. All rights reserved.
//

#import "Sunburst.h"

@implementation Sunburst

#define CENTER @"Center"
#define TOP_LEFT @"Top Left"
#define TOP_RIGHT @"Top Right"
#define BOTTOM_LEFT @"Bottom Left"
#define BOTTOM_RIGHT @"Bottom Right"


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIColor *)burstOneColor
{
    if (!_burstOneColor) {
        _burstOneColor = [UIColor redColor];
    }
    return _burstOneColor;
}

- (UIColor *)burstTwoColor
{
    if (!_burstTwoColor) {
        _burstTwoColor = [UIColor blueColor];
    }
    return _burstTwoColor;
}

- (NSString *)originDirection
{
    if (!_originDirection) {
        _originDirection = CENTER;
    }
    return _originDirection;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat xIncrement = CGRectGetMaxX(rect)/4.0;
    CGFloat yIncrement = CGRectGetMaxY(rect)/4.0;
    
    CGPoint origin;
    if([self.originDirection isEqualToString:TOP_LEFT]) origin = CGPointMake(midX/2.0, midY/2.0);
        else if([self.originDirection isEqualToString:TOP_RIGHT]) origin = CGPointMake(midX*1.50, midY/2.0);
        else if([self.originDirection isEqualToString:BOTTOM_LEFT]) origin = CGPointMake(midX/2.0, midY*1.50);
        else if([self.originDirection isEqualToString:BOTTOM_RIGHT]) origin = CGPointMake(midX*1.50, midY*1.50);
        else origin = CGPointMake(midX, midY);
    
    for(int i = 0; i < 4; i++)
    {
        if(i % 2 == 0) [self.burstOneColor setFill];
        else [self.burstTwoColor setFill];
        UIBezierPath *burstPath = [UIBezierPath bezierPath];
        [burstPath moveToPoint:CGPointMake(i*xIncrement, 0)];
        [burstPath addLineToPoint:origin];
        [burstPath addLineToPoint:CGPointMake((i+1)*xIncrement, 0)];
        [burstPath closePath];
        [burstPath fill];
        [burstPath stroke];
    }
    for(int i = 0; i < 4; i++)
    {
        if(i % 2 == 0) [self.burstOneColor setFill];
        else [self.burstTwoColor setFill];
        UIBezierPath *burstPath = [UIBezierPath bezierPath];
        [burstPath moveToPoint:CGPointMake(maxX, i*yIncrement)];
        [burstPath addLineToPoint:origin];
        [burstPath addLineToPoint:CGPointMake(maxX, (i+1)*yIncrement)];
        [burstPath closePath];
        [burstPath fill];
        [burstPath stroke];
    }
    for(int i = 0; i < 4; i++)
    {
        if(i % 2 == 0) [self.burstTwoColor setFill];
        else [self.burstOneColor setFill];
        UIBezierPath *burstPath = [UIBezierPath bezierPath];
        [burstPath moveToPoint:CGPointMake(i*xIncrement, maxY)];
        [burstPath addLineToPoint:origin];
        [burstPath addLineToPoint:CGPointMake((i+1)*xIncrement, maxY)];
        [burstPath closePath];
        [burstPath fill];
        [burstPath stroke];
    }
    for(int i = 0; i < 4; i++)
    {
        if(i % 2 == 0) [self.burstTwoColor setFill];
        else [self.burstOneColor setFill];
        UIBezierPath *burstPath = [UIBezierPath bezierPath];
        [burstPath moveToPoint:CGPointMake(0, i*yIncrement)];
        [burstPath addLineToPoint:origin];
        [burstPath addLineToPoint:CGPointMake(0, (i+1)*yIncrement)];
        [burstPath closePath];
        [burstPath fill];
        [burstPath stroke];
    }
}


@end
