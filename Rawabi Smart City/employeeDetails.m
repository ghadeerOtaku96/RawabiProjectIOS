//
//  employeeDetails.m
//  Rawabi Smart City
//
//  Created by Ghadeer Abualrub on 7/24/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "employeeDetails.h"

@implementation employeeDetails



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
    [[NSBundle mainBundle]loadNibNamed:@"employeeDetailsView" owner:self options:nil];
    self.bounds = self.view.bounds;
    
    self.questionLabel.text = @"Are an employee at Rawabi?";
    
    self.companyArray = @[@"Asal Technology" , @"Bayti"];
    self.departmentArry = @[@"IT" , @"HR"];
    
    self.companyDropDownMenu.items = self.companyArray;
    self.departmentDropDownMenu.items = self.departmentArry;
    self.companyDropDownMenu.itemsIDs = @[@"0",@"1"];
    self.departmentDropDownMenu.itemsIDs = @[@"0",@"1"];
    self.departmentDropDownMenu.delegate = self;
    self.companyDropDownMenu.delegate = self;
    self.companyDropDownMenu.title = @"Company";
    self.departmentDropDownMenu.title = @"Department";

    
    self.companyDropDownMenu.hidden = YES;
    self.departmentDropDownMenu.hidden = YES;
    [self addSubview:self.view];
    
    
}

- (IBAction)select:(DLRadioButton *)sender {
    if([sender.currentTitle isEqual:@"YES"]){
        
        self.status = 1;
        self.companyDropDownMenu.hidden = NO;
        if(![self.companyDropDownMenu.title isEqualToString:@"Company"])
            self.departmentDropDownMenu.hidden = NO;
        NSLog(@"%ld",self.status);
    }
    else{
        
        self.status = 0;
        NSLog(@"%ld",self.status);
    }
}

#pragma mark - KPDropMenu Delegate Methods

-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
   
    
        NSLog(@"%@", dropMenu.items[atIntedex]);
}

-(void)didShow:(KPDropMenu *)dropMenu{
    NSLog(@"didShow");
}

-(void)didHide:(KPDropMenu *)dropMenu{
    NSLog(@"didHide");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
