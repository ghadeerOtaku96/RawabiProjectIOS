//
//  personalDetails.m
//  Rawabi Smart City
//
//  Created by Ghadeer Abualrub on 7/24/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "personalDetails.h"

@implementation personalDetails

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self customInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

-(void)customInit{
    [[NSBundle mainBundle]loadNibNamed:@"personalDetailsView" owner:self options:nil];
    self.bounds = self.view.bounds;
    
    [self.firstNameTextField setBorderStyle:UITextBorderStyleNone];
    [self.lastNameTextField setBorderStyle:UITextBorderStyleNone];
    [self.emailTextField setBorderStyle:UITextBorderStyleNone];
    [self.phoneTextField setBorderStyle:UITextBorderStyleNone];

//    self.firstNameTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user"]];
//    self.firstNameTextField.leftViewMode = UITextFieldViewModeAlways;
//    
//    self.lastNameTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user"]];
//    self.lastNameTextField.leftViewMode = UITextFieldViewModeAlways;
//    
//    self.emailTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"email-2x"]];
//    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
//    
//    self.phoneTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phone"]];
//    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    [self addSubview:self.view];

    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
 
 
 */
@end
