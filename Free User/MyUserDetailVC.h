//
//  MyUserDetailVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/20/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "EditUserVC.h"

@interface MyUserDetailVC : UIViewController<UIAlertViewDelegate>
@property(strong,nonatomic)NSString *full_name;
@property(strong,nonatomic)NSString *total_img;
@property(strong,nonatomic)NSString *date;
@property(strong,nonatomic)NSString *location;
- (IBAction)DeleteUserAction:(id)sender;
@property(strong,nonatomic)NSString *key_id;
- (IBAction)EditUserAction:(id)sender;
@property(strong,nonatomic)NSString *user_id;
@property(strong,nonatomic)NSString *id_;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ByWhoLevel;
@property (weak, nonatomic) IBOutlet UILabel *FullNameLebel;
@property (weak, nonatomic) IBOutlet UILabel *TotalImgLevel;

@end
