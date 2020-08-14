//
//  InvestDetailViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/21/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "InvestDetailViewController.h"

@interface InvestDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stockFullName;

@property (weak, nonatomic) IBOutlet UILabel *stockSymbol;

@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *marketChangeLabel;

@property (weak, nonatomic) IBOutlet UILabel *marketChanePercentLabel;

@property (weak, nonatomic) IBOutlet UILabel *PreviousMarketLabel;

@property (weak, nonatomic) IBOutlet UILabel *ExchangeLabel;
@property (nonatomic,strong) NSArray *results;

@end

@implementation InvestDetailViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchStock];
   // self.stockFullName.text = self.result[@"shortName"];
    //NSLog(@"%@ Test for details ", self.result);
    // Do any additional setup after loading the view.

  //  NSLog(@"%@", self.result[@"longName"]);
    
//    self.stockFullName.text = self.result[@"symbol"];
}




-(void)fetchStock{
   // [self.stockActivityIndicator startAnimating];
    NSDictionary *headers = @{ @"x-rapidapi-host": @"apidojo-yahoo-finance-v1.p.rapidapi.com",
                               @"x-rapidapi-key": @"622630b4d1mshbdea0d47e58ee3fp11ccc2jsnf94436f9936d" };

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/get-trending-tickers?region=US"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        
                                                        
                                                        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        NSLog(@"%@", dataDictionary);
                                              
                                                        self.results = dataDictionary[@"finance"][@"result"][0][@"quotes"];
                                                        NSLog(@"@%@", dataDictionary[@"finance"][@"result"][0][@"quotes"]);
                                                       // [self.stockActivityIndicator stopAnimating];
                                                        for(id result in self.results){
                                                            NSLog(@"%@", result[@"shortName"]);
                                                            
                                                        }
                                                     //  [self.stockTableView reloadData];

                                                        
                                                        
                                                    }
        
             
      //  [self.stockrefreshControl endRefreshing];
        
                                            }];
    [task resume];

    
    
    
    
    
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
