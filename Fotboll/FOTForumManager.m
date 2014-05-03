//
//  FOTForumManager.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-20.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTForumManager.h"
//#define HOST @"192.168.1.86"
#define HOST @"localhost"
//#define HOST @"54.203.255.93"
#define PORT @"8000"


@implementation FOTForumManager

- (void)loadForum:(NSString *)team callback:(void(^)(NSArray *))callback {
    NSString *url = [NSString stringWithFormat:@"http://%@:%@/forum/%@", HOST, PORT, team];
    [MSLHttp getAsyncJson:url completionHandler:^(NSArray *json) {
        if (!json) {
            return;
        }
        callback(json);
    }];
}

@end
