//
//  UploadKeysVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/14/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "PPRevealSideViewController.h"//;


@interface UploadKeysVC : UIViewController<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *KeysNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *KeysLocationTextField;
@property(strong,nonatomic)NSData *imageData;
@property(strong,nonatomic)UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,strong)NSString *user_id;
- (IBAction)UploadImage:(id)sender;
@end
