//
//  CompareKeysVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/14/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "serverURL.h"
#import "UserDataModel.h"
#import "PPRevealSideViewController.h"//;
#import "UIImageView+WebCache.h"


@interface CompareKeysVC : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSArray *status;
@property(strong,nonatomic)NSData *imageData;
@property(strong,nonatomic)UIView *overlayView;
- (IBAction)uploadKeysAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UITextField *statusTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(strong,nonatomic)NSString *status_check;
@property(strong,nonatomic)NSString *user_id;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondimage;
- (IBAction)DetailAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property(strong,nonatomic)NSMutableDictionary *catVCDictionary;
@property (weak, nonatomic) IBOutlet UIView *MyUIView;
@property (weak, nonatomic) IBOutlet UILabel *UploadByLebel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *KeynameLabel;
@property (weak, nonatomic) IBOutlet UILabel *KeyLocationLebel;

@end
