//
//  UIColor+OppositeTest.m
//  SebbiToolBelt
//
//  Created by Sebastien Windal on 3/17/14.
//  Copyright (c) 2014 Sebastien Windal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+Opposite.h"

@interface UIColor_OppositeTest : XCTestCase

@end

@implementation UIColor_OppositeTest

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

- (void)testOpposite
{
    XCTAssertEqualObjects([UIColor whiteColor], [[UIColor blackColor] stb_oppositeColor]);
    XCTAssertEqualObjects([UIColor blackColor], [[UIColor whiteColor] stb_oppositeColor]);
    XCTAssertEqualObjects([UIColor colorWithWhite:0.0 alpha:0.5], [[UIColor colorWithWhite:1.0 alpha:0.5] stb_oppositeColor]);
    
    XCTAssertEqualObjects([UIColor redColor], [[UIColor cyanColor] stb_oppositeColor]);
    XCTAssertEqualObjects([UIColor greenColor], [[UIColor magentaColor] stb_oppositeColor]);
    XCTAssertEqualObjects([UIColor blueColor], [[UIColor yellowColor] stb_oppositeColor]);
    
    XCTAssertEqualObjects([UIColor cyanColor], [[UIColor redColor] stb_oppositeColor]);
    XCTAssertEqualObjects([UIColor magentaColor], [[UIColor greenColor] stb_oppositeColor]);
    XCTAssertEqualObjects([UIColor yellowColor], [[UIColor blueColor] stb_oppositeColor]);
    
    XCTAssertEqualObjects([UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                          [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] stb_oppositeColor]);
    XCTAssertEqualObjects([UIColor colorWithRed:0.125 green:0.25 blue:0.375 alpha:1.0],
                          [[UIColor colorWithRed:0.875 green:0.75 blue:0.625 alpha:1.0] stb_oppositeColor]);
}


@end
