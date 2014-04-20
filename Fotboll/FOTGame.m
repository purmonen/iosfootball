//
//  FOTGame.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-20.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTGame.h"

@implementation FOTGame

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ - %@ %@", self.homeTeam, self.homeScore, self.awayScore, self.awayTeam];
}

@end
