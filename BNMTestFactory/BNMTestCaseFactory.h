//
//  BNMTestCaseFactory.h
//  BNMModuleBProject
//
//  Created by chenshuijin on 16/9/25.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BNMTestCaseType) {
    BNMTestCaseTypeSingleAPI,
    BNMTestCaseTypeLogin,
    BNMTestCaseTypeModularization
};

@interface BNMTestCaseFactory : NSObject

- (UIViewController *)testCaseWithType:(BNMTestCaseType)testCaseType;

@end
