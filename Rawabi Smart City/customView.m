//
//  customView.m
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/18/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "customView.h"

@implementation customView

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
    [[NSBundle mainBundle]loadNibNamed:@"View" owner:self options:nil];
    self.bounds = self.view.bounds;

    [self addSubview:self.view];
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
