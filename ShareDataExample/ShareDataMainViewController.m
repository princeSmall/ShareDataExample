


//
//  ShareDataMainViewController.m
//  ShareDataExample
//
//  Created by le tong on 2019/3/14.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "ShareDataMainViewController.h"
#import "PasteboardViewController.h"

@interface ShareDataMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *shareDataTableView;
@property (nonatomic, strong) NSArray *shareDataArray;
@end

@implementation ShareDataMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ShareData";
    [self.view addSubview:self.shareDataTableView];
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shareDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.shareDataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[PasteboardViewController new] animated:YES];
}
- (UITableView *)shareDataTableView{
    if (!_shareDataTableView) {
        _shareDataTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _shareDataTableView.delegate = self;
        _shareDataTableView.dataSource = self;
        _shareDataTableView.tableFooterView = [UIView new];
        [_shareDataTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    }
    return _shareDataTableView;
}
- (NSArray *)shareDataArray{
    if (!_shareDataArray) {
        _shareDataArray = [NSArray arrayWithObjects:@"Pasteboard", nil];
    }
    return _shareDataArray;
}

@end
