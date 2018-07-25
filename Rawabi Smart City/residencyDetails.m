//
//  residencyDetails.m
//  Rawabi Smart City
//
//  Created by Ghadeer Abualrub on 7/24/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "residencyDetails.h"

@implementation residencyDetails

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
    
    [[NSBundle mainBundle]loadNibNamed:@"residencyDetailsView" owner:self options:nil];
    self.bounds = self.view.bounds;
    
    self.questionLabel.text = @"Are you a resident at Rawabi?";
    self.residencyTypeArray = @[@"Rent" , @"Owner"];
    self.neighborhoodArray = @[@"Warwar"];
    self.buildingNumberArray = @[@"1",@"2",@"3",@"4"];
    self.floorArray = @[@"0",@"1",@"2",@"3",@"4"];
    self.apartmentNumberArray = @[@"1",@"2",@"3"];
    
    self.residencyTypeMenu.items = self.residencyTypeArray;
    self.neighborhoodMenu.items = self.neighborhoodArray;
    self.buildingNumberMenu.items = self.buildingNumberArray;
    self.floorMenu.items = self.floorArray;
    self.apartmentNumberMenu.items = self.apartmentNumberArray;
    
    self.residencyTypeMenu.title = @"Residency Type";
    self.neighborhoodMenu.title = @"Neighborhood";
    self.buildingNumberMenu.title = @"Building Number";
    self.floorMenu.title = @"Floor";
    self.apartmentNumberMenu.title = @"Apartment Number";
    
    self.residencyTypeMenu.delegate = self;
    self.neighborhoodMenu.delegate = self;
    self.buildingNumberMenu.delegate = self;
    self.floorMenu.delegate = self;
    self.apartmentNumberMenu.delegate = self;
    
    [self addSubview:self.view];
}




- (IBAction)select:(DLRadioButton *)sender {
    if([sender.currentTitle isEqual:@"YES"]){
        
        self.status = 1;
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
