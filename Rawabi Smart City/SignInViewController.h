//
//  SignInViewController.h
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/15/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "RawabiAPI.h"
#import "FCAlertView.h"
#import "SignUpViewController.h"
#import "CollectionViewController.h"
@interface SignInViewController : UIViewController <UITextFieldDelegate , UIGestureRecognizerDelegate , RawabiAPIDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *QimageView;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *emailTextField;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *forgetPassButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;


-(void)postHttpRequest;
-(void)createPostBodyWithEmail:(NSString*)email AndPassword:(NSString*)password;
@end
