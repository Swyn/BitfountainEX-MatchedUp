//
//  AAMatchViewController.h
//  MatchedUp
//
//  Created by Alexandre ARRIGHI on 25/07/2014.
//  Copyright (c) 2014 Alexandre ARRIGHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AAMatchViewControllerDelegate <NSObject>

-(void)presentMatchesViewController;

@end

@interface AAMatchViewController : UIViewController

@property (strong, nonatomic) UIImage *matchedUserImage;
@property (weak) id <AAMatchViewControllerDelegate> delegate;


@end
