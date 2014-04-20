//
//  FOTLiveScoreManager.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-20.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTLiveScoreManager.h"

@interface FOTLiveScoreManager()

@property NSMutableArray *teams;
@property NSMutableArray *teamGames;
@property NSTimer *updateTimer;
@property BOOL isRunning;
@property NSXMLParser *xmlParser;

@end


static FOTLiveScoreManager *instance;

@implementation FOTLiveScoreManager


+ (FOTLiveScoreManager *)instance {
    if (!instance) {
        instance = [[FOTLiveScoreManager alloc] init];
        instance.teams = [[NSMutableArray alloc] init];
        instance.games = [[NSMutableArray alloc] init];
        instance.teamGames = [[NSMutableArray alloc] init];
    }
    return instance;
}

- (void)start {
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(loadLiveScore) userInfo:nil repeats:YES];
    [self.updateTimer fire];
}

- (void)stop {
    [self.updateTimer invalidate];
}

- (void)loadLiveScore {
    NSLog(@"LOADING SCORE");
    if (self.xmlParser) return;
    NSString *url = @"http://svenskfotboll.se/xml.ashx?f=current_games.xml";
    self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    self.xmlParser.delegate = self;
    [self.xmlParser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.teams = [[NSMutableArray alloc] init];
    NSLog(@"STARTED XML\n");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"team"]) {
        [self.teams addObject:attributeDict];
    }
    if ([elementName isEqualToString:@"game"]) {
        [self.teamGames addObject:attributeDict];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"FINISHED XML\n");
    NSMutableArray *games = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.teams.count; i+=2) {
        NSDictionary *homeTeam = [self.teams objectAtIndex:i];
        NSDictionary *awayTeam = [self.teams objectAtIndex:i+1];
        NSDictionary *teamGame = [self.teamGames objectAtIndex:i/2];
        
        FOTGame *game = [[FOTGame alloc] init];
        game.status = [teamGame objectForKey:@"status"];
        game.scheduleTime = [teamGame objectForKey:@"schedule-time"];
        game.scheduleTime = [game.scheduleTime substringToIndex:[game.scheduleTime length] - 3];
        game.homeTeam = [homeTeam objectForKey:@"name"];
        game.awayTeam = [awayTeam objectForKey:@"name"];
        game.homeScore = [homeTeam objectForKey:@"score"];
        game.awayScore = [awayTeam objectForKey:@"score"];
        [games addObject:game];
    }
    
    self.games = games;
    NSLog(@"GAMES: %@", self.games);
    self.xmlParser = nil;
}

@end
