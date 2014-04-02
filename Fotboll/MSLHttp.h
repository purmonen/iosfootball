//
//  MSLHttp.h
//  MSLTrackApi
//
//  Created by Sami Purmonen on 2014-03-29.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSLHttp : NSObject

+ (void)getAsyncJson:(NSString *)urlString completionHandler:(void (^)(id))completionHandler;
+ (void)postAsyncJson:(NSString *)urlString data:(NSData *)data completionHandler:(void (^)(id))completionHandler;

@end
