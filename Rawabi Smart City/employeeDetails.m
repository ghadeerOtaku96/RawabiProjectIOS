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
    
    self.companyObjectArray = [[NSMutableArray alloc]init];
    self.depObjArrar = [[NSMutableArray alloc]init];
    self.companyArray = [[NSMutableArray alloc]init];
    self.departmentArray = [[NSMutableArray alloc]init];
    self.rawabiAPI = [[RawabiAPI alloc]init];
    self.questionLabel.text = @"Are an employee at Rawabi?";
    
    self.departmentDropDownMenu.delegate = self;
    self.companyDropDownMenu.delegate = self;
    self.companyDropDownMenu.title = @"Company";
    self.departmentDropDownMenu.title = @"Department";
    
    [self addSubview:self.view];
    
    
}
#pragma mark - Event Handling
- (IBAction)select:(DLRadioButton *)sender {
    if([sender.currentTitle isEqual:@"YES"]){        
        self.status = [NSNumber numberWithBool:YES];
        self.requestURL = @"http://172.22.1.111:8080/admin/companies";
        [self getHttpRequestWithURLString:self.requestURL];
        self.companyDropDownMenu.hidden = NO;

    }
    else{
        
        self.status = [NSNumber numberWithBool:NO];
        self.companyDropDownMenu.hidden = YES;
        self.departmentDropDownMenu.hidden = YES;
        
        self.company = @"";
        self.companyID = @"";
        self.domain = @"";
        self.department = @"";
        self.departmentID = @"";
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
        
        if([self.requestURL isEqualToString:@"http://172.22.1.111:8080/admin/companies"])
        {
            
            NSInteger count = [[receivedData valueForKey:@"data"] count];
            for(int i=0 ; i<count ; i++){
                [self.companyObjectArray addObject:[[receivedData valueForKey:@"data"]objectAtIndex:i]];
                [self.companyArray addObject:[[self.companyObjectArray objectAtIndex:i] valueForKey:@"name"]];
                
               
            }
            self.companyDropDownMenu.items = self.companyArray ;
            

        }// IF RECEIVED DATA ARE COMPANIES SET
        
        if([self.requestURL containsString:@"departments/id="])
        {
            NSInteger count = [[receivedData valueForKey:@"data"] count];
            for(int j=0 ; j<count ; j++){
                [self.depObjArrar addObject:[[receivedData valueForKey:@"data"] objectAtIndex:j]];
                [self.departmentArray addObject:[[[receivedData valueForKey:@"data"] objectAtIndex:j] valueForKey:@"title"]];
              
            }//for loop
            self.departmentDropDownMenu.items = self.departmentArray;
    
        }//IF RECEIVED DATA ARE DEPARTMENTS SET
        
        
    }
 
}

#pragma mark - KPDropMenu Delegate Methods

-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
   
    NSLog(@"%@", dropMenu.items[atIntedex]);
    if(dropMenu == self.companyDropDownMenu){
        self.companyID = [NSString stringWithString:[[self.companyObjectArray objectAtIndex:atIntedex] valueForKey:@"_id"]];
        self.company = [[NSString alloc]initWithString:[[self.companyObjectArray objectAtIndex:atIntedex]valueForKey:@"name"]] ;
        self.domain = [NSString stringWithString:[[self.companyObjectArray objectAtIndex:atIntedex]valueForKey:@"domain"]];
        self.departmentDropDownMenu.hidden = NO;
        [self.depObjArrar removeAllObjects];
        [self.departmentArray removeAllObjects];
        self.requestURL = [NSString stringWithFormat:@"http://172.22.1.111:8080/admin/departments/id=%@",self.companyID];
        [self getHttpRequestWithURLString:self.requestURL];
    }
    
    if(dropMenu == self.departmentDropDownMenu)
        self.department = [[NSString alloc]initWithString:[self.departmentArray objectAtIndex:atIntedex]] ;
    self.departmentID = [NSString stringWithString:[[self.companyObjectArray objectAtIndex:atIntedex]valueForKey:@"_id"]];
    NSLog(@"SELECTED DEPARTMENT %@", self.department);
}

-(void)didShow:(KPDropMenu *)dropMenu{
    NSLog(@"didShow");
}

-(void)didHide:(KPDropMenu *)dropMenu{
    NSLog(@"didHide");
}

//
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
