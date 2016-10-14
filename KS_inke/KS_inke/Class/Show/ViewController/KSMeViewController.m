//
//  KSMeViewController.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSMeViewController.h"
#import "KSSetting.h"
#import "KSMeHeaderView.h"

@interface KSMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSArray *dataList;




@end

@implementation KSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


-(void)initUI{
    
    KSMeHeaderView *headV = [KSMeHeaderView meHeaderView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableHeaderView = headV;
    
    
    
}

-(void)loadData{
    KSSetting * set1 = [[KSSetting alloc] init];
    set1.title = @"映客贡献榜";
    set1.subTitle = @"";
    set1.vcName = @"SXTGongViewController";
    
    KSSetting * set2 = [[KSSetting alloc] init];
    set2.title = @"收益";
    set2.subTitle = @"0 映票";
    set2.vcName = @"SXTShouViewController";
    
    KSSetting * set3 = [[KSSetting alloc] init];
    set3.title = @"账户";
    set3.subTitle = @"0 钻石";
    set3.vcName = @"SXTZhangViewController";
    
    KSSetting * set4 = [[KSSetting alloc] init];
    set4.title = @"等级";
    set4.subTitle = @"3 级";
    set4.vcName = @"SXTDengViewController";
    
    KSSetting * set5 = [[KSSetting alloc] init];
    set5.title = @"设置";
    set5.subTitle = @"";
    set5.vcName = @"SXTSettingViewController";
    
    NSArray * arr1 = @[set1,set2,set3];
    NSArray * arr2 = @[set4];
    NSArray * arr3 = @[set5];
    
    self.dataList = @[arr1,arr2,arr3];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList[section] count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    KSSetting * set = self.dataList[indexPath.section][indexPath.row];
    
    cell.textLabel.text = set.title;
    
    cell.detailTextLabel.text = set.subTitle;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

    
}























@end
