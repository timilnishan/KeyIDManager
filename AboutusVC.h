//
//  AboutusVC.h
//  KeyIdManager
//
//  Created by design_offshore on 3/31/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightSettingVC.h"
#import "PPRevealSideViewController.h"//;
#import "RightViewController.h"
#import "RightSettingVC.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"

@interface AboutusVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *DescriptionLabel;
@property(weak,nonatomic)ASIFormDataRequest *aboutUsRequest;
@property (weak, nonatomic) IBOutlet UITextView *MyTextView;

@end
