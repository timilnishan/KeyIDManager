//
//  MyKeysDetailVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/18/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "serverURL.h"
#import "UIImageView+WebCache.h"
#import "EditKeysVC.h"
#import "MBProgressHUD.h"

@interface MyKeysDetailVC : UIViewController<UIAlertViewDelegate>
@property(strong,nonatomic)NSString *keyname;
@property(strong,nonatomic)NSString *img;
@property(strong,nonatomic)NSString *date;
@property(strong,nonatomic)NSString *bywho;
@property(strong,nonatomic)NSString *location;
@property(strong,nonatomic)NSString *key_id;
@property(strong,nonatomic)NSString *user_id;
@property(strong,nonatomic)MBProgressHUD *HUD;

- (IBAction)CheckInAction:(id)sender;
- (IBAction)ViewLogAction:(id)sender;
- (IBAction)DuplicateLogAction:(id)sender;

- (IBAction)checkOutAction:(id)sender;

- (IBAction)EditAction:(id)sender;

- (IBAction)DeleteAction:(id)sender;

@property(strong,nonatomic)ASIFormDataRequest *dataRequest;
@property(strong,nonatomic)ASIFormDataRequest *Deleterequest;
@property(strong,nonatomic)ASIFormDataRequest *checkoutRequest;
@property(strong,nonatomic)ASIFormDataRequest *checkinRequest;


@property (weak, nonatomic) IBOutlet UILabel *keylocation;
@property (weak, nonatomic) IBOutlet UIImageView *DisplayImage;
@property (weak, nonatomic) IBOutlet UILabel *BYlabel;
@property (weak, nonatomic) IBOutlet UILabel *keynameLabel;
- (IBAction)DeleteKeyAction:(id)sender;
- (IBAction)EditKeysAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@end
