//
//  UserKeysCell.m
//  KeyIdManager
//
//  Created by design_offshore on 5/18/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "UserKeysCell.h"

@implementation UserKeysCell
@synthesize dateLabel,titleLabel,keyimage;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
