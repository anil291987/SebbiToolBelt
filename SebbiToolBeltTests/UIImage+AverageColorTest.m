//
//  UIImage+AverageColorTest.m
//  SebbiToolBelt
//
//  Created by Sebastien Windal on 3/15/14.
//  Copyright (c) 2014 Sebastien Windal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIImage+AverageColor.h"

@interface UIImage_AverageColorTest : XCTestCase

@end

@implementation UIImage_AverageColorTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(BOOL) compareColor:(UIColor *)c1 withColor:(UIColor *)c2 withTolerance:(CGFloat)errorRate
{
    CGFloat r1,g1,b1,a1;
    CGFloat r2,g2,b2,a2;
    
    [c1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [c2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    
    if (fabs(r1-r2) > errorRate) {
        return NO;
    }
    if (fabs(g1-g2) > errorRate) {
        return NO;
    }
    if (fabs(b1-b2) > errorRate) {
        return NO;
    }
    if (fabs(a1-a2) > errorRate) {
        return NO;
    }
    return YES;
}

-(void) testAverageColor
{
    NSArray *tests = @[
                        @[ [UIImage imageNamed:@"whiteRGBA.png"], [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] ],
                        @[ [UIImage imageNamed:@"blackRGBA.png"], [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ],
                        @[ [UIImage imageNamed:@"midgrayRGBA.png"], [UIColor colorWithRed:0x80/255.0f green:0x80/255.0f blue:0x80/255.0f alpha:1.0] ],
                        @[ [UIImage imageNamed:@"white.png"], [UIColor whiteColor]],
                        @[ [UIImage imageNamed:@"black.png"], [UIColor blackColor]],
                        @[ [UIImage imageNamed:@"redRGBA.png"], [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] ],
                        @[ [UIImage imageNamed:@"greenRGBA.png"], [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] ],
                        @[ [UIImage imageNamed:@"blueRGBA.png"], [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0] ],
                    ];
    
    for (NSArray *arr in tests) {
        XCTAssertEqualObjects([arr[0] stb_averageColor], arr[1], @"%@", arr[0]);
    }
    
    {   // Note, expectedColor is the average color computed with photoshop.
        // Allow a 1% difference from it...
        UIColor *avgColor = [[UIImage imageNamed:@"BlackBig.png"] stb_averageColor];
        UIColor *expectedColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0];
        XCTAssertTrue([self compareColor:avgColor withColor:expectedColor withTolerance:0.01], @"BlackBig.png");
    }
    
    {   // Note, expectedColor is the average color computed with photoshop.
        // Allow a 1% difference from it...
        UIColor *avgColor = [[UIImage imageNamed:@"duckRGB.jpg"] stb_averageColor];
        UIColor *expectedColor = [UIColor colorWithRed:100/255.0f green:92/255.0f blue:92/255.0f alpha:1.0];
        XCTAssertTrue([self compareColor:avgColor withColor:expectedColor withTolerance:0.01], @"duckRGB.jpg");
    }
    {   // Note, expectedColor is the average color computed with photoshop.
        // Allow a 1% difference from it...
        UIColor *avgColor = [[UIImage imageNamed:@"halfbluehalfredRGBA.png"] stb_averageColor];
        UIColor *expectedColor = [UIColor colorWithRed:127/255.0f green:0.0f blue:127/255.0f alpha:1.0];
        XCTAssertTrue([self compareColor:avgColor withColor:expectedColor withTolerance:0.01], @"halfbluehalfredRGBA.png");
    }
    {   // Note, expectedColor is the average color computed with photoshop.
        // Allow a 1% difference from it...
        UIColor *avgColor = [[UIImage imageNamed:@"horizontalRGB.jpg"] stb_averageColor];
        UIColor *expectedColor = [UIColor colorWithRed:0.393 green:0.125f blue:0.004 alpha:1.0];
        XCTAssertTrue([self compareColor:avgColor withColor:expectedColor withTolerance:0.01], @"horizontalRGB.jpg");
    }
    {   // Note, expectedColor is the average color computed with photoshop.
        // Allow a 1% difference from it...
        UIColor *avgColor = [[UIImage imageNamed:@"verticalRGB.jpg"] stb_averageColor];
        UIColor *expectedColor = [UIColor colorWithRed:0.453f green:0.224f blue:0.0357 alpha:1.0];
        XCTAssertTrue([self compareColor:avgColor withColor:expectedColor withTolerance:0.01], @"verticalRGB.jpg");
    }
    {   // Note, expectedColor is the average color computed with photoshop.
        // Allow a 1% difference from it...
        UIColor *avgColor = [[UIImage imageNamed:@"BlackAndWhiteRGB.jpg"] stb_averageColor];
        UIColor *expectedColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.0f];
        XCTAssertTrue([self compareColor:avgColor withColor:expectedColor withTolerance:0.01], @"BlackAndWhiteRGB.jpg");
    }
    {   // Note, expectedColor is the average color computed with photoshop.
        // Allow a 1% difference from it...
        UIColor *avgColor = [[UIImage imageNamed:@"doisneauKissSmallRGB.jpg"] stb_averageColor];
        UIColor *expectedColor = [UIColor colorWithRed:0.423f green:0.423f blue:0.423f alpha:1.0];
        XCTAssertTrue([self compareColor:avgColor withColor:expectedColor withTolerance:0.01], @"doisneauKissSmallRGB.jpg");
    }
    {   // Note, expectedColor is the average color computed with photoshop.
        // Allow a 1% difference from it...
        UIColor *avgColor = [[UIImage imageNamed:@"BlackAndWhite.png"] stb_averageColor];
        UIColor *expectedColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.0];
        XCTAssertTrue([self compareColor:avgColor withColor:expectedColor withTolerance:0.01], @"BlackAndWhite.png avgColor:%@ expectedColor:%@", avgColor, expectedColor);
    }


    {   // Note, expectedColor is the average color computed with photoshop.
        // Allow a 1% difference from it...
        UIColor *avgColor = [[UIImage imageNamed:@"BlackAndWhiteSmall.png"] stb_averageColor];
        UIColor *expectedColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.0];
        XCTAssertTrue([self compareColor:avgColor withColor:expectedColor withTolerance:0.01], @"BlackAndWhiteSmall.png");
    }
    
}

@end
