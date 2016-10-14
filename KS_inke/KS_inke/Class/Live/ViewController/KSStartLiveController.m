//
//  KSStartLiveController.m
//  KS_inke
//
//  Created by 耳动人王 on 2016/10/13.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSStartLiveController.h"
#import "LFLivePreview.h"
#import "LFLiveKit.h"


@interface KSStartLiveController ()<LFLivePreviewDelegate>

//@property(nonatomic,strong)LFLiveSession *session;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;






@end

@implementation KSStartLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
}

//- (LFLiveSession*)session {
//    if (!_session) {
//        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
//        _session.preView = self;
//        _session.delegate = self;
//    }
//    return _session;
//}





- (IBAction)startLive:(UIButton *)sender {
    KSLog(@"---");
//    sender.hidden = YES;
    self.closeBtn.hidden = YES;
//    UIView * backview = [[UIView alloc] initWithFrame:self.view.bounds];
//    backview.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:backview];
    
    LFLivePreview * preView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    preView.vc = self;
    preView.delegate = self;

    [self.view addSubview:preView];
    //开启直播
    [preView startLive];
    
}

- (IBAction)closeLive:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)livePreviewDidClickClose:(LFLivePreview *)preview{
    [self closeLive:nil];
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}





@end
