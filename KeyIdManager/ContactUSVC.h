//
//  ContactUSVC.h
//  KeyIdManager
//
//  Created by design_offshore on 3/31/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightSettingVC.h"
#import "ASIFormDataRequest.h"
#import "HomeSettingVC.h"

@interface ContactUSVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *AddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *PhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextView *MessageTextField;
@property(weak,nonatomic)ASIFormDataRequest *contactRequest;
@property (weak, nonatomic) IBOutlet UIScrollView *MyScrollView;
@property(nonatomic)BOOL IsUserClick;
@property(strong,nonatomic)NSString *user_id;
@property(strong,nonatomic)NSString *userType;

@property (weak, nonatomic) IBOutlet UIImageView *Myimage;
- (IBAction)facebookAction:(id)sender;

- (IBAction)SubmitAction:(id)sender;
- (IBAction)twitterAction:(id)sender;
- (IBAction)linkinedAction:(id)sender;

@end
