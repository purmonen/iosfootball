//
//  FOTDataManager.h
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-02.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSLHttp.h"
#import "FOTTeam.h"
#import "FOTForumPost.h"
#import "FOTGame.h"

@interface FOTDataManager : NSObject

- (void)loadTeamsForDivision:(NSString *)division year:(NSInteger)year update:(BOOL)update callback:(void(^)(NSArray *))callback;

- (void)loadForum:(NSString *)team callback:(void(^)(NSArray *))callback;

- (void)loadLiveScore:(void(^)(NSArray *))callback;
+ (FOTDataManager *)instance;
- (void)registerDevice:(NSData *)deviceId;

@property NSArray *liveScore;

@end