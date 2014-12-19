//
//  rootViewController.m
//  HRVTableView
//
//  Created by Hamidreza Vakilian on 25/11/2013
//  Copyright (c) 2013 Hamidreza Vakilian. All rights reserved.
//  Website: http://www.infracyber.com/
//  Email:   xerxes235@yahoo.com
//

// ***************************   MUST READ   ******************************************************
//
// This is a working example of HVTableView class. I used some stock photos to present it
//		in a more fantastic way, So please don't use any of included jpegs in this project anywhere.
//
//	I didn't subclass a UITableViewCell. As you will see I will create the "purchase now!" button and
//		I remove very soon. This is not the best way. You would better off subclassing UITableViewCell
//		and reuse the subviews on the cell, not recreating each time it appears. I didn't have much time
//		to do that for simple example. Just to show you, how easily you can work with HVTableView and
//		use it in your apps.
//
// *************************************************************************************************


#import "rootViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController

- (void)viewDidLoad {
    self.table.HVTableViewDataSource = self;
    self.table.HVTableViewDelegate = self;
    
    ////////////storing the title labels in an array so we will use it in cellForRowAtIndexPath
    cellTitles = @[@"Twitowie", @"Bill Greyskull", @"Moonglampers", @"Psit", @"Duncan WJ Palmer", @"Sajuma", @"Victor_lee", @"Jugger-naut", @"Javiersanagustin", @"Velouria!"];
}

//perform your expand stuff (may include animation) for cell here. It will be called when the user touches a cell
-(void)tableView:(UITableView *)tableView expandCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
	UILabel *detailLabel = (UILabel *)[cell viewWithTag:3];
    UIButton *purchaseButton = (UIButton *)[cell viewWithTag:10];
	purchaseButton.alpha = 0;
    purchaseButton.hidden = NO;
	
	[UIView animateWithDuration:.5 animations:^{
		detailLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
		purchaseButton.alpha = 1;
		[cell.contentView viewWithTag:7].transform = CGAffineTransformMakeRotation(3.14);
	}];
}

//perform your collapse stuff (may include animation) for cell here. It will be called when the user touches an expanded cell so it gets collapsed or the table is in the expandOnlyOneCell satate and the user touches another item, So the last expanded item has to collapse
-(void)tableView:(UITableView *)tableView collapseCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
	UILabel *detailLabel = (UILabel *)[cell viewWithTag:3];
    UIButton *purchaseButton = (UIButton *)[cell viewWithTag:10];
	
	[UIView animateWithDuration:.5 animations:^{
		detailLabel.text = @"Lorem ipsum dolor sit amet";
		purchaseButton.alpha = 0;
		[cell.contentView viewWithTag:7].transform = CGAffineTransformMakeRotation(-3.14);
	} completion:^(BOOL finished) {
        purchaseButton.hidden = YES;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
{
	//you can define different heights for each cell. (then you probably have to calculate the height or e.g. read pre-calculated heights from an array
	if (isexpanded)
		return 200;
	
	return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded
{
	static NSString *CellIdentifier = @"Content1";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
	UILabel *textLabel = (UILabel *)[cell viewWithTag:2];
	UILabel *detailLabel = (UILabel *)[cell viewWithTag:3];
    UIButton *purchaseButton = (UIButton *)[cell viewWithTag:10];
	
	//alternative background colors for better division ;)
	if (indexPath.row %2 ==1)
		cell.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
	else
		cell.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1];
	
	textLabel.text = [cellTitles objectAtIndex:indexPath.row % 10];
	NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
	NSString* imageFileName = [NSString stringWithFormat:@"%ld.jpg", indexPath.row % 10 + 1];
	imageView.image = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", bundlePath, imageFileName]];
	
	if (!isExpanded) //prepare the cell as if it was collapsed! (without any animation!)
	{
		detailLabel.text = @"Lorem ipsum dolor sit amet";
		[cell.contentView viewWithTag:7].transform = CGAffineTransformMakeRotation(0);
        purchaseButton.hidden = YES;
	}
	else ///prepare the cell as if it was expanded! (without any animation!)
	{
		detailLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
		[cell.contentView viewWithTag:7].transform = CGAffineTransformMakeRotation(3.14);
		purchaseButton.hidden = NO;
	}
	return cell;
}

@end
