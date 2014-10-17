//
//  LogsCell.h
//  KeyIdManager
//
//  Created by design_offshore on 6/9/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *compare;
@property (weak, nonatomic) IBOutlet UILabel *checkinstatus;
@property (weak, nonatomic) IBOutlet UILabel *Status;

@end
