//
//  Triangle.m
//  test
//
//  Created by Satbir Tanda on 11/29/15.
//  Copyright © 2015 Satbir Tanda. All rights reserved.
//

#import "Triforce.h"

@implementation Triforce

- (UIColor *)triforceColor
{
    if (!_triforceColor) {
        _triforceColor = [UIColor yellowColor];
    }
    return _triforceColor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    trianglePath.lineWidth = 0;
    [self.triforceColor setFill];
    [trianglePath moveToPoint:CGPointMake(rect.size.width/2, rect.size.height)];
    [trianglePath addLineToPoint:CGPointMake(0, 0)];
    [trianglePath addLineToPoint:CGPointMake(rect.size.width, 0)];
    [trianglePath closePath];
    [trianglePath fill];
    [trianglePath stroke];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


@end
