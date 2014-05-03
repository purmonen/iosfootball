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

@property NSString *homeScore;
@property NSString *awayScore;

@property NSString *date;

@property NSString *status;


@end
