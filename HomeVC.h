//
//  HomeVC.h
//  KeyIdManager
//
//  Created by design_offshore on 3/31/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "UserDataModel.h"
#import "LoginVC.h"
#import <FacebookSDK/FacebookSDK.h>
#import "HomeSettingVC.h"
#import "HomeSettingCell.h"

@interface HomeVC : UIViewController<UINavigationControllerDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)ASIFormDataRequest *dataRequest;
@property  NSData *imageData;

@property (weak, nonatomic) IBOutlet UILabel *MyLabel;

@property(strong,nonatomic)UIView *overlayView;
@property(nonatomic,strong)NSString *UserId;

- (IBAction)CameraAction:(id)sender;
- (IBAction)LogoutAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end
