//
//  InvestHomeViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/14/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "InvestHomeViewController.h"
#import "StockCell.h"
@interface InvestHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray *results;

@property (weak, nonatomic) IBOutlet UITableView *stockTableView;

@end

@implementation InvestHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.stockTableView.dataSource = self;
    self.stockTableView.delegate = self;
    [self  fetchStock];
    
    
    
}

//Network request for yahoo finance api

-(void)fetchStock{
    
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
                                                        for(id result in self.results){
                                                            NSLog(@"%@", result[@"shortName"]);
                                                            
                                                        }
                                                       [self.stockTableView reloadData];

                                                        
                                                        
                                                    }
        
             
       
        
                                            }];
    [task resume];

    
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StockCell *cell = [_stockTableView dequeueReusableCellWithIdentifier:(@"StockCell")];
    NSDictionary *result = self.results[indexPath.row];
    [cell.stocknameLabel sizeToFit];
    //[cell.stockSymbolLabel sizeToFit];
    cell.stocknameLabel.text =result[@"symbol"];
    //cell.stockSymbolLabel.text = result[@"symbol"];
    cell.regPriceLabel.text= [NSString stringWithFormat:@"%@ $", result[@"regularMarketPrice"]];
    cell.percentChangeLabel.text =[NSString stringWithFormat:@"%@", result[@"regularMarketChangePercent"]];
    cell.PrevCloseLabel.text = [NSString stringWithFormat:@"%@", result[@"regularMarketPreviousClose"]];
   // cell.textLabel.text = result[@"shortName"];
    return cell;
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
