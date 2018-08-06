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
    
    self.rawabiAPI = [[RawabiAPI alloc]init];
    self.requestURL = @"http://172.22.1.111:8080/admin/neighbourhood";
    self.questionLabel.text = @"Are you a resident at Rawabi?";
    self.residencyTypeMenu.items = @[@"Rent" , @"Owner"];
    self.neighborhoodArray = [[NSMutableArray alloc]init];
    self.buildingNumberArray = [[NSMutableArray alloc]init];
    self.floorArray = [[NSMutableArray alloc]init];
    self.apartmentNumberArray = [[NSMutableArray alloc]init];
    self.objectsArray = [[NSMutableArray alloc]init];

    
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
    
    [self getHttpRequestWithURLString:self.requestURL];
    
    [self addSubview:self.view];
}




- (IBAction)select:(DLRadioButton *)sender {
    if([sender.currentTitle isEqual:@"YES"]){
        
        self.status = [NSNumber numberWithBool:YES];
        self.residencyTypeMenu.hidden = NO;

    }
    else{
        
        self.status = [NSNumber numberWithBool:NO];
        self.residencyTypeMenu.hidden = YES;
        self.neighborhoodMenu.hidden = YES;
        self.buildingNumberMenu.hidden = YES;
        self.floorMenu.hidden = YES;
        self.apartmentNumberMenu.hidden = YES;
        
        self.residencyType = @"";
        self.neighborhood = @"";
        self.neighborhoodID = @"";
        self.buildingNumber = @"";
        self.buildingNumberID = @"";
        self.floor = @"";
        self.floorID = @"";
        self.apartmentNumber = @"";
        self.apartmentNumberID = @"";
    }
}

#pragma mark - HTTP Request Handling
-(void)getHttpRequestWithURLString:(NSString*)url
{
    NSString* getString = url;
    self.request = [[NSMutableURLRequest alloc]init];
    [self.request setURL:[NSURL URLWithString:getString]];
    [self.request setHTTPMethod:@"GET"];
    [self.request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [self.request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.rawabiAPI.delegate = self;
    [self.rawabiAPI httpRequest:self.request];
}

#pragma mark - RawabiAPI Delegate Method
-(void)getReceivedData:(NSMutableData *)data sender:(RawabiAPI *)sender
{
    NSError* error = nil;
    NSDictionary* receivedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if(receivedData)
    {
        NSInteger count = 0;
        [self.buildingNumberArray removeAllObjects];
        [self.floorArray removeAllObjects];
        [self.apartmentNumberArray removeAllObjects];
        if([self.requestURL isEqualToString:@"http://172.22.1.111:8080/admin/neighbourhood"])
        {
            
            count = [[receivedData valueForKey:@"data"] count];
            for(int i=0 ; i<count ; i++){
                
                [self.objectsArray addObject:[[receivedData valueForKey:@"data"]objectAtIndex:i]];
                [self.neighborhoodArray addObject:[[[receivedData valueForKey:@"data"]objectAtIndex:i] valueForKey:@"neighbourhood_name"]];
                
            }
            self.neighborhoodMenu.items = self.neighborhoodArray ;

            
            
        }// IF RECEIVED DATA ARE NEIGHBOURHOOD SET
        
        if([self.requestURL containsString:@"buildings/id="])
        {
            count = [[receivedData valueForKey:@"data"] count];
            for(int j=0 ; j<count ; j++){
                [self.objectsArray addObject:[[receivedData valueForKey:@"data"] objectAtIndex:j]];
                [self.buildingNumberArray addObject:[[[receivedData valueForKey:@"data"] objectAtIndex:j] valueForKey:@"building_number"]];
                
            }//for loop
            self.buildingNumberMenu.items = self.buildingNumberArray;
        }//IF RECEIVED DATA ARE BUILDINGS NUMBER SET
        
        if([self.requestURL containsString:@"floors/id="]){
            count = [[[receivedData valueForKey:@"data"] valueForKey:@"floors"] count] ;
            for(int j=0 ; j<count ; j++){
                [self.objectsArray addObject:[[[receivedData valueForKey:@"data"]valueForKey:@"floors"]objectAtIndex:j]];
                [self.floorArray addObject:[[[[receivedData valueForKey:@"data"]valueForKey:@"floors"]objectAtIndex:j] valueForKey:@"floor_number"]];
                
            }//for loop
            self.floorMenu.items = self.floorArray;
        }// IF RECEIVED DATA ARE FLOOR SET
        
        if([self.requestURL containsString:@"apartment/id="]){
            count = [[[receivedData valueForKey:@"data"] valueForKey:@"apartments"] count];
            for(int j=0 ; j<count ; j++){
                [self.objectsArray addObject:[[[receivedData valueForKey:@"data"]valueForKey:@"apartments"]objectAtIndex:j]];
                [self.apartmentNumberArray addObject:[[[[receivedData valueForKey:@"data"]valueForKey:@"apartments"]objectAtIndex:j]valueForKey:@"apartment_number"]];
                
            }//for loop
            self.apartmentNumberMenu.items = self.apartmentNumberArray;
        }// IF RECEIVED DATA ARE APARTMENT SET
    }//IF RECEIVED DATA ARE NOT NIL
    
}

#pragma mark - KPDropMenu Delegate Methods

-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
   
    NSLog(@"%@", dropMenu.items[atIntedex]);
    if(dropMenu == self.residencyTypeMenu){
        self.neighborhoodMenu.hidden = NO;
        self.residencyType = [NSString stringWithString:dropMenu.items[atIntedex]];

    }
    if (dropMenu == self.neighborhoodMenu) {
        self.buildingNumberMenu.hidden = NO;
        self.neighborhoodID = [NSString stringWithString:[[self.objectsArray objectAtIndex:atIntedex] valueForKey:@"_id"]];
        self.neighborhood = [NSString stringWithString:dropMenu.items[atIntedex]];
        self.requestURL = [NSString stringWithFormat:@"http://172.22.1.111:8080/admin/buildings/id=%@",self.neighborhoodID];
        [self.objectsArray removeAllObjects];
        [self getHttpRequestWithURLString:self.requestURL];
    }
    if(dropMenu == self.buildingNumberMenu){
        self.floorMenu.hidden = NO;
        self.buildingNumberID = [NSString stringWithString:[[self.objectsArray objectAtIndex:atIntedex] valueForKey:@"_id"]];
        self.buildingNumber = [NSString stringWithString:dropMenu.items[atIntedex]];
        self.requestURL = [NSString stringWithFormat:@"http://172.22.1.111:8080/admin/floors/id=%@",self.buildingNumberID];
        [self.objectsArray removeAllObjects];
        [self getHttpRequestWithURLString:self.requestURL];
    }
    if(dropMenu == self.floorMenu){
        self.apartmentNumberMenu.hidden = NO;
        self.floorID = [NSString stringWithString:[[self.objectsArray objectAtIndex:atIntedex] valueForKey:@"_id"]];
        self.floor = [NSString stringWithString:dropMenu.items[atIntedex]];
        self.requestURL = [NSString stringWithFormat:@"http://172.22.1.111:8080/admin/apartment/id=%@",self.floorID];
        [self.objectsArray removeAllObjects];
        [self getHttpRequestWithURLString:self.requestURL];
    }
    if(dropMenu == self.apartmentNumberMenu){
        self.apartmentNumber = [NSString stringWithString:dropMenu.items[atIntedex]];
        self.apartmentNumberID = [NSString stringWithString:[[self.objectsArray objectAtIndex:atIntedex] valueForKey:@"_id"]];
    }
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
