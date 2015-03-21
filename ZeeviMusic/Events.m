//
//  Events.m
//  ZeeviMusic
//
//  Created by Vicente Guerra Hernández on 3/20/15.
//  Copyright (c) 2015 Vicente Guerra Hernández. All rights reserved.
//

#import "Events.h"

@interface Events ()
@property (nonatomic, strong) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UITextView *Event1;
@property (weak, nonatomic) IBOutlet UITextView *Event2;
@property (weak, nonatomic) IBOutlet UITextView *Event3;



@end

@implementation Events

@synthesize responseData = _responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload");
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://localhost:3000/api/events/active"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSError * error;
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    //parse out the json data
     NSMutableArray *json = [NSJSONSerialization
                          JSONObjectWithData:self.responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSDictionary* event=[json objectAtIndex:0];
    
    NSString *Data1 = [NSString stringWithFormat:@"Band Name: %@ \n Venue Name: %@ \n Fecha: %@ \n Hora: %@", event[@"band_name"],event[@"venue_name"],event[@"date"],event[@"hour"]];
    self.Event1.text = Data1;
    
    NSDictionary* event2=[json objectAtIndex:1];
    
    NSString *Data2 = [NSString stringWithFormat:@"Band Name: %@ \n Venue Name: %@ \n Fecha: %@ \n Hora: %@", event2[@"band_name"],event2[@"venue_name"],event2[@"date"],event2[@"hour"]];
    self.Event2.text = Data2;
    
    /*
    NSDictionary* event3=[json objectAtIndex:0];
    
    NSString *Data3 = [NSString stringWithFormat:@"Band Name: %@ \n Venue Name: %@ \n Fecha: %@ \n Hora: %@", event3[@"band_name"],event3[@"venue_name"],event3[@"date"],event3[@"hour"]];
    self.Event3.text = Data3;
    
    NSDictionary* event4=[json objectAtIndex:0];
    
    NSString *Data4 = [NSString stringWithFormat:@"Band Name: %@ \n Venue Name: %@ \n Fecha: %@ \n Hora: %@", event4[@"band_name"],event4[@"venue_name"],event4[@"date"],event4[@"hour"]];
    self.Event4.text = Data4;
    
    */
}

- (void)viewDidUnload {
    [super viewDidUnload];
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
