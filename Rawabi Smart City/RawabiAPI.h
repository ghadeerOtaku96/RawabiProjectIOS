//
//  RawabiAPI.h
//  HttpRequest
//
//  Created by Ghadeer Abualrub on 7/29/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RawabiAPI;
@protocol RawabiAPIDelegate <NSObject>

-(void)getReceivedData:(NSMutableData*)data sender:(RawabiAPI*)sender;

@end
@interface RawabiAPI : NSObject

-(void)httpRequest:(NSMutableURLRequest*)request;

@property (weak, nonatomic) id <RawabiAPIDelegate> delegate;

@end
