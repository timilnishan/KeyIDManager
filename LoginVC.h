//
//  LoginVC.h
//  KeyIdManager
//
//  Created by design_offshore on 3/30/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"//;
#import "RightViewController.h"
#import "RightSettingVC.h"
#import "RegisterVC.h"
//#import <FacebookSDK/FacebookSDK.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "serverURL.h"
#import "ForgotPasswordVC.h"
#import "UserDataModel.h"
#import "FacebookRegDataModel.h"
//#import <GooglePlus/GooglePlus.h>
//#import <GoogleOpenSource/GoogleOpenSource.h>
#import "DashboardVC.h"
#import "HomeSettingVC.h"
#import "SettingDataModel.h"
#import "MBProgressHUD.h"

@class GPPSignInButton;

@interface LoginVC : UIViewController<UITextFieldDelegate>
- (IBAction)g:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (weak, nonatomic) NSMutableArray *friendsDetailsArray;
@property(weak,nonatomic)UINavigationController *mynav;
@property(weak,nonatomic)ASIFormDataRequest *feedRequest;
@property(weak,nonatomic)ASIFormDataRequest *LoginfacebookRequest;
@property(strong,nonatomic)NSMutableArray *facebookArray;
@property(strong,nonatomic)NSMutableArray *settingArray;
@property(strong,nonatomic)MBProgressHUD *HUD;
@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
- (IBAction)GPlusAction:(id)sender;


- (IBAction)SingUpAction:(id)sender;
- (IBAction)SingInAction:(id)sender;
- (IBAction)FacebookLoginAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *MyScrollView;
- (IBAction)ForgotpasswordAction:(id)sender;
@property(nonatomic,strong)NSMutableArray *myArray;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(strong,nonatomic)UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordIconImageView;

@end
