//
//  FOTTableItem.h
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-02.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FOTTeam : NSObject

@property NSString *name;
@property NSInteger gamesPlayed;
@property NSInteger wins;
@property NSInteger losses;
@property NSInteger ties;
@property NSInteger goalsPlus;
@property NSInteger goalsMinus;
@property NSInteger goalDifference;
@property NSInteger points;
@property NSString *id;

+ (FOTTeam *)fromJson:(id)json;
- (id)toJson;

@end
