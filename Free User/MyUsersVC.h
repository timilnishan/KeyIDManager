//
//  MyUsersVC.h
//  KeyIdManager
//
//  Created by design_offshore on 5/20/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "serverURL.h"
#import "PPRevealSideViewController.h"//;
#import "UserKeysCell.h"
#import "UserLisitingModel.h"
#import "UIImageView+WebCache.h"
#import "MyUserDetailVC.h"
#import "ListuserCell.h"

@interface MyUsersVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property(nonatomic,strong)NSMutableArray *feedVCArray;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)ASIFormDataRequest *dataRequest;
@property(strong,nonatomic)NSMutableDictionary *catVCDictionary;

@end
