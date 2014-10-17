//
//  EditKeysVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/19/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "serverURL.h"

@interface EditKeysVC : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property(strong,nonatomic)NSString *keyname;
@property(strong,nonatomic)NSString *img;
- (IBAction)saveAction:(id)sender;
@property(strong,nonatomic)NSString *date;
@property(strong,nonatomic)NSString *bywho;
@property(strong,nonatomic)NSString *location;
@property(strong,nonatomic)NSString *key_id;
@property(strong,nonatomic)NSString *user_id;
@property (weak, nonatomic) IBOutlet UITextField *keynameTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyLocationTextField;
@property(strong,nonatomic)NSData *imageData;
- (IBAction)uploadImageAction:(id)sender;

@end
