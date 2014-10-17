//
//  EditUserVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/20/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"



@interface EditUserVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *FullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *LastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property(weak,nonatomic)NSString *id_;
@property(strong,nonatomic)NSString *user_id;
@property(strong,nonatomic)NSString *first_name;
@property(strong,nonatomic)NSString *last_name;
- (IBAction)RegisterAction:(id)sender;

@end
