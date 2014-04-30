//
//  FOTImageTeamCell.h
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-30.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FOTImageTeamCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *gamesPlayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *winsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *lossesLabel;

@property (weak, nonatomic) IBOutlet UILabel *goalDifference;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamImage;

@end
