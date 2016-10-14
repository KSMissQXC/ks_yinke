//
//  KSLocationManager.m
//  KS_inke
//
//  Created by 耳动人王 on 2016/10/12.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface KSLocationManager ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locMgr;

@property(nonatomic,copy)KSLocationManagerBlock block;


@end

@implementation KSLocationManager

+(instancetype)sharedLocationManager{
    static KSLocationManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[KSLocationManager alloc] init];
    });
    return mgr;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _locMgr = [[CLLocationManager alloc] init];
        _locMgr.desiredAccuracy = kCLLocationAccuracyBest;
        _locMgr.distanceFilter = 100;
        _locMgr.delegate = self;
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"开启定位服务");
        }else{
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locMgr requestWhenInUseAuthorization];
            }
        }
       
    }
    return self;
}

-(void)getLocation:(KSLocationManagerBlock)block{
    
    self.block = block;
    [self.locMgr startUpdatingLocation];
}

#pragma mark - 代理
#pragma mark location代理
//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation{
//    NSLog(@"更新位置信息");
//    //更新到了位置信息
//    CLLocationCoordinate2D coor = newLocation.coordinate;
//    NSString *lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
//    NSString *lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];
//    self.lat = lat;
//    self.lon = lon;
//    if (self.block) {
//        self.block(lat,lon);
//    }
//    [self.locMgr stopUpdatingHeading];
////    KSLog(@"%@---%@",lat,lon);
//    
//}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.locMgr stopUpdatingHeading];

    NSLog(@"更新位置信息");

    CLLocation *newLocation = locations.firstObject;
    
    CLLocationCoordinate2D coor = newLocation.coordinate;
    NSString *lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString *lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];
    self.lat = lat;
    self.lon = lon;
    if (self.block) {
        self.block(lat,lon);
    }
    
    
}








@end
