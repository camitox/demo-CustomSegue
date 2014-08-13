//
//  FKModalSegue.m
//  CustomSegue
//
//  Created by Camilo Vera Bezmalinovic on 5/20/14.
//  Copyright (c) 2014 Skout Inc. All rights reserved.
//

#import "FKModalSegue.h"

@interface FKModalSegue ()
@property (nonatomic) CGFloat animationDuration;
@end

@implementation FKModalSegue
- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self)
    {
        _animationDuration = 3;
    }
    return self;
}


-(void)perform
{
    UIViewController *backVC  = _unwind ? self.destinationViewController : self.sourceViewController;
    UIViewController *frontVC = _unwind ? self.sourceViewController      : self.destinationViewController;
    UIView *snapshotBack      = [backVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *snapshotFront     = [frontVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *main              = [self.sourceViewController view];
    UIView *blackView         = [[UIView alloc] initWithFrame:main.bounds];
    blackView.backgroundColor = [UIColor blackColor];

    
    [main      addSubview:blackView];
    [blackView addSubview:snapshotBack];
    [blackView addSubview:snapshotFront];
    
    {
        CGFloat height = CGRectGetHeight(main.bounds);
        
        CABasicAnimation *animationScale     = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animationScale.fromValue             = _unwind ? @(0.9) : @(1.0);
        animationScale.toValue               = _unwind ? @(1.0) : @(0.9);
        animationScale.duration              = _animationDuration;
        animationScale.fillMode              = kCAFillModeBoth;
        animationScale.removedOnCompletion   = NO;
        
        CABasicAnimation *animationTranslation     = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        animationTranslation.fromValue             = _unwind ? @(0)      : @(height);
        animationTranslation.toValue               = _unwind ? @(height) : @(0);
        animationTranslation.duration              = _animationDuration;
        animationTranslation.fillMode              = kCAFillModeBoth;
        animationTranslation.removedOnCompletion   = NO;
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            
            if (_unwind)
            {
                [frontVC dismissViewControllerAnimated:NO completion:nil];
            }
            else
            {
                [backVC presentViewController:frontVC animated:NO completion:nil];

            }
            [blackView removeFromSuperview];

        }];
        
        [snapshotBack.layer  addAnimation:animationScale       forKey:@"scale"];
        [snapshotFront.layer addAnimation:animationTranslation forKey:@"translation"];
        [CATransaction commit];
    }

}

@end
