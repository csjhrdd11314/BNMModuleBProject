//
//  BNMModuleBViewController.m
//  BNMModuleBProject
//
//  Created by chenshuijin on 16/9/25.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BNMModuleBViewController.h"
#import "UIView+LayoutMethods.h"
#import "BNMTestCaseFactory.h"

NSString * const kBSDataSourceItemKeyTestCaseType = @"kBSDataSourceItemKeyTestCaseType";
NSString * const kBSDataSourceItemKeyTestCaseTitle = @"kBSDataSourceItemKeyTestCaseTitle";

@interface BNMModuleBViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) BNMTestCaseFactory *testCaseFactory;

@end

@implementation BNMModuleBViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"模块B主页";
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView fill];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *testCase = [self.testCaseFactory testCaseWithType:[self.dataSource[indexPath.row][kBSDataSourceItemKeyTestCaseType] unsignedIntegerValue]];
    [self.navigationController pushViewController:testCase animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row][kBSDataSourceItemKeyTestCaseTitle];
    return cell;
}

#pragma mark - getters and setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[
                        @{
                            kBSDataSourceItemKeyTestCaseType:@(BNMTestCaseTypeSingleAPI),
                            kBSDataSourceItemKeyTestCaseTitle:@"测试网络请求"
                            },
                        @{
                            kBSDataSourceItemKeyTestCaseType:@(BNMTestCaseTypeLogin),
                            kBSDataSourceItemKeyTestCaseTitle:@"测试登录"
                            },
                        @{
                            kBSDataSourceItemKeyTestCaseType:@(BNMTestCaseTypeModularization),
                            kBSDataSourceItemKeyTestCaseTitle:@"测试组件间调用"
                            }
                        ];
    }
    return _dataSource;
}

- (BNMTestCaseFactory *)testCaseFactory
{
    if (_testCaseFactory == nil) {
        _testCaseFactory = [[BNMTestCaseFactory alloc] init];
    }
    return _testCaseFactory;
}


@end
