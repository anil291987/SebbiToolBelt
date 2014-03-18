//
//  UIImage+AverageColor.m
//  SebbiToolBelt
//
//  Created by Sebastien Windal on 3/15/14.
//  Copyright (c) 2014 Sebastien Windal. All rights reserved.
//

#import "UIImage+AverageColor.h"

@implementation UIImage (AverageColor)


-(UIColor *) stb_fastAverageColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if (rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    } else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}


-(UIColor *)stb_exactAverageColorFromCGImageRef:(CGImageRef)rawImageRef
{
    if (rawImageRef == NULL) {
        return nil;
    }
    CGColorSpaceRef colorspace = CGImageGetColorSpace(rawImageRef);
    int numberComponents = CGColorSpaceGetNumberOfComponents(colorspace);
    
    //This function returns the raw pixel values
    const UInt8 *rawPixelData = CFDataGetBytePtr(CGDataProviderCopyData(CGImageGetDataProvider(rawImageRef)));
    
    NSUInteger imageHeight = CGImageGetHeight(rawImageRef);
    NSUInteger imageWidth = CGImageGetWidth(rawImageRef);
    
    if (numberComponents >= 3) {
        numberComponents = 4; // even on 3 components RGB, the data in rawPixelData is RGBA, 4 bytes per color...
        //Here I sort the R,G,B, values and get the average over the whole image
        int i = 0;
        unsigned int red = 0;
        unsigned int green = 0;
        unsigned int blue = 0;
        
        for (int column = 0; column< imageWidth; column++) {
            int r_temp = 0;
            int g_temp = 0;
            int b_temp = 0;
            
            for (int row = 0; row < imageHeight; row++) {
                i = (row * imageWidth + column) * numberComponents;
                r_temp += (unsigned int)rawPixelData[i];
                g_temp += (unsigned int)rawPixelData[i+1];
                b_temp += (unsigned int)rawPixelData[i+2];
            }
            
            red += r_temp;
            green += g_temp;
            blue += b_temp;
        }
        
        CGFloat averageRed = (1.0f * red)/(imageHeight*imageWidth);
        CGFloat averageGreen = (1.0 * green)/(imageHeight*imageWidth);
        CGFloat averageBlue = (1.0 * blue)/(imageHeight*imageWidth);
        
        return [UIColor colorWithRed:averageRed/255.0f
                               green:averageGreen/255.0f
                                blue:averageBlue/255.0f
                               alpha:1.0f];
    } else {
        // we are in b & w
        numberComponents = 2; // gray + alpha
        int i = 0;
        unsigned int w = 0;
        
        for (int column = 0; column < imageWidth; column++) {
            int w_temp = 0;
            for (int row = 0; row < imageHeight; row++) {
                i = (row * imageWidth + column)*numberComponents;
                w_temp += (unsigned int)rawPixelData[i];
            }
            w += w_temp;
        }
        
        CGFloat averageW = (1.0f * w)/(imageHeight*imageWidth);
        
        return [UIColor colorWithWhite:averageW/255.0f alpha:1.0f];
    }
}


-(UIColor *)stb_exactAverageColor
{
    CGImageRef rawImageRef = [self CGImage];
    
    return [self stb_exactAverageColorFromCGImageRef:rawImageRef];
}


-(UIColor *) stb_averageColor
{
    CGFloat s = MAX(self.size.width,self.size.height);
    
    CGImageRef imageRef;
    
    if (s > 100.0f) {
        CGFloat ratio = s / 100.0f;
        // resample before computation...
        int w = (int)roundf(self.size.width / ratio);
        int h = (int)roundf(self.size.height / ratio);
        if (w < 1) w = 1;
        if (h < 1) h = 1;
        
        CGColorSpaceRef colorSpace = CGImageGetColorSpace(self.CGImage);
        
        int numberComponents = CGColorSpaceGetNumberOfComponents(colorSpace);
        int allocatedNumberComponents = numberComponents;
        if (allocatedNumberComponents == 3) allocatedNumberComponents = 4;
        if (allocatedNumberComponents == 1) allocatedNumberComponents = 4;
        unsigned char rgba[h * w * allocatedNumberComponents];
        
        CGContextRef context;
        if (numberComponents == 4) {
            context = CGBitmapContextCreate(rgba, w, h, 8, numberComponents*w, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        } else if (numberComponents == 3) {
            CGColorSpaceRelease(colorSpace);
            colorSpace = CGColorSpaceCreateDeviceRGB();
            context = CGBitmapContextCreate(rgba, w, h, 8, 4 * w, colorSpace, kCGImageAlphaNoneSkipLast|kCGBitmapByteOrder32Big);
        } else {
            //context = CGBitmapContextCreate(rgba, w, h, 8, 2 * w, colorSpace, kCGBitmapByteOrderDefault);
            CGColorSpaceRelease(colorSpace);
            colorSpace = CGColorSpaceCreateDeviceRGB();
            context = CGBitmapContextCreate(rgba, w, h, 8, 4 * w, colorSpace, kCGImageAlphaNoneSkipLast|kCGBitmapByteOrder32Big);
        }
        
        CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
        imageRef = CGBitmapContextCreateImage(context);
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
    } else {
        imageRef = [self CGImage];
    }
    
    return [self stb_exactAverageColorFromCGImageRef:imageRef];
}

@end
