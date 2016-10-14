//
//  KSLive.h
//  KS_inke
//
//  Created by 耳动人王 on 16/10/10.
//  Copyright © 2016年 KS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCreator.h"
@interface KSLive : NSObject
@property (nonatomic, copy) NSString * city;
@property (nonatomic, strong) KSCreator * creator;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, copy) NSString * idField;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, assign) NSInteger multi;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) NSInteger onlineUsers;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger pubStat;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, copy) NSString * shareAddr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString * streamAddr;
@property (nonatomic, assign) NSInteger version;

@property (nonatomic, copy) NSString * distance;


@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign,getter = isShow)BOOL show;



@end
