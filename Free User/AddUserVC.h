//
//  AddUserVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/19/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "serverURL.h"
#import "PPRevealSideViewController.h"//;
#import "AddUserUserTypeDataModel.h"
@interface AddUserVC : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *adduserTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property(nonatomic,strong)NSString *user_id;
@property(strong,nonatomic)NSString *code;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property(strong,nonatomic)NSMutableArray *usertype;
@property(strong,nonatomic)NSMutableDictionary *catVCDictionary;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ConformpasswordTextfield;
- (IBAction)addUserAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *mypickerView;
@property(nonatomic,strong)ASIFormDataRequest *dataRequest;
@property(nonatomic,strong)NSMutableArray *UserTypeArray;

@end
