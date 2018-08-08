//
//  residencyDetails.h
//  Rawabi Smart City
//
//  Created by Ghadeer Abualrub on 7/24/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLRadioButton.h"
#import "KPDropMenu.h"
#import "RawabiAPI.h"
@interface residencyDetails : UIView <RawabiAPIDelegate , KPDropMenuDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet DLRadioButton *yesButton;
@property (strong, nonatomic) IBOutlet DLRadioButton *noButton;
@property (strong, nonatomic) NSNumber* status;

@property (strong, nonatomic) IBOutlet KPDropMenu *residencyTypeMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *neighborhoodMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *buildingNumberMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *floorMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *apartmentNumberMenu;

@property (strong, nonatomic) NSMutableArray* objectsArray;
@property (strong, nonatomic) NSMutableArray* neighborhoodArray;
@property (strong, nonatomic) NSMutableArray* buildingNumberArray;
@property (strong, nonatomic) NSMutableArray* floorArray;
@property (strong, nonatomic) NSMutableArray* apartmentNumberArray;

@property (strong, nonatomic) NSString* neighborhoodID;
@property (strong, nonatomic) NSString* buildingNumberID;
@property (strong, nonatomic) NSString* floorID;
@property (strong, nonatomic) NSString* apartmentNumberID;

@property (strong, nonatomic) NSString* residencyType;
@property (strong, nonatomic) NSString* neighborhood;
@property (strong, nonatomic) NSString* buildingNumber;
@property (strong, nonatomic) NSString* floor;
@property (strong, nonatomic) NSString* apartmentNumber;

@property (strong, nonatomic)RawabiAPI* rawabiAPI;
@property (strong, nonatomic)NSMutableURLRequest* request;
@property (strong, nonatomic)NSString* requestURL;

@end
