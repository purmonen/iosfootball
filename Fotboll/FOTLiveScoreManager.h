//
//  FOTLiveScoreManager.h
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-20.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSLHttp.h"
#import "FOTTeam.h"
#import "FOTGame.h"

@interface FOTLiveScoreManager : NSObject<NSXMLParserDelegate>

@property NSMutableArray *games;
- (void)loadLiveScore;
+ (FOTLiveScoreManager *)instance;
- (void)start;
-( void)stop;
@end
