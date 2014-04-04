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
    team.gamesPlayed = [[json objectForKey:@"gamesPlayed"] integerValue];
    team.wins = [[json objectForKey:@"wins"] integerValue];
    team.losses = [[json objectForKey:@"losses"] integerValue];
    team.ties = [[json objectForKey:@"ties"] integerValue];
    team.goalsPlus = [[json objectForKey:@"goalsPlus"] integerValue];
    team.goalsMinus = [[json objectForKey:@"goalsMinus"] integerValue];
    team.goalDifference = [[json objectForKey:@"goalDifference"] integerValue];
    team.points = [[json objectForKey:@"points"] integerValue];
    team.id = (NSString *)[json objectForKey:@"id"];
    return team;
}

- (id)toJson {
    NSDictionary *json = @{@"name": self.name,
                           @"gamesPlayed": [NSNumber numberWithInteger:self.gamesPlayed],
                           @"wins": [NSNumber numberWithInteger:self.wins],
                           @"losses": [NSNumber numberWithInteger:self.losses],
                           @"ties": [NSNumber numberWithInteger:self.ties],
                           @"goalsPlus": [NSNumber numberWithInteger:self.goalsPlus],
                           @"goalsMinus": [NSNumber numberWithInteger:self.goalsMinus],
                           @"goalDifference": [NSNumber numberWithInteger:self.goalDifference],
                           @"points": [NSNumber numberWithInteger:self.points],
                           @"id": self.id};
    return json;
}

@end
