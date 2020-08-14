//
//  SavedReceiptsViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 8/4/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "SavedReceiptsViewController.h"
#import "Receipt.h"
#import <Parse/Parse.h>
#import "SavedReceiptsCellCollectionViewCell.h"

@interface SavedReceiptsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *receiptSavedView;
@property (nonatomic, strong) NSArray *userReceipts;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *receiptsActivity;
@property(nonatomic, strong)UIRefreshControl *refreshControl;
@end

@implementation SavedReceiptsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchReceipts];
    [self setReceipt:_receipt];
    self.receiptSavedView.dataSource = self;
    self.receiptSavedView.delegate = self;
    self.receiptsActivity = [[UIActivityIndicatorView alloc] init];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.receiptSavedView.collectionViewLayout;
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing =5;
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = (self.receiptSavedView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    
    CGFloat itemHeight = itemWidth*1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
}



-(void)fetchReceipts{
    [self.receiptsActivity startAnimating];
    PFQuery *query = [PFQuery queryWithClassName:@"Receipt"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    query.limit = 25;
    __weak typeof (self)weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *receipts, NSError *error) {
        if (receipts != nil) {
            self.userReceipts = receipts;
            [self.receiptSavedView reloadData];
        }
        else{
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
        [self.receiptsActivity stopAnimating];
    }];
    [weakSelf.receiptSavedView reloadData];
   
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SavedReceiptsCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReceiptCollectionCell" forIndexPath:indexPath];
   
    
    Receipt *receiptt = self.userReceipts[indexPath.item];
    cell.receiptImage.file = receiptt.receiptimage;
    [cell.receiptImage loadInBackground];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userReceipts.count;
}


@end
