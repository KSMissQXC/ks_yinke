//
//  KSTabBarViewController.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSTabBarViewController.h"
#import "KSNavViewController.h"
#import "KSTabBar.h"
#import "KSStartLiveController.h"

@interface KSTabBarViewController ()<KSTabBarDelegate,UITabBarControllerDelegate>

@property(nonatomic,strong)KSTabBar *ksTabBar;
@property(nonatomic,assign)BOOL hidesBottomBarWhenPushed;



@end

@implementation KSTabBarViewController

#pragma mark - 懒加载
-(KSTabBar *)ksTabBar{
    if (_ksTabBar == nil) {
        _ksTabBar = [[KSTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KSTabBarHeight)];
        _ksTabBar.delegate = self;
    }
    return _ksTabBar;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有子控件
    [self configAllChildVc];
    //配置下面的TbaBar
    [self configTabBar];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //增加tabBar的高度,防止点击中间的时候点击cell的跳转
    self.tabBar.height = 80;
    self.tabBar.top = SCREEN_HEIGHT - self.tabBar.height;
    self.ksTabBar.top = 80 -KSTabBarHeight;
    self.tabBar.backgroundImage = [ToolClass createImageWithColor:[UIColor clearColor]];
     //删除tabbar的阴影线
    self.tabBar.shadowImage = [UIImage new];
    
    //在插入一层 禁止掉自带的切换控制器事件
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    [self.tabBar insertSubview:v belowSubview:self.ksTabBar];
}



#pragma mark 添加TabBar
-(void)configTabBar{
    [self.tabBar addSubview:self.ksTabBar];
}

#pragma mark 添加所有子控制器
-(void)configAllChildVc{
    NSMutableArray *vcNames = [[NSMutableArray alloc] initWithArray:@[@"KSHomeViewController",@"KSMeViewController"]];
    for (NSInteger i = 0; i < vcNames.count; i++) {
        NSString *vcName = vcNames[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        KSNavViewController *nvc = [[KSNavViewController alloc] initWithRootViewController:vc];
//        @weakify(self);
//        nvc.block = ^(NSInteger count){
//            @strongify(self);
//            [self whetherBottomBar:count];
//        };
        
        [vcNames replaceObjectAtIndex:i withObject:nvc];
    }
    self.viewControllers = vcNames;
}


#pragma mark - 代理
#pragma mark KSTabBar代理
-(void)tabBar:(KSTabBar *)tabBar ClickButton:(KSTabBarItemType)buttonType{
    NSLog(@"%zd",buttonType);
    if (buttonType == KSTabBarItemMid) {
        //点击中间的模态出一个控制器
        KSStartLiveController *liveVc = [[KSStartLiveController alloc] init];
        [self presentViewController:liveVc animated:YES completion:nil];
        
    }else{
        //点击的是item切换控制器
        self.selectedIndex = buttonType - KSTabBarItemHome;
    }
}

#pragma mark - 私有方法
-(void)whetherBottomBar:(NSInteger)count{
    self.ksTabBar.hidden = count ? YES : NO;
    
}










@end
