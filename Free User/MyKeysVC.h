//
//  MyKeysVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/14/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserKeysCell.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "UserKeysListModel.h"
#import "serverURL.h"
#import "MyKeysDetailVC.h"
#import "UIImageView+WebCache.h"
#import "PPRevealSideViewController.h"//;
#import "UploadKeysVC.h"
#import "MBProgressHUD.h"

@interface MyKeysVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)ASIFormDataRequest *checkinRequest;
@property(strong,nonatomic)ASIFormDataRequest *checkoutRequest;
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property(strong,nonatomic)ASIFormDataRequest *dataRequest;
- (IBAction)SearchAction:(id)sender;
@property(strong,nonatomic)NSMutableArray *feedVCArray;
@property(strong,nonatomic)NSMutableDictionary *catVCDictionary;
- (IBAction)UploadNewAction:(id)sender;
- (void)ImageTapped:(UITapGestureRecognizer*)gesture;

@property(strong,nonatomic)MBProgressHUD *HUD;

@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *keys_id;

@property(nonatomic,strong)ASIFormDataRequest *Deleterequest;
@end
