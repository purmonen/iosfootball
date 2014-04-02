//
//  MSLHttp.m
//  MSLTrackApi
//
//  Created by Sami Purmonen on 2014-03-29.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "MSLHttp.h"

@implementation MSLHttp
+ (void)getAsyncJson:( NSString *)urlString completionHandler:(void (^)(id))completionHandler {
    [MSLHttp asyncJson:urlString data:nil completionHandler:completionHandler];
}

+ (void)postAsyncJson:( NSString *)urlString data:(NSData *)data completionHandler:(void (^)(id))completionHandler {
    [MSLHttp asyncJson:urlString data:data completionHandler:completionHandler];
}

+ (void)asyncJson:( NSString *)urlString data:(NSData *)data completionHandler:(void (^)(id))completionHandler {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    if (data != nil) {
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
    }
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            completionHandler(nil);
        } else {
        	id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&connectionError];
        	completionHandler(json);
        }
    }];
}

@end
