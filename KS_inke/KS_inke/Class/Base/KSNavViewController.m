//
//  KSNavViewController.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSNavViewController.h"


@interface KSNavViewController ()

@end

@implementation KSNavViewController

//在这个只调用一次的方法里面设置一次性属性
+(void)initialize{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    [bar setBackgroundImage:[UIImage imageNamed:@"global_tittle_bg"] forBarMetrics:UIBarMetricsDefault];
    bar.tintColor = [UIColor whiteColor];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.block) {
//        self.block(self.viewControllers.count);
//    }
//    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

//-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    
//    if (self.block) {
//        self.block(self.viewControllers.count - 2);
//    }
//    return  [super popViewControllerAnimated:animated];
//}

//-(NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.block) {
//        self.block(self.viewControllers.count - 2);
//    }
//    return [super popToViewController:viewController animated:animated];
//}
//
//-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
//    if (self.block) {
//        self.block(0);
//    }
//    return [super popToRootViewControllerAnimated:animated];
//
//}


@end
