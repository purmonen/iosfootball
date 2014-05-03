//
//  FOTDisplayTableController.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-03.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTDisplayTableController.h"

@interface FOTDisplayTableController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *teams;
@property (weak, nonatomic) IBOutlet UIButton *previousYearButton;
@property (weak, nonatomic) IBOutlet UIButton *nextYearButton;
@property (weak, nonatomic) IBOutlet UILabel *currentTableLabel;

@property NSInteger currentYear;

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
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:[NSDate date]];
    self.currentYear = [components year];
    
    self.year = 2014;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSLog(@"%ld", (long)[self.childViewControllers count]);
    [self.segmentedControl addTarget:self action:@selector(changeTable) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = self.selectedIndex;
    [super viewDidLoad];
    [self configureYearButtons];
    self.activityIndicator.hidesWhenStopped = YES;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)configureYearButtons {
    [self.previousYearButton setTitle:[NSString stringWithFormat:@"%ld", self.year-1] forState:UIControlStateNormal];
    [self.nextYearButton setTitle:[NSString stringWithFormat:@"%ld", self.year+1] forState:UIControlStateNormal];
    self.previousYearButton.hidden = self.year == 2001;
    self.nextYearButton.hidden = self.year == 2014;
    self.currentTableLabel.text = [NSString stringWithFormat:@"Tabell %ld", self.year];
    [self setTable:NO];
}

- (IBAction)previousYearButtonClicked:(UIButton *)sender {
    self.year--;
    [self configureYearButtons];
}

- (IBAction)nextYearButtonClicked:(UIButton *)sender {
    self.year++;
    [self configureYearButtons];
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
    [self setTitle:[NSString stringWithFormat:@"Tabell %ld", (long)self.year]];
    [self.activityIndicator startAnimating];
    if (self.year == self.currentYear) {
        update = YES;
    }

    [[FOTDataManager instance] loadTeamsForDivision:[self getDivision] year:self.year update:update callback:^(NSArray *teams) {
        self.teams = teams;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.activityIndicator stopAnimating];
            [self.tableView reloadData];
        }];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[FOTForumTableController class]]) {
        FOTForumTableController *dv = (FOTForumTableController *)[segue destinationViewController];
        dv.team = (FOTTeam *)[self.teams objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FOTTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamCell"];
    FOTTeam *team = [self.teams objectAtIndex:indexPath.row];
    
    UIColor *grey = [UIColor colorWithWhite:0.98 alpha:1];
    if (indexPath.row == 2 || indexPath.row == 13) {
        cell.backgroundColor = grey;
    } else {
        cell.backgroundColor = [UIColor clearColor];

    }
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld. %@", (long)indexPath.row + 1, team.shortName];
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
