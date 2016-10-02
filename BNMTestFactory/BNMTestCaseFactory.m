//
//  BNMTestCaseFactory.m
//  BNMModuleBProject
//
//  Created by chenshuijin on 16/9/25.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BNMTestCaseFactory.h"
#import "BNMSingleApiViewController.h"
#import "BNMLoginViewController.h"
#import "BNMModularizationViewController.h"

@implementation BNMTestCaseFactory

- (UIViewController *)testCaseWithType:(BNMTestCaseType)testCaseType
{
    UIViewController *testCase = nil;
    switch (testCaseType) {
        case BNMTestCaseTypeSingleAPI:
            testCase = [[BNMSingleApiViewController alloc] init];
            break;
        case BNMTestCaseTypeLogin:
            testCase = [[BNMLoginViewController alloc] init];
            break;
        case BNMTestCaseTypeModularization:
            testCase = [[BNMModularizationViewController alloc] init];
            break;
    }
    return testCase;
}

@end
