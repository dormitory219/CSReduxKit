//
//  CSInputView.m
//  CSReduxKit
//
//  Created by dormitory219 on 2018/4/5.
//  Copyright © 2018年 dormitory219. All rights reserved.
//

#import "CSInputView.h"
#import "CSDemoReduxHeader.h"
#import <Masonry/Masonry.h>

@interface CSInputView() <UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;

@end

@implementation CSInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor orangeColor];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
        lable.text = @"内容添加区域";
        
        [self addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            (void)make.top.left.right;
            make.height.mas_equalTo(25);
        }];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.backgroundColor = [UIColor greenColor];
        textField.placeholder = @"请输入内容";
        textField.delegate = self;
        [self addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lable.mas_bottom).mas_offset(10);
            (void)make.left.mas_offset(15);
            (void)make.right.mas_offset(-15);
            make.bottom.mas_offset(-10);
            make.height.mas_equalTo(35);
        }];
        _textField = textField;
    }
    return self;
}

- (void)setStore:(CSDemoStore *)store
{
    _store = store;
    [store subscribe:^(CSDemoAction *action,CSDemoState *state) {
        CSDemoAction *demoAction = (CSDemoAction *)action;
        if (demoAction.type == CSDemoActionbeginAddContentType)
        {
            [self.textField becomeFirstResponder];
        }
        else if (demoAction.type == CSDemoActionAddContentFinishType)
        {
            [self.textField resignFirstResponder];
            self.textField.text = nil;
        }
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CSDemoState *demoState = (CSDemoState *)self.store.state;
    if (demoState.canEdit)
    {
        return YES;
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"error"
                                                                                 message:@"请先点击添加！"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
        }];
        [alertController addAction:okAction];
        [self.viewController presentViewController:alertController animated:YES completion:nil];
        
        NSLog(@"请先点击添加！");
        return NO;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (!textField.text.length)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"error"
                                                                                 message:@"请输入内容！"
 preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
        }];
        [alertController addAction:okAction];
        [self.viewController presentViewController:alertController animated:YES completion:nil];
      
        NSLog(@"请输入内容！");
        return NO;
    }
    CSDemoAction *action = [[CSDemoAction alloc] init];
    action.type = CSDemoActionAddContentFinishType;
    action.data = textField.text;
    [self.store dispatch:action];
    return YES;
}


@end
