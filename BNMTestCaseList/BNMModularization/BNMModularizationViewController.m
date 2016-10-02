//
//  BNMModularizationViewController.m
//  Pods
//
//  Created by chenshuijin on 16/9/27.
//
//

#import "BNMModularizationViewController.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import "CTMediator+CTMediatorModuleAActions.h"

NSString * const kCellIdentifier = @"kCellIdentifier";

@interface BNMModularizationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation BNMModularizationViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView fill];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_viewControllerForDetail];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
    if (indexPath.row == 1) {
        UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_viewControllerForDetail];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    if (indexPath.row == 2) {
        [[CTMediator sharedInstance] CTMediator_presentImage:[UIImage imageNamed:@"tab_bench"]];
    }
    
    if (indexPath.row == 3) {
        [[CTMediator sharedInstance] CTMediator_presentImage:nil];
    }
    
    if (indexPath.row == 4) {
        [[CTMediator sharedInstance] CTMediator_showAlertWithMessage:@"Hello man" cancelAction:nil confirmAction:^(NSDictionary *info) {
            NSLog(@"%@", info);
        }];
    }
}

#pragma mark - getters and setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[@"present detail view controller", @"push detail view controller", @"present image", @"present image when error", @"show alert"];
    }
    return _dataSource;
}

@end
