//
//  customView2.m
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/19/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "customView2.h"


@implementation customView2

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
    [[NSBundle mainBundle]loadNibNamed:@"View2" owner:self options:nil];
    self.bounds = self.view.bounds;
    self.status = 99;
    [self addSubview:self.view];
    
}

- (IBAction)select:(DLRadioButton *)sender {
    if([sender.currentTitle isEqual:@"YES"]){
        self.result.text = @"yes";
        self.status = 1;
        NSLog(@"%ld",self.status);
    }
    else{
        self.result.text = @"no";
        self.status = 0;
        NSLog(@"%ld",self.status);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
