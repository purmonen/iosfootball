//
//  FOTForumCell.h
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-21.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FOTForumCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
