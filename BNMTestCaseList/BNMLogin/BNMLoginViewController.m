//
//  BNMLoginViewController.m
//  BNMModuleBProject
//
//  Created by chenshuijin on 16/9/25.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BNMLoginViewController.h"
#import "BNMLoginTextField.h"
#import "SVProgressHUD.h"
#import "UIView+Frame.h"
#import "SAPIMainManager.h"
#import "NSBundle+Utils.h"

static const CGFloat KHeaderViewW                       = 170.f;
static const CGFloat KHeaderViewH                       = 140.f;
static const CGFloat KHeaderViewY                       = 80.f;

static const CGFloat KAccoutTextFieldAndHeadViewSpace   = 50.f;
static const CGFloat KAccoutAndVerifyTextFieldW         = 300.f;
static const CGFloat KAccoutAndVerifyTextFieldH         = 46.f;
static const CGFloat kAccoutAndVerifyTextFieldSpace     = 20.f;

static const CGFloat kTextFieldLeftViewW                = 40.f;
static const CGFloat kTextFieldLeftViewH                = 40.f;
static const CGFloat kTextFieldRightViewW               = 80.f;
static const CGFloat kTextFieldRightViewH               = 35.f;

static const CGFloat KLoginButtonAndTextFieldSpace      = 50.f;
static const CGFloat KLoginButtonW                      = 300.f;
static const CGFloat KLoginButtonH                      = 50.f;

static NSString *const LoginPageBundle = @"LoginPage";

#define kScreenSize                         [UIScreen mainScreen].bounds.size

@interface BNMLoginViewController ()

@property (nonatomic, strong)UIImageView *backgroudImageView;
@property (nonatomic, strong)UIImageView *headerView;
@property (nonatomic, strong)BNMLoginTextField *accountTF;
@property (nonatomic, strong)BNMLoginTextField *verifyCodeTF;
@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)NSString *resourcePath;

@end

@implementation BNMLoginViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"百度账号";
    self.view.backgroundColor = [UIColor whiteColor];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self addTapGestureForEndEditing];
    [self addSubView];
}

- (void)addTapGestureForEndEditing
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreenForEndEditing)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)tapScreenForEndEditing
{
    [self.view endEditing:YES];
}

- (void)addSubView
{
    [self.view addSubview:self.backgroudImageView];
    [self.backgroudImageView addSubview:self.headerView];
    [self.backgroudImageView addSubview:self.accountTF];
    [self.backgroudImageView addSubview:self.verifyCodeTF];
    [self.backgroudImageView addSubview:self.loginButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutUI];
}

- (void)layoutUI
{
    self.backgroudImageView.frame = self.view.frame;
    self.headerView.frame =  CGRectMake((kScreenSize.width - KHeaderViewW)/2, KHeaderViewY, KHeaderViewW, KHeaderViewH);
    self.accountTF.frame = CGRectMake(0, 0,KAccoutAndVerifyTextFieldW, KAccoutAndVerifyTextFieldH);
    self.accountTF.origin = CGPointMake((kScreenSize.width - KAccoutAndVerifyTextFieldW)/2, _headerView.bottom + KAccoutTextFieldAndHeadViewSpace);
    self.verifyCodeTF.frame = CGRectMake(0, 0,KAccoutAndVerifyTextFieldW, KAccoutAndVerifyTextFieldH);
    self.verifyCodeTF.origin = CGPointMake((kScreenSize.width - KAccoutAndVerifyTextFieldW)/2, _accountTF.bottom + kAccoutAndVerifyTextFieldSpace);
    self.loginButton.frame = CGRectMake((kScreenSize.width - KLoginButtonW)/2, _verifyCodeTF.bottom + KLoginButtonAndTextFieldSpace, KLoginButtonW, KLoginButtonH);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - event response
- (void)getVerifyCode
{
    [SVProgressHUD showInfoWithStatus:@"正在获取验证码"];
    [[SAPIMainManager sharedManager].loginService getDpassWithMobile:_accountTF.text captcha:@"8564" success:^(NSDictionary *info) {
        [SVProgressHUD dismiss];
    } failure:^(UIImage *captchaImage, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取验证码失败"];
    }];
}

- (void)loginOrRegister
{
    [SVProgressHUD showInfoWithStatus:@"登录中..."];
    [[SAPIMainManager sharedManager].loginService loginWithMobile:_accountTF.text dpass:_verifyCodeTF.text success:^(SAPILoginModel *loginModel) {
        [SVProgressHUD showInfoWithStatus:@"登录成功"];
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"登录失败"];
    }];
}

#pragma mark - getters and setters
- (UIImageView *)backgroudImageView
{
    if (_backgroudImageView == nil) {
        _backgroudImageView = [[UIImageView alloc]init];
        _backgroudImageView.userInteractionEnabled = YES;
    }
    return _backgroudImageView;
}

- (UIImageView *)headerView
{
    if (_headerView == nil) {
        NSString *fullPath = [self.resourcePath stringByAppendingPathComponent:@"ihp_LoginHeaderWithText"];
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
        _headerView = [[UIImageView alloc]initWithImage:image];
    }
    return _headerView;
}

- (BNMLoginTextField *)accountTF
{
    if (_accountTF == nil) {
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTextFieldLeftViewW, kTextFieldLeftViewH)];
        leftView.backgroundColor = [UIColor clearColor];
        _accountTF = [self createTextFieldWithPlaceHolder:@"未注册将自动创建百度帐号"];
        _accountTF.leftView = leftView;
        _accountTF.leftViewMode = UITextFieldViewModeAlways;
        NSString *fullPath = [self.resourcePath stringByAppendingPathComponent:@"ihp_accountIcon"];
        _accountTF.background = [UIImage imageWithContentsOfFile:fullPath];
    }
    return _accountTF;
}

- (BNMLoginTextField *)verifyCodeTF
{
    if (_verifyCodeTF == nil) {
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTextFieldLeftViewW, kTextFieldLeftViewH)];
        leftView.backgroundColor = [UIColor clearColor];
        UIButton *rightViewButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kTextFieldRightViewW, kTextFieldRightViewH)];
        [rightViewButton setTitle:@"点击获取" forState:UIControlStateNormal];
        rightViewButton.backgroundColor = [UIColor redColor];
        rightViewButton.layer.cornerRadius = 16;
        rightViewButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [rightViewButton addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
        _verifyCodeTF = [self createTextFieldWithPlaceHolder:@"请输入验证码"];
        _verifyCodeTF.leftView = leftView;
        _verifyCodeTF.leftViewMode = UITextFieldViewModeAlways;
        _verifyCodeTF.rightView = rightViewButton;
        _verifyCodeTF.rightViewMode = UITextFieldViewModeAlways;
        NSString *fullPath = [self.resourcePath stringByAppendingPathComponent:@"ihp_verityCodeIcon"];
        _verifyCodeTF.background = [UIImage imageWithContentsOfFile:fullPath];
        
    }
    return _verifyCodeTF;
}

- (BNMLoginTextField *)createTextFieldWithPlaceHolder:(NSString *)placeHold
{
    BNMLoginTextField *textField = [[BNMLoginTextField alloc] init];
    textField.font = [UIFont systemFontOfSize:15.f];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.keyboardAppearance = UIKeyboardAppearanceDark;
    textField.textColor = [UIColor blueColor];
    textField.tintColor = [UIColor blueColor];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHold attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    return textField;
}

- (UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录或注册" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        NSString *fullPath = [self.resourcePath stringByAppendingPathComponent:@"ihp_LoginButton"];
        [_loginButton setBackgroundImage:[UIImage imageWithContentsOfFile:fullPath] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginOrRegister) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (NSString *)resourcePath
{
    if (_resourcePath == nil) {
        NSBundle *imageBundle =[NSBundle bundleWithName:LoginPageBundle];
        _resourcePath = [imageBundle resourcePath];
    }
    return _resourcePath;
}

@end
