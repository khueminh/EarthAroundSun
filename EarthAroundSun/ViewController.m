//
//  ViewController.m
//  EarthAroundSun
//
//  Created by Nguyen Minh Khue on 7/25/15.
//  Copyright (c) 2015 Nguyen Minh Khue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer *timer;
    NSTimer *timerMoon;
    UIImageView *sun;
    UIImageView *earth;
    UIImageView *moon;
    CGPoint sunCenter; //CoreGraphics Point
    CGFloat distanceEarthToSun;
    CGFloat angle;  //goc quay
    
    CGPoint earthCenter; //CoreGraphics Point
    CGFloat distanceMoontoEarth;
    CGFloat angleMoon;  //goc quay
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addSunAndEarth];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                             target:self
                                           selector:@selector(spinEarth)
                                           userInfo:nil
                                            repeats:true];
    
    timerMoon = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                             target:self
                                           selector:@selector(spinMoon)
                                           userInfo:nil
                                            repeats:true];
    
}
- (void)addSunAndEarth {
    sun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun.jpg"]];
    earth = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earthnew.png"]];
    moon =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moon.png"]];
    
    CGSize mainViewSize = self.view.bounds.size;
    
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    sunCenter = CGPointMake(mainViewSize.width * 0.5, (mainViewSize.height + statusNavigationBarHeight) * 0.5);
    
    sun.center = sunCenter;
    
    distanceEarthToSun = mainViewSize.width * 0.5 - 32.0;
    angle = 0.0;
    earth.center = [self computePositionOfEarth:angle];
    
    
    distanceMoontoEarth = earth.frame.size.width * 0.5 + 5.0 + 16;
    angleMoon = 0.0;
    moon.center = [self computePositionOfMoon:angleMoon];
    
    [self.view addSubview:sun];
    [self.view addSubview:earth];
    [self.view addSubview:moon];
    
}

- (CGPoint)computePositionOfEarth: (CGFloat) _angle {
    return CGPointMake(sunCenter.x + distanceEarthToSun * cos(_angle),
                       sunCenter.y + distanceEarthToSun * sin(_angle));
}

- (CGPoint)computePositionOfMoon: (CGFloat) _angle {
    return CGPointMake(earth.frame.size.width/2 +  earth.frame.origin.x + distanceMoontoEarth * cos(_angle),
                       earth.frame.size.height/2 + earth.frame.origin.y + distanceMoontoEarth * sin(_angle));
}

- (void) spinEarth {
    angle += 0.02;
    earth.center = [self computePositionOfEarth:angle];
}

- (void) spinMoon {
    angleMoon += 0.01;
    moon.center = [self computePositionOfMoon:angleMoon];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}



@end
