//
//  UIImage+BoxBlur.h
//  SebbiToolBelt
//
//  Created by Sebastien Windal on 3/15/14.
//  Copyright (c) 2014 Sebastien Windal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BoxBlur)

-(UIImage *) stb_boxblurImageWithBlur:(CGFloat)blur;
-(UIImage *) stb_boxblurImageWithBlur:(CGFloat)blur withTintColor:(UIColor *)tintColor;

@end
