//
//  SignUpViewController.h
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/15/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSProfileStepper.h"
#import "RawabiAPI.h"
#import "personalDetails.h"
#import "employeeDetails.h"
#import "residencyDetails.h"
#import "SignInViewController.h"


@interface SignUpViewController : UIViewController <UITextFieldDelegate , UIGestureRecognizerDelegate , RawabiAPIDelegate>

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;

@end
