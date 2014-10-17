//
//  UserKeysCell.h
//  KeyIdManager
//
//  Created by design_offshore on 5/18/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserKeysCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *myimage;
@property (weak, nonatomic) IBOutlet UIButton *viewButton;
@property (weak, nonatomic) IBOutlet UIButton *CheckOutButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *keyimage;
@property (weak, nonatomic) IBOutlet UIButton *DeleteButton;
@property (weak, nonatomic) IBOutlet UIButton *CheckInButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *EditButton;
@end
