//
//  IronSourceDemoAppUITests.m
//  IronSourceDemoAppUITests
//
//  Created by root on 2023/8/30.
//  Copyright © 2023 supersonic. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface IronSourceDemoAppUITests : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;
@end

@implementation IronSourceDemoAppUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [self.app terminate];
    self.app = nil;
}

- (void)testRewardedVideo {
    sleep(15);
    XCUIElement *btn = self.app.buttons[@"Show"];
    XCTAssertTrue(btn.exists, @"No Load Rewarded Video AD btn.");
    [btn tap];
    
    for(int i = 0; i<50; i++) {
        XCUIElement *closebtn = self.app.buttons[@"ad_closeBtn"];
        if(closebtn.exists) {
            break;
        }
        sleep(1);
    }
    XCUIElement *closebtn = self.app.buttons[@"ad_closeBtn"];
    XCTAssertTrue(closebtn.exists, @"ad_closeBtn no exists.");
    [closebtn tap];
    sleep(1);
}


- (void)testInterstitial {
    sleep(8);
    XCUIElement *btn = self.app.buttons[@"Load"];
    XCTAssertTrue(btn.exists, @"No Load Interstitial AD btn.");
    [btn tap];
    BOOL isReady = NO;
    for(int i = 0; i < 10; i++) {
        XCUIElement *show = self.app.staticTexts[@"ShowIS"];
        if(show.exists) {
            isReady = YES;
            break;
        }
        sleep(3);
    }
    
    XCUIElement *show = self.app.staticTexts[@"ShowIS"];
    [show tap];
    
    sleep(6);
    
    for(int i = 0; i<30; i++) {
        if(i>10){
            XCUIElement *close = self.app.buttons[@"close_x"];
            if(close.exists) {
               [close tap];
                return;
            }
        }
        sleep(1);
    }
    XCUIElement *closebtn = self.app.buttons[@"ad_closeBtn"];
    XCTAssertTrue(closebtn.exists, @"ad_closeBtn no exists.");
    [closebtn tap];
    sleep(1);
}



@end
