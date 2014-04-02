//
//  FOTDataManager.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-02.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTDataManager.h"

@implementation FOTDataManager

+ (void)getTable:(NSString *)division callback:(void(^)(NSArray *))callback {
    NSString *url = [NSString stringWithFormat:@"http://54.203.255.93:8000/table/%@", division];
    [MSLHttp getAsyncJson:url completionHandler:^(NSArray *json) {
        NSMutableArray *teams = [NSMutableArray array];
        for (NSDictionary *team in json) {
            FOTTeam *item = [[FOTTeam alloc] init];
            item.name = (NSString *)[team objectForKey:@"name"];
            item.gamesPlayed = [[team objectForKey:@"gamesPlayed"] integerValue];
            item.wins = [[team objectForKey:@"wins"] integerValue];
            item.losses = [[team objectForKey:@"losses"] integerValue];
            item.ties = [[team objectForKey:@"ties"] integerValue];
            item.goalsPlus = [[team objectForKey:@"goalsPlus"] integerValue];
            item.goalsMinus = [[team objectForKey:@"goalsMinus"] integerValue];
            item.goalDifference = [[team objectForKey:@"goalDifference"] integerValue];
            item.points = [[team objectForKey:@"points"] integerValue];
            item.id = (NSString *)[team objectForKey:@"id"];
            [teams addObject:item];
        }
        callback(teams);
    }];
}

@end
