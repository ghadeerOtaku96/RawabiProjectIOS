//
//  RawabiAPI.m
//  HttpRequest
//
//  Created by Ghadeer Abualrub on 7/29/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "RawabiAPI.h"

@interface RawabiAPI ()<NSURLConnectionDelegate>


@property (strong, nonatomic)NSURLConnection* requestConnnection;
@property (strong, nonatomic)NSMutableData* receivedData;
@end

@implementation RawabiAPI

-(NSMutableData*)receivedData{
    if(!_receivedData){
        _receivedData = [[NSMutableData alloc]init];
    }
    return _receivedData;
}
-(NSURLConnection*)requestConnnection{
    if(!_requestConnnection){
        _requestConnnection = [[NSURLConnection alloc]init];
    }
    return _requestConnnection;
}

-(void)httpRequest:(NSMutableURLRequest *)request
{
    NSLog(@"Request connection start");
    _requestConnnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(_requestConnnection)
        NSLog(@"SS");
    else
        NSLog(@"FF");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d
{
    _receivedData = [NSMutableData dataWithData:d];
    NSLog(@"data is received");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate getReceivedData:_receivedData sender:self];
    _receivedData = nil;
    _requestConnnection = nil;
    _delegate = nil;
    NSLog(@"connection did finish loading");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"there is an ERROR: %@", error.description);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
