//
//  UIImage+AverageColor.h
//  SebbiToolBelt
//
//  Created by Sebastien Windal on 3/15/14.
//  Copyright (c) 2014 Sebastien Windal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AverageColor)

-(UIColor *) stb_averageColor;
-(UIColor *)stb_exactAverageColor;

@end
