//
//  personalDetails.h
//  Rawabi Smart City
//
//  Created by Ghadeer Abualrub on 7/24/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
@interface personalDetails : UIView

@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) IBOutlet ACFloatingTextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *emailTextField;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *phoneTextField;

@end
