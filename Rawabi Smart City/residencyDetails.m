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
        self.residencyTypeMenu.hidden = NO;
        NSLog(@"%ld",self.status);
    }
    else{
        
        self.status = 0;
        NSLog(@"%ld",self.status);
        self.residencyTypeMenu.hidden = YES;
        self.neighborhoodMenu.hidden = YES;
        self.buildingNumberMenu.hidden = YES;
        self.floorMenu.hidden = YES;
        self.apartmentNumberMenu.hidden = YES;
    }
}

#pragma mark - KPDropMenu Delegate Methods

-(void)didSelectItem:(KPDropMenu *)dropMenu atIndex:(int)atIntedex{
    
    NSLog(@"%@", dropMenu.items[atIntedex]);
}

-(void)didShow:(KPDropMenu *)dropMenu{
    NSLog(@"didShow");
}

-(void)didHide:(KPDropMenu *)dropMenu{
    
    if(dropMenu == self.residencyTypeMenu && ![self.residencyTypeMenu.title isEqualToString:@"Residency Type"]){
        self.neighborhoodMenu.hidden = NO;
    }
    else if(dropMenu == self.neighborhoodMenu && ![self.neighborhoodMenu.title isEqualToString:@"Neighborhood"]){
        self.buildingNumberMenu.hidden = NO;
    }
    else if(dropMenu == self.buildingNumberMenu && ![self.buildingNumberMenu.title isEqualToString:@"Building Number"]){
        self.floorMenu.hidden = NO;
    }
    else if(dropMenu == self.floorMenu && ![self.floorMenu.title isEqualToString:@"Floor"]){
        self.apartmentNumberMenu.hidden = NO;
    }
    else {
        NSLog(@"didHide");
    }
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
