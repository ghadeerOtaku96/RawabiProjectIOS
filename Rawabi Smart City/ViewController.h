//
//  ViewController.h
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/12/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "contentViewController.h"
#import "welcomePageViewController.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"
@interface ViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIButton *signInButton;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) welcomePageViewController *pageViewController;
//@property (strong, nonatomic) contentViewController *contentViewController;

@end

