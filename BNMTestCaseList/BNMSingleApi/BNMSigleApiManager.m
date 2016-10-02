//
//  BNMSigleApiManager.m
//  BNMModuleBProject
//
//  Created by chenshuijin on 16/9/25.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BNMSigleApiManager.h"

NSString * const kTestAPIManagerParamsKeyLatitude = @"kTestAPIManagerParamsKeyLatitude";
NSString * const kTestAPIManagerParamsKeyLongitude = @"kTestAPIManagerParamsKeyLongitude";

@interface BNMSigleApiManager () <CTAPIManagerValidator>

@end

@implementation BNMSigleApiManager

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - CTAPIManager
- (NSString *)methodName
{
    return @"geocode/regeo";
}

- (NSString *)serviceType
{
    return kCTServiceGDMapV3;
}

- (CTAPIManagerRequestType)requestType
{
    return CTAPIManagerRequestTypeGet;
}

- (BOOL)shouldCache
{
    return YES;
}

- (NSDictionary *)reformParams:(NSDictionary *)params
{
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"key"] = [[CTServiceFactory sharedInstance] serviceWithIdentifier:kCTServiceGDMapV3].publicKey;
    resultParams[@"location"] = [NSString stringWithFormat:@"%@,%@", params[kTestAPIManagerParamsKeyLongitude], params[kTestAPIManagerParamsKeyLatitude]];
    resultParams[@"output"] = @"json";
    return resultParams;
}

#pragma mark - CTAPIManagerValidator
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    if ([data[@"status"] isEqualToString:@"0"]) {
        return NO;
    }
    
    return YES;
}

@end
