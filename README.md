<<<<<<< HEAD
//
//***************	HVTableView - UITableView with expand/collapse feature   *****************************
//					by hamidreza vakilian
//
//
//	This is a subclass of UITableView with expand/collapse feature that may come so handy in many apps.
//	The developer can save a lot of time using an expand/collapse tableView instead of creating a detail viewController for
//		every cell. I mean the details of each cell can be displayed immediately on the same table without switching to
//		another view. On the other hand in my opinion it far more impressive and eye-catching from a regular user's view.
//
//		To create an instance of HVTableView you go by code.
//      (currently I you can't do it from xib - I will work on that later)
//		That's simple as:
//
//			HVTableView* myTable = [[HVTableView alloc] initWithFrame:CGRectMake(84, 250, 600, 600) expandOnlyOneCell:NO enableAutoScroll:YES];
//			myTable.HVTableViewDelegate = self;
//			myTable.HVTableViewDataSource = self;
//			[myTable reloadData];
//			[self.view addSubview:myTable];

//	Two important parameters when initializing the HVTableView
//		if expandOnlyOneCell==TRUE: Just one cell will be expanded at a time.
//		if expandOnlyOneCell==FALSE: multiple cells can be expanded at a time
//
//		if enableAutoScroll==TRUE: when the user touches a cell, the HVTableView will automatically scroll to it
//		if enableAutoScroll==FALSE: when the user touches a cell, the HVTableView won't scroll. but the if the cell was close to the bottom of the table; the lower part of it may go invisible because it grows
//
//
//	Your viewController must conform to HVTableViewDelegate, HVTableViewDataSource protocols. Just like the regular
//			UITableView
//
//	Like before you implement these familiar delegate functions:
//		-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//		-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//
//	I added a boolean parameter the heightForRowAtIndexPath function so you will return different values for an expanded or a collapsed cell.
//	(isExpanded==TRUE: return the size of the cell in expanded state)
//	(isExpanded==FALSE: return the size of the cell in collapsed (initial) state)
//
//		-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
//
//
// I also added a boolean parameter to the cellForRowAtIndexPath function too. update the cell's content respecting it's state (isExpanded)
//		-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded
//
//
//	Now the interesting functions are here. Implement this function and it will be fired when a cell is going to expand. You can perform your drawings, animations, etc. in this function:
//		-(void)tableView:(UITableView *)tableView collapseCell: (UITableViewCell*)cell withIndexPath:(NSIndexPath*) indexPath;
//
//  Implement this function. it will be fired when a cell is going to collapse. You can perform your drawings, animations, etc. or clearing up the cell in this function:
//		-(void)tableView:(UITableView *)tableView expandCell: (UITableViewCell*)cell withIndexPath:(NSIndexPath*) indexPath;
//
// IMPORTANT NOTE: there are some delegate functions from UITableViewDelegate that I have commented their forwarding. If you need to implement those on your viewController or smth, go to HVTableView.m and uncomment those delegate functions. If you don't uncomment them; your delegate functions won't fire up.
//
//
//	This code may contain bugs. I don't garauntee its functionality, but use it on your own risk. I also tried to craft it with best performance, yet it can be optimized more.
//
//
//	Please don't hesitate to mail me your feedbacks and suggestions or a bug report. I would be very thankful of your responses.
//
//	ON THE BOTTOM LINE: I allow you to use my code in your applications with freedom in making any modifications, but if you are going to do so, or you just like it and want further updates and bug fixes please consider donating me via this url:
//	https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=xerxes235%40yahoo%2ecom&lc=AE&item_name=Hamidreza%20Vakilian&item_number=HVTableView%20donation&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted
//
//
//	Thanks,....
// ***************************************************************************************************************
=======
HVTableView
===========

UITableView with expand/collapse feature
>>>>>>> 42ac049e49a1c5ddf408709ad45be816e32b776e
