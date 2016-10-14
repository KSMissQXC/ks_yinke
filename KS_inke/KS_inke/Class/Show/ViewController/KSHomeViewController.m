//
//  KSHomeViewController.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSHomeViewController.h"
#import "KSHomeNavBarMiddleView.h"
#import "KSLocationManager.h"

@interface KSHomeViewController ()<UIScrollViewDelegate,KSHomeNavBarMiddleViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property(nonatomic,strong)NSArray *vcTitleNamesArray;
@property(nonatomic,strong)KSHomeNavBarMiddleView *middleView;

@end

@implementation KSHomeViewController

#pragma mark - 懒加载
-(NSArray *)vcTitleNamesArray{
    if (_vcTitleNamesArray == nil) {
        _vcTitleNamesArray = @[@"关注",@"热门",@"附近"];
    }
    return _vcTitleNamesArray;
}

-(KSHomeNavBarMiddleView *)middleView{
    if (_middleView == nil) {
        _middleView = [[KSHomeNavBarMiddleView alloc] initWithFrame:CGRectMake(0, 0, KSHomeNavMiddleViewWidth, KSHomeNavMiddleViewHeight) titleArray:self.vcTitleNamesArray];
//        _middleView.backgroundColor = [UIColor redColor];
        _middleView.delegate = self;
    }
    return _middleView;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self configAllChildVc];
    [self initUI];
    [[KSLocationManager sharedLocationManager] getLocation:^(NSString *lat, NSString *lon) {
        KSLog(@"%@---%@",lat,lon);
    }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    KSLog(@"%@",NSStringFromUIEdgeInsets(self.contentScrollView.contentInset));
//    
//    KSLog(@"%@",NSStringFromCGRect(self.contentScrollView.frame));
}


#pragma mark  配置所有子控制器
-(void)configAllChildVc{
    NSArray *vcNames = @[@"KSHomeFocusViewController",@"KSHomeHotViewController",@"KSHomeNearbyViewController"];
    for (NSInteger i = 0; i < vcNames.count; i++) {
        NSString *vcName = vcNames[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.vcTitleNamesArray[i];
        [self addChildViewController:vc];
    }
}

#pragma mark 配置contentScrollView
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.vcTitleNamesArray.count, 0);
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];

  
}


#pragma mark  配置导航栏
-(void)setupNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreClick)];
    self.navigationItem.titleView = self.middleView;
    
}


#pragma mark - 事件处理
-(void)searchClick{
    KSLog(@"%s",__func__);
    
}

-(void)moreClick{
    KSLog(@"%s",__func__);

}

#pragma mark - 代理
#pragma mark KSHomeNavBarMiddleViewDelegate
-(void)homeNavBarMiddleView:(KSHomeNavBarMiddleView *)middleView clickMiddleBtn:(KSHomeNavBarMiddleViewItemType)itemType{
    
    NSInteger index = itemType - KSHomeNavBarMiddleViewItemFocus;
    [self.contentScrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    
    
    
    
}

#pragma mark scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //求出当前索引
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self.middleView scrollToDestinationWithIndex:index];
    
    //取出当前索引对应的控制器
    UIViewController *vc = self.childViewControllers[index];
    if ([vc isViewLoaded]) return;
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.width, scrollView.height);
    [scrollView addSubview:vc.view];
    
}










@end
