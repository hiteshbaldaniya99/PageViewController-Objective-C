//
//  ContainerViewController.m
//  PageViewController
//
//  Created by Imanou on 20/09/2017.
//  Copyright © 2017 Imanou. All rights reserved.
//

#import "ContainerViewController.h"
#import "ViewController.h"

@interface ContainerViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@end

@implementation ContainerViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.array = @[
                       @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                       @"Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                       @"Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                       @"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                       ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor redColor]];
    [self.view bringSubviewToFront:self.pageControl];
    
    self.pageControl.numberOfPages = self.array.count;
    self.pageControl.currentPage = 0;
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [self.pageControl setPageIndicatorTintColor:[UIColor grayColor]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*
     Set pageViewController transition style to `scroll` in Storyboard
     */
    self.pageViewController = (UIPageViewController *)segue.destinationViewController;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    ViewController *initialViewController = [self viewControllerWithPageIndex:0];
    [self.pageViewController setViewControllers:@[initialViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark - Custom methods

- (ViewController *)viewControllerWithPageIndex:(NSInteger)pageIndex {
    if (pageIndex < 0 || pageIndex >= [self.array count]) {
        return nil;
    }
    ViewController *viewController = [[ViewController alloc] init];
    viewController.text = self.array[pageIndex];
    viewController.pageIndex = pageIndex;
    
    return viewController;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    ViewController *vc = (ViewController *)viewController;
    NSUInteger index = vc.pageIndex;
    return [self viewControllerWithPageIndex:(index + 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    ViewController *vc = (ViewController *)viewController;
    NSUInteger index = vc.pageIndex;
    return [self viewControllerWithPageIndex:(index - 1)];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        ViewController *vc = pageViewController.viewControllers.lastObject;
        self.pageControl.currentPage = vc.pageIndex;
    }
}

#pragma mark - User interaction

- (IBAction)changePage:(id)sender {
    UIPageControl *pageControl = sender;
    ViewController *newViewController = [self viewControllerWithPageIndex:pageControl.currentPage];
    ViewController *oldViewController = self.pageViewController.viewControllers.lastObject;
    UIPageViewControllerNavigationDirection direction = newViewController.pageIndex > oldViewController.pageIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    [self.pageViewController setViewControllers:@[newViewController] direction:direction animated:YES completion:nil];
}

@end
