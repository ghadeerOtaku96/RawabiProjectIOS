//
//  employeeDetails.h
//  Rawabi Smart City
//
//  Created by Ghadeer Abualrub on 7/24/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"
#import "DLRadioButton.h"
@interface employeeDetails : UIView <KPDropMenuDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet DLRadioButton *yesButton;
@property (strong, nonatomic) IBOutlet DLRadioButton *noButton;
@property (strong, nonatomic) IBOutlet KPDropMenu *companyDropDownMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *departmentDropDownMenu;

@property (nonatomic) NSInteger status;

@property (strong, nonatomic) NSArray *companyArray;
@property (strong, nonatomic) NSArray *departmentArry;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *department;


@end
