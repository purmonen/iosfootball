//
//  FOTGame.h
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-20.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FOTTeam.h"

@interface FOTGame : NSObject

@property NSString *homeTeam;
@property NSString *awayTeam;

@property NSNumber *homeScore;
@property NSNumber *awayScore;

@property NSString *scheduleTime;
@property NSString *startTime;

@property NSString *status;


@end
