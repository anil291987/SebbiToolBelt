//
//  UIColor+Opposite.m
//  SebbiToolBelt
//
//  Created by Sebastien Windal on 3/17/14.
//  Copyright (c) 2014 Sebastien Windal. All rights reserved.
//

#import "UIColor+Opposite.h"

@implementation UIColor (Opposite)

-(UIColor *) stb_oppositeColor
{
    int numberComponents = CGColorGetNumberOfComponents(self.CGColor);
    UIColor * opposite;
    
    if (numberComponents == 4) {
        // RGB/RGBA
        CGFloat r,g,b,a;
        [self getRed:&r green:&g blue:&b alpha:&a];
        opposite = [UIColor colorWithRed:(1-r) green:(1-g) blue:(1-b) alpha:a];
    } else if (numberComponents == 2) {
        // B+W
        CGFloat w,a;
        [self getWhite:&w alpha:&a];
        opposite = [UIColor colorWithWhite:1-w alpha:a];
    }
    
    
    return opposite;
}


@end
