//
//  FOTForumController.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-14.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTForumController.h"

@interface FOTForumController ()

@property (weak, nonatomic) IBOutlet UITextView *forumTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation FOTForumController

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
    
    UIImage *image = [UIImage imageNamed:self.team.normalizedName];
    CGSize newSize = CGSizeMake(768, 70);
    CGSize backgroundSize = CGSizeMake(130, 45);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(170, 10, backgroundSize.width, backgroundSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:newImage forBarMetrics:UIBarMetricsDefault];
    
    [self updateForum];
    //self.title = self.team.name;
    self.activityIndicator.hidesWhenStopped = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)updateButtonClicked:(UIButton *)sender {
    [self updateForum];
}

- (void)updateForum {
    [self.activityIndicator startAnimating];
    [[FOTDataManager instance] loadForum:self.team.normalizedName callback:^(NSArray *messages) {
        NSMutableString *forum = [[NSMutableString alloc] init];
        for (NSDictionary *message in messages) {
            NSString *messageString = [NSString stringWithFormat:@"Name: %@\n%@\n\n", [message objectForKey:@"name" ], [message objectForKey:@"content"]];
            [forum appendString:messageString];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.forumTextView.text = forum;
            [self.forumTextView setFont:[UIFont fontWithName:@"arial" size:16]];
            [self.activityIndicator stopAnimating];
        }];
    }];
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
