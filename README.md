### ShareDataExample

#### 黏贴版
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
