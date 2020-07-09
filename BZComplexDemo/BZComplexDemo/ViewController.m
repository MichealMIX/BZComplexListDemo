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
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tv;

@property(nonatomic,copy)NSArray *dataArray;

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

static NSString *cellId = @"BZComplexCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BZComplexDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self testFPSLabel];
}

- (void)initUI{
    self.tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tv.dataSource = self;
    self.tv.delegate = self;
    self.tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tv.estimatedRowHeight=100.f;
    self.tv.rowHeight = UITableViewAutomaticDimension;
    [self.tv registerClass:[BZComplexCell class] forCellReuseIdentifier:cellId];
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
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BZComplexCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[BZComplexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary *data_dict = self.dataArray[indexPath.row];
    [cell updateCellWithData:data_dict];
    [cell updateCellWithImageArray:[data_dict objectForKey:@"ContentImageArray"]];
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

#pragma mark - getter&setter

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = iRes4ary(@"BZListData.plist");
    }
    return _dataArray;
}

@end
