//
//  FOTDataManager.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-02.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTDataManager.h"


#define HOST @"192.168.1.86"
//#define HOST @"localhost"
// #define HOST @"54.203.255.93" // Micro instance
//define HOST @"54.72.222.76" // Medium instance
#define PORT @"8000"

@interface FOTDataManager ()

@end

@implementation FOTDataManager

static FOTDataManager *instance = nil;

+ (FOTDataManager *)instance {
    if (!instance) instance = [[FOTDataManager alloc] init];
    return instance;
}

- (NSString *)fileNameForDivision:(NSString *)division year:(NSInteger)year  {
    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [NSString stringWithFormat:@"%@/%@%ld.json", documentDirectory, division, (long)year];
}

- (void)loadTeamsForDivision:(NSString *)division year:(NSInteger)year update:(BOOL)update callback:(void(^)(NSArray *))callback {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [self fileNameForDivision:division year:year];
    if ([fileManager fileExistsAtPath:filePath] && !update) {
        NSLog(@"File exist!\n");
        
        NSArray *json = [NSArray arrayWithContentsOfFile:filePath];
        NSArray *teams = [self teamsFromJson:json];
        callback(teams);
    } else {
        [self getTeamsForDivision:division year:year callback:^(NSArray *json) {
            NSLog(@"GOING REMOTE\n");
            [json writeToFile:filePath atomically:YES];
            NSArray *teams = [self teamsFromJson:json];
            callback(teams);
        }];
    }
}

- (NSArray *)teamsFromJson:(NSArray *)json {
    NSMutableArray *teams = [[NSMutableArray alloc] init];
    for (NSDictionary *team in json) {
        [teams addObject:[FOTTeam fromJson:team]];
    }
    return teams;
}

- (void)getTeamsForDivision:(NSString *)division year:(NSInteger)year callback:(void(^)(NSArray *))callback {
    NSString *url = [NSString stringWithFormat:@"http://%@:%@/table/%@/%ld", HOST, PORT, division, (long)year];
    [MSLHttp getAsyncJson:url completionHandler:^(NSArray *json) {
        if (!json) {
            return;
        }
        callback(json);
    }];
}

- (void)loadForum:(NSString *)team callback:(void(^)(NSArray *))callback {
    NSString *url = [NSString stringWithFormat:@"http://%@:%@/forum/%@", HOST, PORT, team];
    [MSLHttp getAsyncJson:url completionHandler:^(NSArray *json) {
        if (!json) {
            return;
        }
        NSMutableArray *forum = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in json) {
            FOTForumPost *post = [[FOTForumPost alloc] init];
            post.name = [dict objectForKey:@"name"];
            post.content = [dict objectForKey:@"content"];
            post.date = [dict objectForKey:@"date"];
            [forum addObject:post];
        }
        callback(forum);
    }];
}

- (void)loadLiveScore:(void(^)(NSArray *))callback {
    [MSLHttp getAsyncJson:[NSString stringWithFormat:@"http://%@:%@/liveScore", HOST, PORT] completionHandler:^(NSArray *json) {
        NSMutableArray *games = [[NSMutableArray alloc] init];
        for (NSDictionary *jsonGame in json) {
            FOTGame *game = [[FOTGame alloc] init];
            game.status = [jsonGame objectForKey:@"status"];
            game.startTime = [[jsonGame objectForKey:@"startTime"] substringToIndex:5];
            
            NSDictionary *homeTeam = [jsonGame objectForKey:@"homeTeam"];
            NSDictionary *awayTeam = [jsonGame objectForKey:@"awayTeam"];
            
            game.homeTeam = [homeTeam objectForKey:@"name"];
            game.awayTeam = [awayTeam objectForKey:@"name"];

            game.homeScore = [homeTeam objectForKey:@"score"];
            game.awayScore = [awayTeam objectForKey:@"score"];
            [games addObject:game];
        }
        NSLog(@"Games: %@", games);
        callback(games);
    }];

}

@end
