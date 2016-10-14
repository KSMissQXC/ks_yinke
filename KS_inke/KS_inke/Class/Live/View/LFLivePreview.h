//
//  LFLivePreview.h
//  LFLiveKit
//
//  Created by 倾慕 on 16/5/2.
//  Copyright © 2016年 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFLivePreview;
@protocol LFLivePreviewDelegate <NSObject>

-(void)livePreviewDidClickClose:(LFLivePreview *)preview;

@end

@interface LFLivePreview : UIView
@property (nonatomic, strong) UIViewController * vc;

- (void)startLive;

- (void)stopLive;

@property(nonatomic,weak)id <LFLivePreviewDelegate> delegate;


@end
