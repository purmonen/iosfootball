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
    NSLog(@"%ld", (long)[self.childViewControllers count]);
    [self.segmentedControl addTarget:self action:@selector(changeTable) forControlEvents:UIControlEventValueChanged];
    [super viewDidLoad];
    self.tableController = [self.childViewControllers firstObject];
    [self changeTable];
    // Do any additional setup after loading the view.
}

- (void)changeTable {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self.tableController setTable:@"allsvenskan"];
    } else {
        [self.tableController setTable:@"superettan"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
