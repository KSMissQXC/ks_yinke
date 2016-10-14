//
// Created by jason on 12-11-20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HFAnimation.h"
#import "QuartzCore/QuartzCore.h"




static SystemSoundID soundID;

@implementation HFAnimation
//!!!翻转 从左往右
+(void) animationFlipFromLeft:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}

//!!!翻转 从右往左
+(void) animationFlipFromRight:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:view cache:YES];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}

 //!!! 翘脚落下
+(void) animationCurViewDown:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:YES];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}
//!!!翘脚翻起
+(void) animationCurViewUp:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:view cache:YES];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}

 //!!! 爆炸
+(void) animationExplosion:(id)sender
{
    UIView *view = (UIView*)sender;
    CGAffineTransform scale = CGAffineTransformMakeScale(5.0f, 5.0f);
    CGAffineTransform unScale = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView animateWithDuration:0.3 animations:^{
        [view setAlpha:0.0f];
        [view setTransform:scale];
    } completion:^(BOOL finished){
        [view setAlpha:1.0f];
        [view setTransform:unScale];
    }];
}

//!!! 晃动提醒
+ (void)animationShake:(id)sender
{
    [self animationShake:sender repeatCount:FLT_MAX];
}

+ (void)animationShake:(id)sender  repeatCount:(float)repeatCount
{
    UIView *view = (UIView*)sender;
    CGFloat t = 2.0;
    CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    view.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:repeatCount];
        view.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                view.transform = CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
    
}
//!!! 晃动带弹性
+ (void)animationShakeBounce:(id)sender
{
    [self shakeXWithOffset:30.0 breakFactor:0.75 duration:1.5 maxShakes:25 sender:sender];
}
+ (void)shakeXWithOffset:(CGFloat)aOffset breakFactor:(CGFloat)aBreakFactor duration:(CGFloat)aDuration maxShakes:(NSInteger)maxShakes sender:(id)sender
{
    UIView *view = (UIView*)sender;
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	[animation setDuration:aDuration];
	NSMutableArray *keys = [NSMutableArray arrayWithCapacity:20];
	NSInteger infinitySec = maxShakes;
	while(aOffset > 0.01) {
		[keys addObject:[NSValue valueWithCGPoint:CGPointMake(view.center.x - aOffset, view.center.y)]];
		aOffset *= aBreakFactor;
		[keys addObject:[NSValue valueWithCGPoint:CGPointMake(view.center.x + aOffset, view.center.y)]];
		aOffset *= aBreakFactor;
		infinitySec--;
		if(infinitySec <= 0) {
			break;
		}
	}
	
	animation.values = keys;
	
	
	[view.layer addAnimation:animation forKey:@"position"];
}




+(void )animationMovepoint:(id)sender point:(CGPoint )point //点移动
{
    UIView *view = (UIView*)sender;
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.duration = .5;
    animation.toValue=[NSValue valueWithCGPoint:point];
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"transform.scale"];
}

//!!! 去掉所有动画
+(void)removeAllAnimation:(id)sender;
{
    UIView *view = (UIView*)sender;
    [UIView setAnimationsEnabled:YES];
    [view.layer removeAllAnimations];
}


//!!! 旋转动画
+(void)animationRotate:(id)sender rotatePos:(RotatePos)rotatePos 
{
    [self animationRotate:sender rotatePos:rotatePos duration:1.f repeatCount:FLT_MAX];
}
+(void)animationRotate:(id)sender rotatePos:(RotatePos)rotatePos duration:(NSTimeInterval)duration  repeatCount:(float)repeatCount
{
    UIView *view = (UIView*)sender;
    CAKeyframeAnimation *rotateAnimation;
    switch (rotatePos) {
        case RotateX:
            rotateAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"]; //设置动画类型为绕x轴旋转（即图片的水平翻转）
            break;
        case RotateY:
            rotateAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"]; //设置动画类型为绕x轴旋转（即图片的水平翻转）
            break;
        default:
            rotateAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"]; //设置动画类型为绕z轴旋转（即图片的水平翻转）
            break;
            break;
    }
    
    rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:2*M_PI],nil]; //设置起始位置，在此为0~2pi，即旋转360度
    rotateAnimation.duration = duration; //动画持续时间1秒
    rotateAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:.0], //动画关键帧设置，此处为动画开始时间
                                [NSNumber numberWithFloat:duration], //动画结束时间
                                nil];
    rotateAnimation.repeatCount = repeatCount;
    [view.layer addAnimation:rotateAnimation forKey:@"transform.rotation.x"];

}



//!!! 隐藏动画
+(void)animationHidden:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView animateWithDuration:1 animations:^{
        [view setAlpha:0.0f];
    } completion:^(BOOL finished){
        [view setHidden:YES];
        [view setAlpha:1];
    }];
}


//!!! 隐藏动画
+(void)animationShow:(id)sender
{
    UIView *view = (UIView*)sender;
    [view setAlpha:0];
    [view setHidden:NO];
    [UIView animateWithDuration:1 animations:^{
        [view setAlpha:1.0f];
    } completion:^(BOOL finished){
        [view setAlpha:1];
    }];
}


+(void)animationHeartbeat:(id)sender
{
    [self animationHeartbeat:sender repeatCount:FLT_MAX];
};


+(void)animationHeartbeat:(id)sender repeatCount:(float)repeatCount
{
    float bigSize = 1.1;
    UIView *view = (UIView*)sender;
    
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = .5;
    pulseAnimation.toValue = [NSNumber numberWithFloat:bigSize];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = repeatCount;
    [view.layer addAnimation:pulseAnimation forKey:@"transform.scale"];
};

+(void)imgAnimate:(UIButton*)btn{
    
    UIView *view=btn.subviews[0];
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8, 0.8);
     } completion:^(BOOL finished){//do other thing
         [UIView animateWithDuration:0.2 animations:
          ^(void){
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
          } completion:^(BOOL finished){//do other thing
              [UIView animateWithDuration:0.1 animations:
               ^(void){
                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
               } completion:^(BOOL finished){//do other thing
               }];
          }];
     }];
    
    
}






+(void)palySound:(NSString*)soundAct
{
    // 1.获得音效文件的全路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:soundAct withExtension:nil];
    
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlayAlertSound(soundID);
}
@end
