//
//  HomeViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/29/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "HomeViewController.h"
#import "AccountDataCell.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "AccountInfo.h"
#import <FoldingCell/FoldingCell-Swift.h>
#import "ViewController+PLKPlaidLinkViewDelegate.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *transactionsArray;
@property (nonatomic,strong) NSArray *balanceArray;
@property (nonatomic,strong) NSMutableArray *accDataArray;
@property(strong, nonatomic) AccountInfo *accountInfo;
@property (weak, nonatomic) IBOutlet UITableView *accDataTableView;
@property (strong, nonatomic) IBOutlet UIScreenEdgePanGestureRecognizer *swipeGesture;
@property(strong, nonatomic) AccountDataCell *accountDataCell;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accDataTableView.dataSource = self;
    self.accDataTableView.dataSource = self;
    [self fetchaccountdata];

    
    
    
    
    
 
}

- (IBAction)onSwipeGesture:(id)sender {
    [self performSegueWithIdentifier:@"chartSegue" sender:nil];
}




- (IBAction)logout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
           SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           UIViewController  *loginNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
           sceneDelegate.window.rootViewController = loginNavigationController;
           NSLog(@"Log out Sucessful");
        
           
       }];
    
}



-(void)getTransactions{

    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://sandbox.plaid.com/transactions/get"]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:10.0];
    NSDictionary *headers = @{
      @"Content-Type": @"application/json"
    };

    [request setAllHTTPHeaderFields:headers];
    NSData *postData = [[NSData alloc] initWithData:[@"{\n    \"client_id\": \"5f18a1d2b89a9900124d8b90\",\n    \"secret\": \"bd12e8976f94de46e0bc5c46be2e27\",\n    \"access_token\": \"access-sandbox-d1ec736a-98dc-4af4-9ca6-7dab907e5207\",\n    \"start_date\": \"2018-01-01\",\n    \"end_date\": \"2020-01-01\",\n    \"options\": {\n        \"count\": 250,\n        \"offset\": 100\n    }\n}" dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];

    [request setHTTPMethod:@"POST"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"%@", error);
      } else {

        NSError *parseError = nil;
        NSDictionary *responseDictionarytrans = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"This are my transactions%@",responseDictionarytrans);

          
          NSArray *accTransactions = responseDictionarytrans[@"transactions"];
          NSLog(@"This is my transactions array%@", accTransactions);

        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);


}


-(void)fetchaccountdata{
    self.accDataArray = [[NSMutableArray alloc]init];

    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://sandbox.plaid.com/auth/get"]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:10.0];
    NSDictionary *headers = @{
      @"Content-Type": @"application/json"
    };

    [request setAllHTTPHeaderFields:headers];
    NSData *postData = [[NSData alloc] initWithData:[@"{\n    \"client_id\": \"5f18a1d2b89a9900124d8b90\",\n    \"secret\": \"bd12e8976f94de46e0bc5c46be2e27\",\n    \"access_token\": \"access-sandbox-d1ec736a-98dc-4af4-9ca6-7dab907e5207\"\n}" dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];

    [request setHTTPMethod:@"POST"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"%@", error);
      } else {

        NSError *parseError = nil;
        NSDictionary *responseDictionaryacc = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"%@",responseDictionaryacc);
          
        NSArray *accDataArray = responseDictionaryacc[@"accounts"];
        NSLog(@"This is my acc array%@", accDataArray);
        self.accDataArray = (NSMutableArray *) accDataArray;
        for (NSDictionary *acc in accDataArray){
            NSLog(@"This is my account%@", acc[@"name"]);
    
          }
          NSLog(@"%@", self.accDataArray);
          
          
        
          
          
          
        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);



}






#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccountDataCell *cell = [_accDataTableView dequeueReusableCellWithIdentifier:@"accountCell"];
    
    NSDictionary *accdata = self.accDataArray[indexPath.row];
    
    cell.accountNameType.text = accdata[@"name"];
    cell.AccountType.text = accdata[@"subtype"];

    cell.availableBalance.text =
    [NSString stringWithFormat:@"%@", accdata[@"balances"][@"available"]];
    NSLog(@"This is  cash %@",accdata[@"balances"][@"available"]);
    
    cell.currentBalance.text = [NSString stringWithFormat:@"%@",accdata[@"balances"][@"current"]];
    NSLog(@"This is   curr cash %@",accdata[@"balances"][@"current"]);
 
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([sender isKindOfClass:[AccountDataCell class]]) {
        //AccountDataCell *testCell = sender;
        //ChartVC *controller = [segue destinationViewController];
    }
}




@end
