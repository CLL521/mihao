//
//  backGroundView.m
//  login
//
//  Created by chenliliang on 15/11/12.
//  Copyright (c) 2015年 chenliliang. All rights reserved.
//

#import "backGroundView.h"
#import "PureLayout.h"
#define textFont [UIFont systemFontOfSize:14.0]

@interface backGroundView()
/** 手机号文本框 */
@property (nonatomic, weak)UITextField *phoneField;
/** 账号文本框 */
@property (nonatomic, weak)UITextField *accountField;
/** 密码文本框 */
@property (nonatomic, weak)UITextField *pwdField;
/** 获取验证码按钮 */
@property (nonatomic, weak)UIButton *getCodeBtn;
/** 确认按钮 */
@property (nonatomic, weak)UIButton *affirmBtn;
/** 获取验证码内部竖直view */
@property (nonatomic, weak)UIView *leftView;
/** 获取验证码内部右边整体view */
@property (nonatomic, weak)UIView *rightView;
/** 获取验证码底部view */
@property (nonatomic, weak)UIView *codeBackView;
/** 确认按钮左边活动指示器 */
@property (nonatomic, weak)UIActivityIndicatorView *affirmIndicator;
/** 获取验证码内活动指示器 */
@property (nonatomic, weak)UIActivityIndicatorView *codeIndicator;
@end
@implementation backGroundView
/** 统一文本框高度 */
CGFloat const height = 40.0;
/** 活动指示器旁边间距 */
CGFloat const margin = 10.0;
/** 活动指示器旁边间距 */
CGFloat const colorScale = (211)/255.0;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpChildView];

        self.backgroundColor = [UIColor colorWithRed:colorScale green:colorScale blue:colorScale alpha:1];
    }
    return self;
}

#pragma mark - 确认按钮
- (UIButton *)affirmBtn{
    if (!_affirmBtn) {
        _affirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setBtnWithSize:20.0 color:[UIColor whiteColor] backColor:[UIColor redColor] btn:_affirmBtn text:@"确  认"];
        [self addSubview:_affirmBtn];
        [_affirmBtn addTarget:self action:@selector(addirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _affirmBtn;
}
- (void)addirmClick{
    self.affirmBtn.selected = !self.affirmBtn.selected;
    if (self.affirmBtn.selected) {
        self.affirmIndicator.hidden = NO;
        [self.affirmIndicator startAnimating];
    }else{
        self.affirmIndicator.hidden = YES;
        [self.affirmIndicator stopAnimating];
    }
}

#pragma mark - 获取验证码按钮
- (UIButton *)getCodeBtn{
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setBtnWithSize:15.0 color:[UIColor grayColor] backColor:[UIColor whiteColor] btn:_getCodeBtn text:@"获取验证码"];
        [_getCodeBtn addTarget:self action:@selector(getCoderClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint btnp = [self convertPoint:point toView:self.getCodeBtn];
    if ([self.getCodeBtn pointInside:btnp withEvent:event] == YES) {
        return self.getCodeBtn;
    }else {
        return [super hitTest:point withEvent:event];
    }
}
- (void)getCoderClick
{
    if (self.codeIndicator.isAnimating) return;
    [self.codeIndicator startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.codeIndicator stopAnimating];
    });
}

#pragma mark - 设置按钮基本数据
- (void)setBtnWithSize:(CGFloat)size color:(UIColor *)color backColor:(UIColor *)backColor  btn:(UIButton*)btn text:(NSString *)text{
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setBackgroundColor:backColor];
}

#pragma mark - 创建子控件
- (void)setUpChildView{
    
    UITextField *phoneField = [[UITextField alloc] init];
    UITextField *accountField = [[UITextField alloc] init];
    UITextField *pwdField = [[UITextField alloc] init];
    UIView *codeBackView = [[UIView alloc] init];
    UIView *leftView = [[UIView alloc] init];
    UIView *rightView = [[UIView alloc] init];
    UIActivityIndicatorView *affirmIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIActivityIndicatorView *codeIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    phoneField.placeholder = @"  请输入手机号";
    accountField.placeholder = @"  请输入验证码";
    pwdField.placeholder = @"  请输入新密码";
    pwdField.font = textFont;
    accountField.font = textFont;
    phoneField.font = textFont;
    
    rightView.backgroundColor = [UIColor whiteColor];
    phoneField.backgroundColor = [UIColor whiteColor];
    accountField.backgroundColor = [UIColor whiteColor];
    codeBackView.backgroundColor = [UIColor whiteColor];
    pwdField.backgroundColor = [UIColor whiteColor];
    leftView.backgroundColor = [UIColor lightGrayColor];
    
    [rightView addSubview:codeIndicator];
    [rightView addSubview:leftView];
    [rightView addSubview:self.getCodeBtn];
    [codeBackView addSubview:accountField];
    [codeBackView addSubview:rightView];
    [self addSubview:phoneField];
    [self addSubview:codeBackView];
    [self addSubview:pwdField];
    [self.affirmBtn addSubview:affirmIndicator];

    self.phoneField = phoneField;
    self.codeBackView = codeBackView;
    self.accountField = accountField;
    self.pwdField = pwdField;
    self.affirmIndicator = affirmIndicator;
    self.codeIndicator = codeIndicator;
    self.leftView = leftView;
    self.rightView = rightView;
    
}

#pragma mark - 布局子控件
- (void)layoutSubviews{
    [self setConstrainPhoneField];
    
    [self addConstraintFromView:self.codeBackView toView:self.phoneField];
    [self addConstraintFromView:self.pwdField toView:self.codeBackView];
    [self addConstraintFromView:self.affirmBtn toView:self.pwdField];
    
    [self.affirmIndicator autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:margin];
    [self.affirmIndicator autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:margin];
    
    [self setConstrainCodeBackView];
    [super layoutSubviews];
    
}

#pragma mark - 请输入手机号约束
- (void)setConstrainPhoneField{
    [self.phoneField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:3 *height];
    [self.phoneField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:height];
    [self.phoneField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:height];
    [self.phoneField autoSetDimension:ALDimensionHeight toSize:height];
}

#pragma mark - 验证码一行约束
- (void)setConstrainCodeBackView{
    
    [self.accountField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:self.codeBackView.frame.size.width];
    [self.accountField autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.accountField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.accountField autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    [self.codeIndicator autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:2 *margin];
    [self.codeIndicator autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:margin];
    
    [self.leftView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.codeIndicator];
    [self.leftView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.codeIndicator];
    [self.leftView autoSetDimension:ALDimensionWidth toSize:2];
    [self.leftView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.codeIndicator withOffset:margin];

    [self.getCodeBtn autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.codeBackView withOffset:-margin];
    [self.getCodeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.accountField];
    [self.getCodeBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.accountField];
    [self.rightView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.rightView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.rightView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.phoneField];

}

/** 根据第一行设置每行的位置*/
- (void)addConstraintFromView:(UIView *)oneView toView:(UIView *)twoView{
    oneView.frame = twoView.frame;
    [oneView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:twoView];
    [oneView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:twoView];
    [oneView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:twoView withOffset:margin];
    [oneView autoSetDimension:ALDimensionHeight toSize:height];
}
@end
