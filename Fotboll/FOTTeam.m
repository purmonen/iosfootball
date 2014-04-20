//
//  FOTTableItem.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-02.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTTeam.h"

@implementation FOTTeam

+ (FOTTeam *)fromJson:(id)json {
    FOTTeam *team = [[FOTTeam alloc] init];
    team.name = (NSString *)[json objectForKey:@"name"];
    team.normalizedName = (NSString *)[json objectForKey:@"normalizedName"];
    team.gamesPlayed = [[json objectForKey:@"gamesPlayed"] integerValue];
    team.wins = [[json objectForKey:@"wins"] integerValue];
    team.losses = [[json objectForKey:@"losses"] integerValue];
    team.ties = [[json objectForKey:@"ties"] integerValue];
    team.goalPlus = [[json objectForKey:@"goalPlus"] integerValue];
    team.goalMinus = [[json objectForKey:@"goalMinus"] integerValue];
    team.goalDifference = [[json objectForKey:@"goalDifference"] integerValue];
    team.points = [[json objectForKey:@"points"] integerValue];
    team.id = (NSString *)[json objectForKey:@"id"];
    return team;
}

- (id)toJson {
    NSDictionary *json = @{@"name": self.name,
                           @"normalizedName": self.normalizedName,
                           @"gamesPlayed": [NSNumber numberWithInteger:self.gamesPlayed],
                           @"wins": [NSNumber numberWithInteger:self.wins],
                           @"losses": [NSNumber numberWithInteger:self.losses],
                           @"ties": [NSNumber numberWithInteger:self.ties],
                           @"goalPlus": [NSNumber numberWithInteger:self.goalPlus],
                           @"goalMinus": [NSNumber numberWithInteger:self.goalMinus],
                           @"goalDifference": [NSNumber numberWithInteger:self.goalDifference],
                           @"points": [NSNumber numberWithInteger:self.points],
                           @"id": self.id};
    return json;
}

@end
