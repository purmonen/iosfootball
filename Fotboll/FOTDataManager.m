//
//  FOTDataManager.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-02.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTDataManager.h"

@implementation FOTDataManager

+ (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

+ (NSString *)fileNameForDivision:(NSString *)division year:(NSInteger)year  {
    return [NSString stringWithFormat:@"%@%ld.json", division, (long)year];
}
/*
+ (NSArray *)loadTeamsForDivision:(NSString *)division year:(NSInteger)year {
    NSString *path = [[FOTDataManager applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:[FOTDataManager fileNameForDivision:division year:year]];
    [path fi]
     
}
 */

+ (void)readFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                   NSUserDomainMask, YES);
    NSString *documentDirectory = dirPaths[0];
    NSString *fileName = [NSString stringWithFormat:@"%@/apa", documentDirectory];
    BOOL fileExists = [fileManager fileExistsAtPath:fileName];
    NSData *data = [@"banan" dataUsingEncoding:NSUTF8StringEncoding];
    if (!fileExists) {
        [fileManager createFileAtPath:fileName contents:data attributes:nil];
        NSLog(@"CREATING FILE");
    } else {
        NSLog(@"ALREADY HAVE DATA");
        NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:fileName];
        [file writeData:[NSData dataWithData:data]];
    }
    NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:fileName];
    NSString *content = [[NSString alloc] initWithData:[file readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    NSLog(@"%@\n", content);
}

+ (void)loadTeamsForDivision:(NSString *)division year:(NSInteger)year callback:(void(^)(NSArray *))callback {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@%ld.json", documentDirectory, division, (long)year];
    NSLog(@"%@\n", filePath);
    if ([fileManager fileExistsAtPath:filePath]) {
        NSLog(@"File exist!\n");
        NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:filePath];
        NSArray *json = [NSJSONSerialization JSONObjectWithData:[file readDataToEndOfFile] options:0 error:nil];
        NSArray *teams = [FOTDataManager teamsFromJson:json];
        callback(teams);
    } else {
        [FOTDataManager getTeamsForDivision:division year:year callback:^(NSArray *json) {
            NSLog(@"Json: %@\n", json);
            [fileManager createFileAtPath:filePath contents:[NSJSONSerialization dataWithJSONObject:json options:0 error:nil] attributes:nil];
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
