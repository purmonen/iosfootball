//
//  FOTImageTeamCell.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-30.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTImageTeamCell.h"

@implementation FOTImageTeamCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
