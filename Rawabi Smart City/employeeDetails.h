//
//  employeeDetails.h
//  Rawabi Smart City
//
//  Created by Ghadeer Abualrub on 7/24/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RawabiAPI.h"
#import "DLRadioButton.h"
#import "KPDropMenu.h"
@interface employeeDetails : UIView <RawabiAPIDelegate , KPDropMenuDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;


@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet DLRadioButton *yesButton;
@property (strong, nonatomic) IBOutlet DLRadioButton *noButton;
@property (strong, nonatomic) IBOutlet KPDropMenu *companyDropDownMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *departmentDropDownMenu;

@property (strong, nonatomic) NSNumber* status;

@property (strong, nonatomic) NSMutableArray *companyArray;
@property (strong, nonatomic) NSMutableArray *companyObjectArray;
@property (strong, nonatomic) NSMutableArray *departmentArray;
@property (strong, nonatomic)NSMutableArray *depObjArrar;
@property (strong, nonatomic) NSString *companyID;
@property (strong, nonatomic) NSString *departmentID;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *domain;
@property (strong, nonatomic) NSString *department;

@property (strong, nonatomic)RawabiAPI* rawabiAPI;
@property (strong, nonatomic)NSMutableURLRequest* request;
@property (strong, nonatomic)NSString* requestURL;

@end
