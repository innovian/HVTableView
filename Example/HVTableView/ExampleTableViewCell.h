//
//  ExampleTableViewCell.h
//  HVTableView
//
//  Created by Parastoo Tabatabayi on 10/29/16.
//  Copyright © 2016 ParastooTb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExampleTableViewCell;

@protocol ExampleTableViewCellDelegate <NSObject>

-(void)ExampleTableViewCellDidTapPurchaseButton:(ExampleTableViewCell*)cell;

@end

@interface ExampleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *purchaseButton;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
- (IBAction)purchaseButtonDidTap:(id)sender;

@property (weak, nonatomic) id<ExampleTableViewCellDelegate> delegate;


+(NSString*)cellIdentifier;

@end
