//
//  FOTViewController.h
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-02.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FOTDataManager.h"
#import "FOTTeamCell.h"

@interface FOTTableController : UITableViewController

- (void)setTable:(NSString *)division year:(NSInteger)year update:(BOOL)update callback:(void(^)(void))callback;
@property NSInteger year;

@end