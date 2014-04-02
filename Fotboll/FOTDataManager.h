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

@interface FOTDataManager : NSObject

+ (void)getAllsvenskan:(void(^)(NSArray *))callback;

@end
