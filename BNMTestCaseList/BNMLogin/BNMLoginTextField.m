//
//  BNMLoginTextField.m
//  BNMModuleBProject
//
//  Created by chenshuijin on 16/9/26.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "BNMLoginTextField.h"

@interface BNMLoginTextField ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BNMLoginTextField

#pragma mark - Initialize

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

#pragma mark - life cycle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Method
- (void)setup {
    if (!self.borderColor) {
        self.borderColor = [UIColor clearColor];
    }
    
    if (!self.editingBorderColor) {
        self.editingBorderColor = [UIColor clearColor];
    }
    
    if (!self.titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 45)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15.f];
        
        self.leftView = self.titleLabel;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.layer.borderWidth = .5f;
    self.borderStyle = UITextBorderStyleNone;
    
    self.layer.borderColor = self.borderColor.CGColor;
    self.titleLabel.text = self.titleString;
}


#pragma mark - Notification
- (void)textFieldTextDidBeginEditing:(NSNotification *)note {
    self.layer.borderColor = self.editingBorderColor.CGColor;
}

- (void)textFieldTextDidEndEditing:(NSNotification *)note {
    self.layer.borderColor = self.borderColor.CGColor;
}

#pragma mark - getter and setter
- (void)setBorderColor:(UIColor *)borderColor {
    if (_borderColor != borderColor) {
        _borderColor = borderColor;
        if (!self.isEditing) {
            self.layer.borderColor = borderColor.CGColor;
        }
    }
}

- (void)setEditingBorderColor:(UIColor *)editingBorderColor {
    if (_editingBorderColor != editingBorderColor) {
        _editingBorderColor = editingBorderColor;
        if (self.isEditing) {
            self.layer.borderColor = editingBorderColor.CGColor;
        }
    }
}

- (void)setTitleString:(NSString *)titleString {
    if (_titleString != titleString) {
        _titleString = titleString;
        self.titleLabel.text = titleString;
        if (titleString) {
            self.leftViewMode = UITextFieldViewModeAlways;
        } else {
            self.leftViewMode = UITextFieldViewModeNever;
        }
    }
}

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x + 50, bounds.origin.y, bounds.size.width - 30, bounds.size.height);
    return inset;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super rightViewRectForBounds:bounds];
    return CGRectOffset(rect, -10, 0);
}

@end
