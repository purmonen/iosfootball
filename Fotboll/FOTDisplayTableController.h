//
//  FOTDisplayTableController.h
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-03.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FOTDataManager.h"
#import "FOTTeamCell.h"

@interface FOTDisplayTableController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property NSInteger year;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property NSInteger selectedIndex;

@end
