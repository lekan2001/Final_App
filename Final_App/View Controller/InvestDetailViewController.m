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
    // Do any additional setup after loading the view.

  //  NSLog(@"%@", self.result[@"longName"]);
    
//    self.stockFullName.text = self.result[@"symbol"];
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
