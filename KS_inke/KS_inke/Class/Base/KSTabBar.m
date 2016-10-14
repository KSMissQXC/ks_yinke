//
//  KSTabBar.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSTabBar.h"
#import "HFAnimation.h"

@interface KSTabBar ()

@property(nonatomic,strong)UIImageView *bgImage;

@property(nonatomic,strong)NSMutableArray *itemArray;

//中间的按钮
@property(nonatomic,strong)UIButton *midBtn;


@property(nonatomic,weak)UIButton *selectedBtn;




@end

@implementation KSTabBar

#pragma mark - 懒加载
-(NSMutableArray *)itemArray{
    if (_itemArray == nil) {
        _itemArray = [[NSMutableArray alloc] initWithArray:@[@"tab_live",@"tab_me"]];
    }
    return _itemArray;
}

-(UIImageView *)bgImage{
    if (_bgImage == nil) {
        _bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _bgImage;
}

-(UIButton *)midBtn{
    if (_midBtn == nil) {
        _midBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_midBtn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_midBtn sizeToFit];
        [_midBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _midBtn.tag = KSTabBarItemMid;
    }
    return _midBtn;
}


#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.bgImage];
    //添加所有item
    for (NSInteger i = 0; i < self.itemArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setImage:[UIImage imageNamed:self.itemArray[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[self.itemArray[i] stringByAppendingString:@"_p"]] forState:UIControlStateDisabled];
        [self addSubview:btn];
        [self.itemArray replaceObjectAtIndex:i withObject:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = KSTabBarItemHome + i;
        if (i == 0) {
            
            //默认TbaBarController就会显示第一个子控制器的view所有没必要调用按钮点击方法
            btn.enabled = NO;
            self.selectedBtn = btn;
        }
    }
    [self addSubview:self.midBtn];
    
}

#pragma mark 布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //常量
    CGFloat itemCount = self.itemArray.count;
    CGFloat itemWidth = self.width / itemCount;
    CGFloat itemHeight = self.height;
    self.bgImage.frame = self.bounds;
    
    for (NSInteger i = 0; i < itemCount; i++) {
        UIButton *btn = self.itemArray[i];
        btn.frame = CGRectMake(i * itemWidth, 0, itemWidth, itemHeight);
    }
    self.midBtn.centerX = self.width * 0.5;
    self.midBtn.centerY = 0;
    
    
}



#pragma mark - 事件处理
-(void)btnClick:(UIButton *)btn{

    KSLog(@"点击了下面的btn");
    if ([self.delegate respondsToSelector:@selector(tabBar:ClickButton:)]) {
        [self.delegate tabBar:self ClickButton:btn.tag];
    }
    
    if (btn.tag == KSTabBarItemMid) return;
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    //动画
    [HFAnimation imgAnimate:btn];
    

}








@end
