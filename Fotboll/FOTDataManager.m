//
//  FOTDataManager.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-02.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTDataManager.h"

@interface FOTDataManager ()

@end

@implementation FOTDataManager

+ (NSString *)fileNameForDivision:(NSString *)division year:(NSInteger)year  {
    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [NSString stringWithFormat:@"%@/%@%ld.json", documentDirectory, division, (long)year];
}

+ (void)loadTeamsForDivision:(NSString *)division year:(NSInteger)year update:(BOOL)update callback:(void(^)(NSArray *))callback {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [FOTDataManager fileNameForDivision:division year:year];
    if ([fileManager fileExistsAtPath:filePath] && !update) {
        NSLog(@"File exist!\n");
        NSArray *json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:nil];
        NSArray *teams = [FOTDataManager teamsFromJson:json];
        callback(teams);
    } else {
        [FOTDataManager getTeamsForDivision:division year:year callback:^(NSArray *json) {
            NSLog(@"Json: %@\n", json);
            [[NSJSONSerialization dataWithJSONObject:json options:0 error:nil] writeToFile:filePath atomically:YES];
            NSArray *teams = [FOTDataManager teamsFromJson:json];
            callback(teams);
        }];
    }
}

+ (NSArray *)teamsFromJson:(NSArray *)json {
    NSMutableArray *teams = [[NSMutableArray alloc] init];
    for (NSDictionary *team in json) {
        [teams addObject:[FOTTeam fromJson:team]];
    }
    return teams;
}

+ (void)getTeamsForDivision:(NSString *)division year:(NSInteger)year callback:(void(^)(NSArray *))callback {
    NSString *url = [NSString stringWithFormat:@"http://192.168.1.86:8000/table/%@/%ld", division, (long)year];
    [MSLHttp getAsyncJson:url completionHandler:^(NSArray *json) {
        if (!json) {
            return;
        }
        callback(json);
    }];
}

@end
