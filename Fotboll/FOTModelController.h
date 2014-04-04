//
//  FOTModelController.h
//  Fotboll
//
//  Created by Sami Purmonen on 2014-04-04.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FOTDisplayTableController.h"

@interface FOTModelController : UIViewController<UIPageViewControllerDataSource>

- (FOTDisplayTableController *)viewControllerForYear:(NSUInteger)year storyboard:(UIStoryboard *)storyboard;

@end
