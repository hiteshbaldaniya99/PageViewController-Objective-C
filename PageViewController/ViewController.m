//
//  IntroViewController.m
//  PageViewController
//
//  Created by Imanou on 19/09/2017.
//  Copyright © 2017 Imanou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textLabel = [[UILabel alloc]init];
    self.textLabel.text = self.text;

    [self.view addSubview:self.textLabel];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textLabel setNumberOfLines:0];
    
    [[self.textLabel.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor] setActive:YES];
    [[self.textLabel.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor] setActive:YES];
    [[self.textLabel.widthAnchor constraintEqualToConstant:300.f] setActive:YES];

    self.textLabel.backgroundColor = [UIColor greenColor];
    self.view.backgroundColor = [UIColor yellowColor];
}

@end
