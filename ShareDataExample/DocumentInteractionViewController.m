//
//  DocumentInteractionViewController.m
//  ShareDataExample
//
//  Created by le tong on 2019/3/15.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "DocumentInteractionViewController.h"

@interface DocumentInteractionViewController ()<UIDocumentInteractionControllerDelegate>
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *lookButton;
@property (nonatomic, strong) UIDocumentInteractionController *interactionController;
@end

@implementation DocumentInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shareButton];
    [self.view addSubview:self.lookButton];
    // Do any additional setup after loading the view.
}

/**
 分享
 */
- (void)pressedShareButton{
    [self.interactionController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

/**
 预览
 */
- (void)pressedLookButton{
    [self.interactionController presentPreviewAnimated:YES];
}
- (UIDocumentInteractionController *)interactionController{
    if (!_interactionController) {
        _interactionController = [UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle]URLForResource:@"shareData" withExtension:@"pdf"]];
        _interactionController.delegate = self;
    }
    return _interactionController;
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}
- (UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, self.view.frame.size.width - 100, 50)];
        _shareButton.backgroundColor = [UIColor orangeColor];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(pressedShareButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (UIButton *)lookButton{
    if (!_lookButton) {
        _lookButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, self.view.frame.size.width - 100, 50)];
        _lookButton.backgroundColor = [UIColor greenColor];
        [_lookButton setTitle:@"预览" forState:UIControlStateNormal];
        [_lookButton addTarget:self action:@selector(pressedLookButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookButton;
}
@end
