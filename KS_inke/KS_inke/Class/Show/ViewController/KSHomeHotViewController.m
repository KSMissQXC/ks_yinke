//
//  KSHomeHotViewController.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSHomeHotViewController.h"
#import "KSLiveHandler.h"
#import "KSHomeLiveHotCell.h"
#import "KSPlayerViewController.h"
#import <AFNetworking.h>

@interface KSHomeHotViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;





@end

@implementation KSHomeHotViewController

static NSString *ID = @"KSHomeLiveHotCell";


#pragma mark - 懒加载
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}

#pragma mark 初始化UI
-(void)initUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"KSHomeLiveHotCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.rowHeight = SCREEN_WIDTH + SCREEN_WIDTH / 5.0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, KSTabBarHeight, 0);
}

#pragma mark 请求数据
-(void)loadData{
    [KSLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        [self.dataArray addObjectsFromArray:obj];
        [self.tableView reloadData];
        
//        KSLog(@"---%@",obj);
        
    } failed:^(id obj) {
//        NSLog(@"%@",obj);
        
    }];
    
    [KSLiveHandler excuteGetAdImageByTaskWithSuccess:^(id obj) {
//        NSLog(@"%@",obj);
        
    } failed:^(id obj) {
//        NSLog(@"%@",obj);
    }];
    
    
    
}




#pragma mark - 代理
#pragma mark tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KSHomeLiveHotCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.liveItem = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KSPlayerViewController *playVc = [[KSPlayerViewController alloc] init];
    playVc.liveItem = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:playVc animated:YES];
    
   
}












@end
