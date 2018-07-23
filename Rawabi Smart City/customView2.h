//
//  customView2.h
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/19/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLRadioButton.h"
@interface customView2 : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet DLRadioButton *yesButton;
@property (strong, nonatomic) IBOutlet DLRadioButton *noButton;



@property (strong, nonatomic) IBOutlet UILabel *result;
@property (nonatomic) NSInteger status;
@end
