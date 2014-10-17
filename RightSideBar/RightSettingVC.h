//
//  RightSettingVC.h
//  KeyIdManager
//
//  Created by design_offshore on 3/30/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterVC.h"
#import "ContactUSVC.h"
#import "AboutusVC.h"
#import "LoginVC.h"
#import "PPRevealSideViewController.h"

@interface RightSettingVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *menuArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property(nonatomic,strong)UIViewController *loginvc1;
@property(nonatomic,strong)UITabBarController *tabbar;

@end
