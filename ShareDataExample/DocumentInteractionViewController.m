//
//  DocumentInteractionViewController.m
//  ShareDataExample
//
//  Created by le tong on 2019/3/15.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "DocumentInteractionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface DocumentInteractionViewController ()<UIDocumentInteractionControllerDelegate>
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *lookButton;
@property (nonatomic, strong) UIButton *activityButton;
@property (nonatomic, strong) UIDocumentInteractionController *interactionController;
@property (nonatomic, strong) UIActivityViewController *activityViewController;
@end

@implementation DocumentInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shareButton];
    [self.view addSubview:self.lookButton];
    [self.view addSubview:self.activityButton];
  
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

/**
 分享文字/URL/Image...
 */
- (void)pressedActivityButton{
    NSString *text = @"Text to share";
    NSURL *url = [NSURL URLWithString:@"https://github.com"];
    UIImage *image = [UIImage imageNamed:@"Group"];
    NSArray *items = @[text,url,image];
    self.activityViewController = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    self.activityViewController.excludedActivityTypes = @[UIActivityTypePostToFacebook];
    [self presentViewController:self.activityViewController animated:YES completion:nil];
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

- (UIButton *)activityButton{
    if (!_activityButton) {
        _activityButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, self.view.frame.size.width - 100, 50)];
        _activityButton.backgroundColor = [UIColor blueColor];
        [_activityButton setTitle:@"ActivityType" forState:UIControlStateNormal];
        [_activityButton addTarget:self action:@selector(pressedActivityButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _activityButton;
}
@end
