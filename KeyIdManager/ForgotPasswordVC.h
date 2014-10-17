//
//  ForgotPasswordVC.h
//  KeyIdManager
//
//  Created by design_offshore on 4/1/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "serverURL.h"

@interface ForgotPasswordVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *MyScroolView;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property(weak,nonatomic)ASIFormDataRequest *emailRequest;
- (IBAction)SubmitAction:(id)sender;

@end
