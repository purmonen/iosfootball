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
    NSLog(@"Did load");
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBar.translucent = NO;
    [[FOTDataManager instance] loadForum:self.team.normalizedName callback:^(NSArray *forum) {
        self.forum = forum;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
    [self setImage];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Will appear");

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



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
