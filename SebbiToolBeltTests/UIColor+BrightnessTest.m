//
//  UIColor+BrightnessTest.m
//  SebbiToolBelt
//
//  Created by Sebastien Windal on 3/17/14.
//  Copyright (c) 2014 Sebastien Windal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+Brightness.h"

@interface UIColor_BrightnessTest : XCTestCase

@end

@implementation UIColor_BrightnessTest

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

- (void)testExample
{
    XCTAssertTrue([[UIColor clearColor] stb_isDark]);
    
    XCTAssertTrue([[UIColor blackColor] stb_isDark]);
    XCTAssertFalse([[UIColor blackColor] stb_isBright]);
    
    XCTAssertTrue([[UIColor colorWithWhite:0.0 alpha:0.0] stb_isDark]);
    XCTAssertFalse([[UIColor colorWithWhite:0.0 alpha:0.0] stb_isBright]);

    XCTAssertTrue([[UIColor colorWithWhite:1.0 alpha:0.0] stb_isBright]);
    XCTAssertFalse([[UIColor colorWithWhite:1.0 alpha:0.0] stb_isDark]);

    XCTAssertTrue([[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] stb_isDark]);
    XCTAssertFalse([[UIColor  colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] stb_isBright]);
    
    XCTAssertTrue([[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] stb_isBright]);
    XCTAssertFalse([[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] stb_isDark]);
    
    // red and blue are dark, green is bright
    XCTAssertTrue([[UIColor redColor] stb_isDark]);
    XCTAssertFalse([[UIColor redColor] stb_isBright]);
    XCTAssertTrue([[UIColor blueColor] stb_isDark]);
    XCTAssertFalse([[UIColor blueColor] stb_isBright]);
    XCTAssertTrue([[UIColor greenColor] stb_isBright]);
    XCTAssertFalse([[UIColor greenColor] stb_isDark]);
    
    // 20% darked green is dark. darkness score 120
    XCTAssertTrue([[UIColor colorWithRed:0.0 green:0.8 blue:0.0 alpha:1.0] stb_isDark]);

    // mid gray is right above dark (127.5>125)
    XCTAssertTrue([[UIColor colorWithWhite:0.5 alpha:1.0] stb_isBright]);
    XCTAssertTrue([[UIColor colorWithWhite:125/255 alpha:1.0] stb_isDark]);
    
    XCTAssertTrue([[UIColor cyanColor] stb_isBright]);
    XCTAssertTrue([[UIColor yellowColor] stb_isBright]);
    XCTAssertTrue([[UIColor magentaColor] stb_isDark]);
    
    XCTAssertTrue([[UIColor lightGrayColor] stb_isBright]);
    
}

@end
