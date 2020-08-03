//
//  ChartViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 8/3/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "ChartViewController.h"
#import "PNChart.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"
@interface ChartViewController ()
@property (nonatomic) PNPieChart *pieChart;
@property(nonatomic) double food_drink;
@property(nonatomic) id payment;
@property(nonatomic) id recreation;
@property(nonatomic) id transfer;
@property(nonatomic) id travel;
@property(nonatomic)CGFloat float1;
@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pie];
    [self getTransactions];
    
    // Do any additional setup after loading the view.
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
    NSData *postData = [[NSData alloc] initWithData:[@"{\n    \"client_id\": \"5f18a1d2b89a9900124d8b90\",\n    \"secret\": \"bd12e8976f94de46e0bc5c46be2e27\",\n    \"access_token\": \"access-sandbox-d1ec736a-98dc-4af4-9ca6-7dab907e5207\",\n    \"start_date\": \"2020-01-01\",\n    \"end_date\": \"2020-08-08\",\n    \"options\": {\n        \"count\": 250,\n        \"offset\": 100\n    }\n}" dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];

    [request setHTTPMethod:@"POST"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"%@", error);
      } else {

          NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc]init];
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSError *parseError = nil;
        NSDictionary *responseDictionarytrans = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"%@",responseDictionarytrans[@"transactions"]);

          for( NSDictionary *trans in responseDictionarytrans[@"transactions"]){
              
         // NSArray *accTransactions = responseDictionarytrans[@"transactions"][0][@"category"];
              
              if ([categoryDictionary valueForKey:trans[@"category"][0]] == nil){
                  [categoryDictionary setValue:trans[@"amount"] forKey:trans[@"category"][0]];
              }
              else{
                  [categoryDictionary setValue:[NSNumber numberWithDouble:[[categoryDictionary valueForKey:trans[@"category"][0]] doubleValue]+[trans[@"amount"] doubleValue]] forKey:trans[@"category"][0]];
              }
    
          
          
          //NSLog(@"This is my category %@", trans[@"category"]);
          
          }
          NSLog(@"This is my dictionary %@",categoryDictionary);
          
          NSLog(@"Food and drink %@", categoryDictionary[@"Food and Drink"]);
          self.food_drink = [categoryDictionary[@"Food and Drink"] floatValue];
          self.payment = categoryDictionary[@"Payment"];
          self.recreation = categoryDictionary[@"Recreation"];
          self.transfer = categoryDictionary[@"Transfer"];
          self.travel = categoryDictionary[@"Travel"];
          
          NSLog(@"Fowl %f", self->_food_drink);
         // self.float1 = [_food_drink floatValue];
          //NSLog(@"floar %@", _food_drink);
         
        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);


}


       



-(void)pie{
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:605 color:PNBlue description:@"Food and Drink"],
          [PNPieChartDataItem dataItemWithValue:2103 color:PNRed description:@"Payment"],
        [PNPieChartDataItem dataItemWithValue:78 color:PNYellow description:@"Recreation"],[PNPieChartDataItem dataItemWithValue:6845 color:PNDeepGreen description:@"Transfer"],[PNPieChartDataItem dataItemWithValue:78 color:PNBrown description:@"Travel"]
                       
  ];
    
  self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake((CGFloat) (SCREEN_WIDTH / 2.0 - 150), 185, 250.0, 250.0) items:items];
  self.pieChart.descriptionTextColor = [UIColor whiteColor];
  self.pieChart.descriptionTextFont = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
  self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
  self.pieChart.showAbsoluteValues = NO;
  self.pieChart.showOnlyValues = NO;
  [self.pieChart strokeChart];

  self.pieChart.legendStyle = PNLegendItemStyleStacked;
  self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
  UIView *legend = [self.pieChart getLegendWithMaxWidth:250];
  [legend setFrame:CGRectMake(250, 500, legend.frame.size.width, legend.frame.size.height)];
  [self.view addSubview:legend];
  [self.view addSubview:self.pieChart];
    

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
