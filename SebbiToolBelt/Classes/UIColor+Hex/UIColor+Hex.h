//
//  UIColor+Hex.h
//  SebbiToolBelt
//
//  Created by Sebastien Windal on 3/17/14.
//  Copyright (c) 2014 Sebastien Windal. All rights reserved.
//
//  Copied and slightly adapted from original code by Andrew Sliwinski on 9/15/12.
//  part of EDColor.

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)stb_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

+ (UIColor *)stb_colorWithHex:(UInt32)hex;
+ (UIColor *)stb_colorWithHexString:(id)input;

- (UInt32)stb_hexValue;

@end
