//
//  DashboardVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/8/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSettingVC.h"
#import "UserDataModel.h"
#import "CompareKeysVC.h"
#import "MyKeysVC.h"
#import "PKRevealControllerContainerView.h"
#import "MBProgressHUD.h"
#import "GKImagePicker.h"

@class GKImagePicker;
@interface DashboardVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,GKImagePickerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *keysLebel;
@property (weak, nonatomic) IBOutlet UILabel *userLebel;
@property (weak, nonatomic) IBOutlet UILabel *adminLebel;
@property(nonatomic,strong)NSString *user_type;
@property(nonatomic,strong)NSString *key_name;
@property(nonatomic,strong)NSString *key_location;
@property(nonatomic,strong)NSString *imagename;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic,strong)NSString *user_id;
@property (weak, nonatomic) IBOutlet UITextField *test;
@property (weak, nonatomic) IBOutlet UITextField *testtextfield;
@property (weak, nonatomic) IBOutlet UILabel *AccountLabel;
@property(nonatomic,strong)ASIFormDataRequest *compareRequest;
@property(nonatomic,strong)ASIFormDataRequest *uploadRequest;
@property(nonatomic,strong)NSMutableDictionary *catVCDictionary;
@property (nonatomic, retain) GKImagePicker *picker;

@property(nonatomic,strong)NSData *imageData;
- (IBAction)ComparekeyAction:(id)sender;
- (IBAction)KeyLibraryAction:(id)sender;
- (IBAction)ManageKeyAction:(id)sender;
- (IBAction)upgradeAction:(id)sender;

@end
