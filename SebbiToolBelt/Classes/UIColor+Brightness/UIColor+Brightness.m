//
//  UIColor+Brightness.m
//  SebbiToolBelt
//
//  Created by Sebastien Windal on 3/17/14.
//  Copyright (c) 2014 Sebastien Windal. All rights reserved.
//

#import "UIColor+Brightness.h"

@implementation UIColor (Brightness)

#define DARKNESS_SCORE_THRESHOLD 125

-(BOOL) stb_isDark
{
    return ([self darknessScore] <= DARKNESS_SCORE_THRESHOLD);
}

-(BOOL) stb_isBright
{
    return ([self darknessScore] > DARKNESS_SCORE_THRESHOLD);
}


-(CGFloat) darknessScore
{
    int numberComponents = CGColorGetNumberOfComponents(self.CGColor);
    
    if (numberComponents == 4) {
        // RGB/RGBA
        const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
        // see that thread for explanation on the formula:
        // http://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright
        // which follows this algorithm
        CGFloat darknessScore = (((componentColors[0]*255) * 299) +
                                 ((componentColors[1]*255) * 587) +
                                 ((componentColors[2]*255) * 114)) / 1000;
        return darknessScore;
    }
    if (CGColorGetNumberOfComponents(self.CGColor) == 2) {
        // B+W
        CGFloat w,a;
        
        [self getWhite:&w alpha:&a];
        CGFloat darknessScore = (((w*255) * 299) +
                                 ((w*255) * 587) +
                                 ((w*255) * 114)) / 1000;
        return darknessScore;
    }
    return 0.0f;
}

@end
