//
//  ViewController.m
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/12/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Apllication LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.contentLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTable(@"lbl", @"uiStrings", nil)];
    [self.signInButton setTitle:NSLocalizedStringFromTable(@"Signin Btn", @"uiStrings", nil)forState:UIControlStateNormal];
    [self.signUpButton setTitle:NSLocalizedStringFromTable(@"Signup Btn", @"uiStrings", nil)forState:UIControlStateNormal];
    
      self.signInButton.layer.cornerRadius = 5;
    self.signInButton.clipsToBounds = YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Handling
- (IBAction)signIn:(UIButton *)sender {
    
    SignInViewController* nextVC = (SignInViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
        [self presentViewController:nextVC animated:YES completion:nil];

}

- (IBAction)signUp:(UIButton *)sender {
}

@end
