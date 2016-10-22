//
//  Star.m
//  test
//
//  Created by Satbir Tanda on 12/3/15.
//  Copyright © 2015 Satbir Tanda. All rights reserved.
//

#import "StarOfDavid.h"

@implementation StarOfDavid

- (UIColor *)starColor
{
    if (!_starColor) {
        _starColor = [UIColor blueColor];
    }
    return _starColor;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *starPath = [UIBezierPath bezierPath];
    starPath.lineWidth = 15.0;
    [[UIColor clearColor] setFill];
    [self.starColor setStroke];
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat smallOffset = starPath.lineWidth;
    CGFloat offset = 7*height/24.0;
    [starPath moveToPoint:CGPointMake(width/2, 0 + smallOffset)];
    [starPath addLineToPoint:CGPointMake(0 + smallOffset, height - offset)];
    [starPath addLineToPoint:CGPointMake(width - smallOffset, height - offset)];
    [starPath closePath];
    [starPath stroke];
    [starPath fill];
    
    UIBezierPath *secondStarPath = [UIBezierPath bezierPath];
    secondStarPath.lineWidth = 15.0;
    [self.starColor setStroke];

    [secondStarPath moveToPoint:CGPointMake(width/2, height - smallOffset)];
    [secondStarPath addLineToPoint:CGPointMake(0 + smallOffset, 0 + offset)];
    [secondStarPath addLineToPoint:CGPointMake(width - smallOffset, 0 + offset)];
    [secondStarPath closePath];
    [secondStarPath stroke];
    [secondStarPath fill];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
