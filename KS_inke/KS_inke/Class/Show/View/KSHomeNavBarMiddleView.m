//
//  KSHomeNavBarMiddleView.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSHomeNavBarMiddleView.h"

@interface KSHomeNavBarMiddleView ()
@property(nonatomic,strong)UIView *dividerView;

@property(nonatomic,weak)UIButton *selectedBtn;

@property(nonatomic,strong)NSMutableArray *btnArray;




@end

@implementation KSHomeNavBarMiddleView

-(UIView *)dividerView{
    if (_dividerView == nil) {
        _dividerView = [[UIView alloc] init];
        _dividerView.backgroundColor = [UIColor whiteColor];
        _dividerView.height = 2;
    }
    return _dividerView;
}

-(NSMutableArray *)btnArray{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUIWithTitleArray:titleArray];
        
    }
    return self;
}

-(void)initUIWithTitleArray:(NSArray *)titleArray{
    NSInteger titleCount = titleArray.count;
    CGFloat btnW = self.width / titleCount;
    CGFloat btnH = self.height;
    for (NSInteger i = 0; i < titleCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
//        btn.backgroundColor = [UIColor grayColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        [btn.titleLabel sizeToFit];
        btn.tag = KSHomeNavBarMiddleViewItemFocus + i;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 1) {
            //添加下面的下划线
            self.dividerView.width = btn.titleLabel.width;
            self.dividerView.bottom = self.height;
            self.dividerView.centerX = btn.centerX;
            [self addSubview:self.dividerView];
            self.selectedBtn = btn;
        }
        [self.btnArray addObject:btn];
    }
}


-(void)btnClick:(UIButton *)btn{
    
    if (self.selectedBtn == btn) return;
    [self scrollToDestinationWithIndex:btn.tag];
    if ([self.delegate respondsToSelector:@selector(homeNavBarMiddleView:clickMiddleBtn:)]) {
        [self.delegate homeNavBarMiddleView:self clickMiddleBtn:btn.tag];
    }
}

#pragma mark - 提供外部方法
#pragma mark - 下划线滚动到对应的标题下面
-(void)scrollToDestinationWithIndex:(KSHomeNavBarMiddleViewItemType)index{
    UIButton *btn = self.btnArray[index];
    if (self.selectedBtn == btn) return;
    self.selectedBtn = btn;
    //动画移动下面的线条
    [UIView animateWithDuration:0.25 animations:^{
        self.dividerView.width = btn.titleLabel.width;
        self.dividerView.centerX = btn.centerX;
    }];

    
}




@end
