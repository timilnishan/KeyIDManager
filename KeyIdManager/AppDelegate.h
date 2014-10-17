//
//  AppDelegate.h
//  KeyIdManager
//
//  Created by design_offshore on 3/30/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginVC.h"
#import "PPRevealSideViewController.h"
#import "HomeVC.h"
#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import "HomeSettingVC.h"





@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;

//- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
//- (void)userLoggedIn;
//- (void)userLoggedOut;
@end


