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
@property NSString *normalizedName;
@property NSString *shortName;
@property NSInteger gamesPlayed;
@property NSInteger wins;
@property NSInteger losses;
@property NSInteger ties;
@property NSInteger goalPlus;
@property NSInteger goalMinus;
@property NSInteger goalDifference;
@property NSInteger points;
@property NSString *id;

+ (FOTTeam *)fromJson:(id)json;
- (id)toJson;

@end
