//
//  rootViewController.h
//  HRVTableView
//
//  Created by Hamidreza Vakilian on 25/11/2013
//  Copyright (c) 2013 Hamidreza Vakilian. All rights reserved.
//  Website: http://www.infracyber.com/
//  Email:   xerxes235@yahoo.com
//

#import <UIKit/UIKit.h>
#import "HVTableView.h"


@interface rootViewController : UIViewController <HVTableViewDelegate, HVTableViewDataSource> {
	NSArray *cellTitles;
}

@property (weak, nonatomic) IBOutlet HVTableView *table;

@end
