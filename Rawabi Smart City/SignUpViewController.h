//
//  SignUpViewController.h
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/15/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSProfileStepper.h"

#import "personalDetails.h"
#import "employeeDetails.h"
#import "residencyDetails.h"


@interface SignUpViewController : UIViewController <UITextFieldDelegate , UIGestureRecognizerDelegate>

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;

@end
