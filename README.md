### ShareDataExample

#### 黏贴版
复制黏贴模式实现数据分享
<pre>
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
</pre>

#### URLType

路由模式跳转实现数据分享

![FirstMethod](https://raw.githubusercontent.com/princeSmall/ShareDataExample/master/URLType.png)

![SecondMethod](https://raw.githubusercontent.com/princeSmall/ShareDataExample/master/URLTypeF.png)


#### UIDocumentInteractionController

发布者
<pre>
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
</pre>

消费者：
![设置](https://raw.githubusercontent.com/princeSmall/ShareDataExample/master/documentType.png)
![显示](https://raw.githubusercontent.com/princeSmall/ShareDataExample/master/documentShow.png)

#### UIActivityViewController

UIDocumentInteractionController 只允许文件URL，但是UIActivityViewController可以共享一种或者多种类型

* NSString
* NSAttributedString
* NSURL
* UIImage
* ALAsset
* UIActivityItemSource

<pre>
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
</pre>