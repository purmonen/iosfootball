//
//  FOTDisplayTableController.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-03.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTDisplayTableController.h"
#import "FOTForumController.h"

@interface FOTDisplayTableController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *teams;

@end

@implementation FOTDisplayTableController

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
    //self.year = 2014;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSLog(@"%ld", (long)[self.childViewControllers count]);
    [self.segmentedControl addTarget:self action:@selector(changeTable) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = self.selectedIndex;
    [super viewDidLoad];
    [self changeTable];
    self.activityIndicator.hidesWhenStopped = YES;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (NSString *)getDivision {
    return self.segmentedControl.selectedSegmentIndex ? @"superettan" : @"allsvenskan";
}

- (void)changeTable {
    self.selectedIndex = self.segmentedControl.selectedSegmentIndex;
    [self setTable:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTable:(BOOL)update {
    self.yearLabel.text = [NSString stringWithFormat:@"%ld", (long)self.year];
    [self.activityIndicator startAnimating];

    [[FOTDataManager instance] loadTeamsForDivision:[self getDivision] year:self.year update:update callback:^(NSArray *teams) {
        self.teams = teams;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.activityIndicator stopAnimating];
            [self.tableView reloadData];
        }];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FOTForumTableController *dv = (FOTForumTableController *)[segue destinationViewController];
    dv.team = (FOTTeam *)[self.teams objectAtIndex:[self.tableView indexPathForSelectedRow].row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FOTTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamCell"];
    FOTTeam *team = [self.teams objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld. %@", (long)indexPath.row + 1, team.name];
    cell.gamesPlayedLabel.text = [NSString stringWithFormat:@"%ld", (long)team.gamesPlayed];
    cell.goalDifference.text = [NSString stringWithFormat:@"%ld", (long)team.goalDifference];
    cell.pointsLabel.text = [NSString stringWithFormat:@"%ld", (long)team.points];
    cell.teamImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", team.normalizedName]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teams count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (IBAction)updateTeams:(id)sender {
    [self setTable:YES];
}

@end
