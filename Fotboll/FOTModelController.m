//
//  FOTModelController.m
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-04.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "FOTModelController.h"

@interface FOTModelController ()

@end

@implementation FOTModelController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // FOTpose of any resources that can be recreated.
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

- (FOTDisplayTableController *)viewControllerForYear:(NSUInteger)year storyboard:(UIStoryboard *)storyboard
{
    // Create a new view controller and pass suitable data.
    FOTDisplayTableController *controller = [storyboard instantiateViewControllerWithIdentifier:@"FOTDisplayTableController"];
    controller.year = year;
    return controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger year = ((FOTDisplayTableController *)viewController).year;
    if (year <= 2001) {
        return nil;
    }
    
    year--;
    return [self viewControllerForYear:year storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger year = ((FOTDisplayTableController *)viewController).year;
    if (year >= 2014) {
        return nil;
    }
    
    year++;
    return [self viewControllerForYear:year storyboard:viewController.storyboard];
}

@end
