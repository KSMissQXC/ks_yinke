//
// Created by CQ on 1987-10-23.
//


#import <UIKit/UIKit.h>
//声音
#import "AudioToolbox/AudioToolbox.h"


typedef enum
{
    RotateX,
    RotateY,
    RotateZ
}RotatePos;


@interface HFAnimation : NSObject

+(void) animationFlipFromLeft:(id)sender;//翻转
+(void) animationFlipFromRight:(id)sender;

+(void) animationCurViewDown:(id)sender;//掀起
+(void) animationCurViewUp:(id)sender;

+(void) animationExplosion:(id)sender;//爆炸

+ (void)animationShake:(id)sender;
+ (void)animationShake:(id)sender  repeatCount:(float)repeatCount;

+ (void)animationShakeBounce:(id)sender;//晃动
+ (void)shakeXWithOffset:(CGFloat)aOffset breakFactor:(CGFloat)aBreakFactor duration:(CGFloat)aDuration maxShakes:(NSInteger)maxShakes sender:(id)sender;

+(void)animationShow:(id)sender;
+(void)animationHidden:(id)sender;

+(void )animationMovepoint:(id)sender point:(CGPoint )point; //点移动
+(void)animationHeartbeat:(id)sender;
+(void)animationHeartbeat:(id)sender repeatCount:(float)repeatCount;
+(void)removeAllAnimation:(id)sender;

+(void)animationRotate:(id)sender rotatePos:(RotatePos)rotatePos;//旋转
+(void)animationRotate:(id)sender rotatePos:(RotatePos)rotatePos duration:(NSTimeInterval)duration  repeatCount:(float)repeatCount;
+(void)imgAnimate:(UIButton*)btn;//TabBar下面 点击的时候让图片有个放大缩小正常的过程
+(void)palySound:(NSString*)soundAct;
@end