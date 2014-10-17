//
//  RegisterVC.h
//  KeyIdManager
//
//  Created by design_offshore on 3/30/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"//;
#import "RightSettingVC.h"
#import "ASIFormDataRequest.h"
#import "LoginVC.h"
@interface RegisterVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *FirstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *LastnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ConformpasswordTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *MyScrollView;
@property(weak,nonatomic)NSString *status;
@property(weak,nonatomic)ASIFormDataRequest *dataRequest;
@property(weak,nonatomic)ASIFormDataRequest *statusRequest;
@property(strong,nonatomic)UIView *overlayView;
@property(strong,nonatomic)NSMutableArray *settingArray;
- (IBAction)SingUpAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *newsletterLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

@end
