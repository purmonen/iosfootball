//
//  FOTForumTableController.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-21.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTForumTableController.h"

@interface FOTForumTableController ()

@property NSArray *forum;

@property (nonatomic, strong) FOTForumCell *prototypeCell;

@end
static NSString *cellIdentifier = @"forumCell";

@implementation FOTForumTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Did load");
    self.navigationController.navigationBar.translucent = NO;

    [self setImage];
    [self loadForum];
}

- (IBAction)refreshButtonClicked:(UIBarButtonItem *)sender {
    [self loadForum];
}

- (void)loadForum {
    [[FOTDataManager instance] loadForum:self.team.normalizedName callback:^(NSArray *forum) {
        self.forum = forum;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
}

- (void)setImage {
    UIImage *image = [UIImage imageNamed:self.team.normalizedName];
    CGSize newSize = CGSizeMake(768, 70);
    CGSize backgroundSize = CGSizeMake(130, 45);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(170, 10, backgroundSize.width, backgroundSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:newImage forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.forum.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FOTForumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(FOTForumCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FOTForumPost *post = [self.forum objectAtIndex:indexPath.row];
    cell.nameLabel.text = post.name;
    cell.contentLabel.text = post.content;
    cell.contentLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cell.dateLabel.text = post.date;

}

- (FOTForumCell *)prototypeCell
{
    if (!_prototypeCell) _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return _prototypeCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    [self.prototypeCell layoutIfNeeded];
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

@end
