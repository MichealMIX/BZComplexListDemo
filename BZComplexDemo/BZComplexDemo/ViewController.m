//
//  ViewController.m
//  BZComplexDemo
//
//  Created by brandon on 2020/7/3.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "ViewController.h"
#import "BZComplexCell.h"
#import "YYFPSLabel.h"
#import "BZViewModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tv;

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BZComplexDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self testFPSLabel];
    [self fetchNetwork];
}

//模拟网络请求
- (void)fetchNetwork{
    [BZViewModel getListViewData:^{

    }];
}

- (void)initUI{
    self.tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tv.dataSource = self;
    self.tv.delegate = self;
//    self.tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    //self.tv.estimatedRowHeight=100.f;
    //self.tv.rowHeight = UITableViewAutomaticDimension;
   [BZViewModel registerCellsFor:self.tv];
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarAndStatusBarHeight);
        make.left.equalTo(@0);
        make.width.mas_equalTo(iScreenW);
        make.height.mas_equalTo(iScreenH-(kNavBarAndStatusBarHeight+kBottomSafeHeight));
    }];
}

#pragma mark - UITableViewDelegate&UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [BZViewModel numberOfTableRow];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [BZViewModel heightOfRowAt:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell <BZViewModelDataDelegate>*cell = [BZViewModel cellFrom:tableView forIndex:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - fps moniter(CPU)

- (void)testFPSLabel {
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
}

@end
