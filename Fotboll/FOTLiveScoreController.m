//
//  FOTLiveScoreController.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-14.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTLiveScoreController.h"

@interface FOTLiveScoreController ()

@property NSArray *games;

@end

@implementation FOTLiveScoreController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[FOTDataManager instance] loadLiveScore:^(NSArray *games) {
        self.games = games;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
}


- (void)viewDidDisappear:(BOOL)animated {
    [[FOTDataManager instance] removeObserver:self forKeyPath:@"liveScore" context:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [[FOTDataManager instance] addObserver:self forKeyPath:@"liveScore" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    self.games = [FOTDataManager instance].liveScore;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FOTGameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gameCell"];
    FOTGame *game = [self.games objectAtIndex:indexPath.row];
    cell.homeTeamLabel.text = game.homeTeam;
    cell.awayTeamLabel.text = game.awayTeam;
    cell.homeTeamScore.text = game.homeScore;
    cell.awayTeamScore.text = game.awayScore;
    cell.homeTeamImage.image = [UIImage imageNamed:[self normalizeTeamName:game.homeTeam]];
    cell.awayTeamImage.image = [UIImage imageNamed:[self normalizeTeamName:game.awayTeam]];
    cell.statusLabel.text = [NSString stringWithFormat:@"%@, %@", game.date, game.status];

    //cell.textLabel.font = [UIFont fontWithName:@"verdana" size:10];
    return cell;
}

- (NSString *)normalizeTeamName:(NSString *)name {
    NSRegularExpression *noixes = [NSRegularExpression regularExpressionWithPattern:@"\\b(ifk|ik|fk|sk|fc|bois|ff|if|aif|bk|gif|is)\\b" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRegularExpression *noweird = [NSRegularExpression regularExpressionWithPattern:@"\\s|å|ä|ö" options:NSRegularExpressionCaseInsensitive error:nil];

    NSString *stringnoixes = [noixes stringByReplacingMatchesInString:name options:0 range:NSMakeRange(0, [name length]) withTemplate:@""];
    
    NSString *stringnoweird = [noweird stringByReplacingMatchesInString:stringnoixes options:0 range:NSMakeRange(0, [stringnoixes length]) withTemplate:@""];
    
    NSString *lower = [stringnoweird lowercaseString];
    if ([lower hasSuffix:@"s"]) {
        lower = [lower substringToIndex:[lower length]-1];
    }
    return lower;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.games count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



@end
