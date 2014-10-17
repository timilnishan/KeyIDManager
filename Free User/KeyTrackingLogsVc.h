//
//  KeyTrackingLogsVc.h
//  KeyIdManager
//
//  Created by design_offshore on 6/9/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "LogsCell.h"
#import "KeysLogsDataModel.h"
#import "UIImageView+WebCache.h"


@interface KeyTrackingLogsVc : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSMutableArray *feedVCarray;
@property(nonatomic,strong)ASIFormDataRequest *logsRequest;
@property(nonatomic,strong)NSMutableDictionary *catVCDictionary;
@end
