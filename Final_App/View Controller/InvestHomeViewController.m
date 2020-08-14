//
//  InvestHomeViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/14/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "InvestHomeViewController.h"
#import "StockCell.h"
#import "MaterialBottomAppBar.h"
@interface InvestHomeViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong) NSArray *results;
@property(nonatomic,strong) NSMutableArray *filteredResults;
@property (assign, nonatomic) BOOL isFiltered;

@property (weak, nonatomic) IBOutlet UITableView *stockTableView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *stockActivityIndicator;
@property(nonatomic, strong)UIRefreshControl *stockrefreshControl;



@end

@implementation InvestHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.stockTableView.dataSource = self;
    self.stockTableView.delegate = self;
    [self  fetchStock];
    
    
    self.stockActivityIndicator= [[UIActivityIndicatorView alloc]init];
    
    [self.stockrefreshControl addTarget:self action:@selector(fetchStock) forControlEvents:UIControlEventValueChanged];
    [self.stockTableView insertSubview:self.stockrefreshControl atIndex:0];
    [self.stockTableView addSubview:self.stockrefreshControl];
    self.stockSearch.delegate = self;
  
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if([self.stockSearch.text isEqualToString:@""]){
      //  self.isFiltered = true;
        self.filteredResults = [[NSMutableArray alloc]initWithArray:self.results copyItems:YES];
    }
    else{
        self.isFiltered = false;
        for (NSArray *res in self.results){
            if ([[res.description lowercaseString]rangeOfString:[self.stockSearch.text lowercaseString]].location != NSNotFound) {
                [self.filteredResults addObject:res];
            }
        }
        
        [self.stockTableView reloadData];
    }
  
        
}




//Network request for yahoo finance api

-(void)fetchStock{
    [self.stockActivityIndicator startAnimating];
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
                                                        [self.stockActivityIndicator stopAnimating];
                                                        for(id result in self.results){
                                                            NSLog(@"%@", result[@"shortName"]);
                                                            
                                                        }
                                                       [self.stockTableView reloadData];

                                                        
                                                        
                                                    }
        
             
        [self.stockrefreshControl endRefreshing];
        
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
    
    cell.stocknameLabel.text =result[@"symbol"];
    
    cell.regPriceLabel.text= [NSString stringWithFormat:@"$%@.2f", result[@"regularMarketPrice"]];
    cell.percentChangeLabel.text =[NSString stringWithFormat:@"%@.2f", result[@"regularMarketChangePercent"]];
    cell.PrevCloseLabel.text = [NSString stringWithFormat:@"%@.2f", result[@"regularMarketPreviousClose"]];
    
    
    
    
   // cell.textLabel.text = result[@"shortName"];
    return cell;
}
- (IBAction)stockReturn:(UISegmentedControl *)sender {
    StockCell *cell = [_stockTableView dequeueReusableCellWithIdentifier:(@"StockCell")];
    NSArray *timeInvest = @[@(3), @(6), @(12)];
    int ivestT = [timeInvest[cell.InvestTimeControl.selectedSegmentIndex] intValue];
    int principal = 10000;
    int rate  = 7.25;
    int time = ivestT;
    int divisor = 100;
    int totRet = (principal * rate *time)/(divisor);
    cell.ReturnLabel.text = [NSString  stringWithFormat:@"%d",totRet];
    
    
}








//-(void)retainValue{
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
