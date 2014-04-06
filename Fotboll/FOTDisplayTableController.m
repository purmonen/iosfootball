//
//  FOTDisplayTableController.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-03.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTDisplayTableController.h"

@interface FOTDisplayTableController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property FOTTableController *tableController;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

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
    NSLog(@"%ld", (long)[self.childViewControllers count]);
    [self.segmentedControl addTarget:self action:@selector(changeTable) forControlEvents:UIControlEventValueChanged];
    [super viewDidLoad];
    self.tableController = [self.childViewControllers firstObject];
    [self changeTable];
    self.activityIndicator.hidesWhenStopped = YES;
    // Do any additional setup after loading the view.
}

- (NSString *)getDivision {
    return self.segmentedControl.selectedSegmentIndex ? @"superettan" : @"allsvenskan";
}

- (void)changeTable {
    [self setTable:NO];
}

- (void)setTable:(BOOL)update {
    self.yearLabel.text = [NSString stringWithFormat:@"%ld", (long)self.year];
    
    [self.activityIndicator startAnimating];
    UIActivityIndicatorView *indicator = self.activityIndicator;
    [self.tableController setTable:[self getDivision] year:self.year update:update callback:^{
        [indicator stopAnimating];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)yearChanged:(UIStepper *)sender {
    self.year = sender.value;
    [self changeTable];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)updateTeams:(id)sender {
    [self setTable:YES];
}

@end
