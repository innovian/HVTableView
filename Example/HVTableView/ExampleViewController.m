//
//  ExampleViewController.m
//  HVTableView
//
//  Created by ParastooTb on 10/29/2016.
//  Copyright (c) 2016 ParastooTb. All rights reserved.
//

#import "ExampleViewController.h"
#import "ExampleTableViewCell.h"

@interface ExampleViewController () <HVTableViewDataSource, HVTableViewDelegate, ExampleTableViewCellDelegate> {
    NSArray* cellTitles;
}

@end

@implementation ExampleViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.table.HVTableViewDelegate = self;
    self.table.HVTableViewDataSource = self;
        cellTitles = @[@"Twitowie", @"Bill Greyskull", @"Moonglampers", @"Psit", @"Duncan WJ Palmer", @"Sajuma", @"Victor_lee", @"Jugger-naut", @"Javiersanagustin", @"Velouria!"];
}

-(void)tableView:(UITableView *)tableView expandCell:(ExampleTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    
    
//    UILabel *detailLabel = (UILabel *)[cell viewWithTag:3];
//    UIButton *purchaseButton = (UIButton *)[cell viewWithTag:10];
    cell.purchaseButton.alpha = 0;
//    cell.purchaseButton.hidden = NO;
    
    [UIView animateWithDuration:.5 animations:^{
        cell.detailLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
        cell.purchaseButton.alpha = 1;
        cell.arrow.transform = CGAffineTransformMakeRotation(0);
    }];
    
}

-(void)tableView:(UITableView *)tableView collapseCell:(ExampleTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
//    UILabel *detailLabel = (UILabel *)[cell viewWithTag:3];
//    UIButton *purchaseButton = (UIButton *)[cell viewWithTag:10];
    
        cell.purchaseButton.alpha = 0;
            cell.arrow.transform = CGAffineTransformMakeRotation(0);
            cell.detailLabel.text = @"Lorem ipsum dolor sit ame";
    
    [UIView animateWithDuration:.5 animations:^{

//        detailLabel.text = @"Lorem ipsum dolor sit amet";
        cell.arrow.transform = CGAffineTransformMakeRotation(-M_PI+0.00);
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded{
    
//    static NSString* CellIdentifier = @"Content1";
    ExampleTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:[ExampleTableViewCell cellIdentifier]];
    cell.delegate = self;

//    UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
//    UILabel* textLabel = (UILabel*)[cell viewWithTag:2];
//    UILabel* detailLabel= (UILabel*)[cell viewWithTag:3];
//    UIButton* purchaseButton= (UIButton*)[cell viewWithTag:10];
    
    if (indexPath.row %2 ==1)
        cell.backgroundColor = [UIColor colorWithRed:.96 green:.96 blue:.96 alpha:1];
    else
        cell.backgroundColor = [UIColor whiteColor];
    
    cell.titlesLabel.text = [cellTitles objectAtIndex:indexPath.row % 10];
//    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString* imageFileName = [NSString stringWithFormat:@"%ld.jpg", indexPath.row % 10 + 1];
//    cell.theImageView.image = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", bundlePath, imageFileName]];
    cell.theImageView.image = [UIImage imageNamed:imageFileName];

    

    if (!isExpanded) {
        cell.detailLabel.text = @"Lorem ipsum dolor sit amet";
        cell.arrow.transform = CGAffineTransformMakeRotation(M_PI);
        cell.purchaseButton.alpha = 0;
    }
    else
    {
        cell.detailLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
        cell.arrow.transform = CGAffineTransformMakeRotation(0);
        cell.purchaseButton.alpha = 1;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
{
    if (isexpanded)
        return 150;
    
    return 60;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)ExampleTableViewCellDidTapPurchaseButton:(ExampleTableViewCell *)cell
{
    NSString *alertTitle = [NSString stringWithFormat:@"'%@' Purchased Successfully.", cell.titlesLabel.text];
    UIAlertController* purchaseAlert = [UIAlertController alertControllerWithTitle:nil message: alertTitle preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:purchaseAlert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [purchaseAlert dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
