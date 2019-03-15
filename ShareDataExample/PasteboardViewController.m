//
//  ViewController.m
//  ShareDataExample
//
//  Created by le tong on 2019/3/14.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "PasteboardViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface PasteboardViewController ()
@property (nonatomic, strong) UIPasteboard *pasteboard;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIImageView *newImageView;
@end

@implementation PasteboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.originImageView];
    [self.view addSubview:self.newImageView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)removePasteboardAtIndexes:(NSIndexSet *)indexes{
    [self.pasteboard setString:@""];
}
- (void)longPressGestureAction:(UILongPressGestureRecognizer *)gesture{
    UIMenuController *menus = [UIMenuController sharedMenuController];
    UIMenuItem *itemOne = [[UIMenuItem alloc]initWithTitle:@"one" action:@selector(removePasteboardAtIndexes:)];
    menus.menuItems = @[itemOne];
    [menus setTargetRect:self.originImageView.frame inView:self.view];
    [menus setMenuVisible:YES animated:YES];
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    NSArray* methodNameArr = @[@"copy:",@"cut:",@"select:",@"selectAll:",@"paste:"];
    if ([methodNameArr containsObject:NSStringFromSelector(action)]) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

/**
 generalPasteboard : 全局共享

 @return pasteboard
 */
- (UIPasteboard *)pasteboard{
    if (!_pasteboard) {
        _pasteboard = [UIPasteboard generalPasteboard];
    }
    return _pasteboard;
}
- (void)copy:(id)sender{
    [self.pasteboard setImage:self.originImageView.image];
}
- (void)paste:(id)sender{
    self.newImageView.image = self.pasteboard.image;
}
- (void)cut:(id)sender{
}
- (void)select:(id)sender{
}
- (void)selectAll:(id)sender{
}


- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
        _textField.text = @"我要复制";
    }
    return _textField;
}
- (UIImageView *)originImageView{
    if (!_originImageView) {
        _originImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 200, 50, 50)];
        _originImageView.image = [UIImage imageNamed:@"icon_copy"];
        _originImageView.userInteractionEnabled = YES;
        [_originImageView becomeFirstResponder];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureAction:)];
        [_originImageView addGestureRecognizer:longGesture];
    }
    return _originImageView;
}
- (UIImageView *)newImageView{
    if (!_newImageView) {
        _newImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 50, 50)];
        _newImageView.userInteractionEnabled = YES;
        _newImageView.backgroundColor = [UIColor darkGrayColor];
        [_newImageView becomeFirstResponder];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureAction:)];
        [_newImageView addGestureRecognizer:longGesture];
    }
    return _newImageView;
}

@end
