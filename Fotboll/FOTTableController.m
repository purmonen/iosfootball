//
//  FOTViewController.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-02.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTTableController.h"

@interface FOTTableController ()

@property NSArray *teams;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@end

@implementation FOTTableController

- (void)viewDidLoad
{
    self.year = 2014;
    self.stepper.value = self.year;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)setTable:(NSString *)division year:(NSInteger)year update:(BOOL)update callback:(void(^)(void))callback {
    [FOTDataManager loadTeamsForDivision:division year:year update:update callback:^(NSArray *teams) {
        self.teams = teams;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
            callback();
        }];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FOTTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamCell"];
    FOTTeam *team = [self.teams objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld. %@", (long)indexPath.row + 1, team.name];
    cell.gamesPlayedLabel.text = [NSString stringWithFormat:@"%ld", (long)team.gamesPlayed];
    cell.goalDifference.text = [NSString stringWithFormat:@"%ld", (long)team.goalDifference];
    cell.pointsLabel.text = [NSString stringWithFormat:@"%ld", (long)team.points];
    cell.teamImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", team.id]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teams count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
