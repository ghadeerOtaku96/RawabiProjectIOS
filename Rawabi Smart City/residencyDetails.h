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
@interface residencyDetails : UIView <KPDropMenuDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet DLRadioButton *yesButton;
@property (strong, nonatomic) IBOutlet DLRadioButton *noButton;
@property (nonatomic) NSInteger status;

@property (strong, nonatomic) IBOutlet KPDropMenu *residencyTypeMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *neighborhoodMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *buildingNumberMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *floorMenu;
@property (strong, nonatomic) IBOutlet KPDropMenu *apartmentNumberMenu;

@property (strong, nonatomic) NSArray* residencyTypeArray;
@property (strong, nonatomic) NSArray* neighborhoodArray;
@property (strong, nonatomic) NSArray* buildingNumberArray;
@property (strong, nonatomic) NSArray* floorArray;
@property (strong, nonatomic) NSArray* apartmentNumberArray;

@end
