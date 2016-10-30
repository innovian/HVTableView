# HVTableView

[![CI Status](http://img.shields.io/travis/ParastooTb/HVTableView.svg?style=flat)](https://travis-ci.org/ParastooTb/HVTableView)
[![Version](https://img.shields.io/cocoapods/v/HVTableView.svg?style=flat)](http://cocoapods.org/pods/HVTableView)
[![License](https://img.shields.io/cocoapods/l/HVTableView.svg?style=flat)](http://cocoapods.org/pods/HVTableView)
[![Platform](https://img.shields.io/cocoapods/p/HVTableView.svg?style=flat)](http://cocoapods.org/pods/HVTableView)

[![HVTableView Example](https://raw.githubusercontent.com/innovian/HVTableView/master/Screens/animation.gif)](https://raw.githubusercontent.com/innovian/HVTableView/master/Screens/animation.gif)

###### UITableView with expand/collapse feature

####Developers
- Hamidreza Vakilian
- Parastoo Tabatabaei

####Contributors
- Gavy Aggarwal (Storyboard Support)

------

###Summary
This is a subclass of **UITableView** with expand/collapse feature that comes useful in many scenarios.	The developer can save a lot of time using an expand/collapse tableView instead of creating a detail viewController for each cell. Consequently the details of each cell can be displayed right on the same table without switching to another view.

###Usage
Create a **UITableView** in Storyboard or your nib file and change its class to  **HVTableView**. In the attributes inspector you can set **expandOnlyOneCell** and **enableAutoScroll** properties. Also, in the storyboard connect **HVTableViewDelegate** and **HVTableViewDataSource** to the file owner.

**expandOnlyOneCell** and **enableAutoScroll** description:

	expandOnlyOneCell==TRUE: Just one cell will be expanded at a time.
	expandOnlyOneCell==FALSE: multiple cells can be expanded at a time

	enableAutoScroll==TRUE: when the user touches a cell, the HVTableView will automatically scroll to it
	enableAutoScroll==FALSE: when the user touches a cell, the HVTableView won't scroll.


Your viewController must conform to **HVTableViewDelegate** and **HVTableViewDataSource** protocols.
Like UITableView you implement these familiar delegate functions:

	-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
	-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

We added a boolean parameter the **heightForRowAtIndexPath** function so you will have to calculate different values for expand and collapse states.

	-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded
	(isExpanded==TRUE: return the size of the cell in expanded state)
	(isExpanded==FALSE: return the size of the cell in collapsed (initial) state)

We also added a boolean parameter to the **cellForRowAtIndexPath** function too. update the cell's content respecting it's state (isExpanded):

	-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded


Now the interesting functions are as follows. Implement *tableView:collapseCell:withIndexPath* and it will be fired when a cell is going to expand. You can perform your drawings, animations, etc. in this delegate method:

	-(void)tableView:(UITableView *)tableView collapseCell: (UITableViewCell*)cell withIndexPath:(NSIndexPath*) indexPath;

The counterpart comes here. It will be fired when a cell is going to collapse. You can perform your drawings, animations, etc. or clearing up the cell in this function:

	-(void)tableView:(UITableView *)tableView expandCell: (UITableViewCell*)cell withIndexPath:(NSIndexPath*) indexPath;

*IMPORTANT NOTE: there are some delegate functions from UITableViewDelegate that we have commented their proxy in **HVTableView.m**. If you need to implement those on your viewController, go to **HVTableView.m** and uncomment those delegate methods. If you don't uncomment them; your delegate methods won't fire up.*

###Pros
If you’re looking for a straight forward easy-to-setup library for expandable views, HVTableView is your choice. It provides an acceptable performance which is sufficient for using in regular projects.

###Cons
Expanding a UITableViewCell requires a call to **reloadRowsAtIndexPaths:withRowAnimation:** which in turn forces the TableView to reload the cell, thereafter we will change the height for the corresponding cell. That’s why a slight flashing occurs when the cell is animating which is unpreventable due to UITableView limitations. If you’re looking for a more-professional expandable view, we suggest [HyperTreeView](http://github.com/innovian/HyperTreeView), a subclass of UIScrollView which provides super-smooth expansion/collapse for nodes while it supports hierarchical structures.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

HVTableView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HVTableView"
```

## Author
[Innovian](http://innovian.com)

## License

HVTableView is available under the MIT license. See the LICENSE file for more info.
