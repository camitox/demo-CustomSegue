//
//  ViewController.m
//  CustomSegue
//
//  Created by Camilo Vera Bezmalinovic on 5/20/14.
//  Copyright (c) 2014 Skout Inc. All rights reserved.
//

#import "ViewController.h"
#import "FKModalSegue.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)unwindToViewControllerFromSecond:(UIStoryboardSegue *)segue
{
    
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier
{
    FKModalSegue *segue = [[FKModalSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    segue.unwind = YES;
    
    return segue;
}
@end
