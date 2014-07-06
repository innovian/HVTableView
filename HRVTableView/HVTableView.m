//
//  HVTableView.m
//  HRVTableView
//
//  Created by Hamidreza Vakilian on 25/11/2013
//  Copyright (c) 2013 Hamidreza Vakilian. All rights reserved.
//  Website: http://www.infracyber.com/
//  Email:   xerxes235@yahoo.com
//

#import "HVTableView.h"

@implementation HVTableView
@synthesize HVTableViewDelegate, HVTableViewDataSource;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {		
		self.delegate = self;
		self.dataSource = self;
    }
    return self;
}


//////// IMPORTANT!!!!!!!!!!!!!!!!!!!!!
//////// UITableViewDataSource Protocol Forwarding
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [HVTableViewDataSource tableView:tableView numberOfRowsInSection:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [HVTableViewDataSource numberOfSectionsInTableView:tableView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if ([HVTableViewDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)])
	return [HVTableViewDataSource tableView:tableView titleForHeaderInSection:section];
		return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{	if ([HVTableViewDataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)])
	return [HVTableViewDataSource tableView:tableView titleForFooterInSection:section];
		return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{	if ([HVTableViewDataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)])
	return [HVTableViewDataSource tableView:tableView canEditRowAtIndexPath:indexPath];
	return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)])
	return [HVTableViewDataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
	return NO;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	if ([HVTableViewDataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)])
	return [HVTableViewDataSource sectionIndexTitlesForTableView:tableView];
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	if ([HVTableViewDataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)])
	return [HVTableViewDataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
	return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
	return [HVTableViewDataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	if ([HVTableViewDataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)])
	return [HVTableViewDataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell;
	
	if (self.expandOnlyOneCell)
	{
		if (actionToTake == 0) // e.g. the first time or an expanded cell from before gets in to view
		{
			if (selectedIndexPath)
				if (selectedIndexPath.row == indexPath.row && selectedIndexPath.section == indexPath.section)
				{
					cell = [HVTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded:YES];//i want it expanded
					return cell;
				}
			
			cell = [HVTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded:NO];
			
			return cell; //it's already collapsed!
		}
		
		cell = [HVTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded:NO];
		
		if(actionToTake == -1)
		{
			[HVTableViewDataSource tableView:tableView collapseCell:cell withIndexPath:indexPath];
			actionToTake = 0;
		}
		else
		{
			[HVTableViewDataSource tableView:tableView expandCell:cell withIndexPath:indexPath];
			actionToTake = 0;
		}
	}
	else
	{
		if (actionToTake == 0) // e.g. the first time or an expanded cell from before gets in to view
		{
			BOOL alreadyExpanded = NO;
			NSIndexPath* correspondingIndexPath;
			for (NSIndexPath* anIndexPath in expandedIndexPaths) {
				if (anIndexPath.row == indexPath.row && anIndexPath.section == indexPath.section)
				{alreadyExpanded = YES; correspondingIndexPath = anIndexPath;}
			}

			if (alreadyExpanded)
					cell = [HVTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded:YES];
			else
				cell = [HVTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded:NO];

			return cell; //it's already collapsed!

		}
		
		cell = [HVTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded:NO];
		
		if(actionToTake == -1)
		{
			[HVTableViewDataSource tableView:tableView collapseCell:cell withIndexPath:indexPath];
			actionToTake = 0;
		}
		else
		{
			[HVTableViewDataSource tableView:tableView expandCell:cell withIndexPath:indexPath];
			actionToTake = 0;
		}
	}
	
	return cell;
}

//////// IMPORTANT!!!!!!!!!!!!!!!!!!!!!
//////// IMPORTANT!!!!!!!!!!!!!!!!!!!!!
//////// IMPORTANT!!!!!!!!!!!!!!!!!!!!!
//////// IMPORTANT!!!!!!!!!!!!!!!!!!!!!
//////// IMPORTANT!!!!!!!!!!!!!!!!!!!!!
//////// UITableViewDelegate Protocol Forwarding
//////// NOTE::::: If you want to use any of these protocols in your code; you must uncomment it. I have comment them for performance reasons
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
		[HVTableViewDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)])
		[HVTableViewDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)])
		[HVTableViewDelegate tableView:tableView willDisplayFooterView:view forSection:section];
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)])
		[HVTableViewDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)])
		[HVTableViewDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)])
		[HVTableViewDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
		return [HVTableViewDelegate tableView:tableView heightForHeaderInSection:section];
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)])
		return [HVTableViewDelegate tableView:tableView heightForFooterInSection:section];
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0)
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)])
		return [HVTableViewDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
	return 100;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)])
		return [HVTableViewDelegate tableView:tableView estimatedHeightForHeaderInSection:section];
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)])
		return [HVTableViewDelegate tableView:tableView estimatedHeightForFooterInSection:section];
	return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)])
		return [HVTableViewDelegate tableView:tableView viewForHeaderInSection:section];
	return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)])
		return [HVTableViewDelegate tableView:tableView viewForFooterInSection:section];
	return nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)])
		[HVTableViewDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)])
		return [HVTableViewDelegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
	return YES;
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)])
		[HVTableViewDelegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)])
		[HVTableViewDelegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)])
		return [HVTableViewDelegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
	return nil;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)])
		[HVTableViewDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)])
		return [HVTableViewDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
	return UITableViewCellEditingStyleNone;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)])
		return [HVTableViewDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
	return nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)])
		return [HVTableViewDelegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
	return NO;
}
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)])
		[HVTableViewDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)])
		[HVTableViewDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)])
		return [HVTableViewDelegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
	return nil;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)])
		return [HVTableViewDelegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
	return 0;
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)])
		return [HVTableViewDelegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
	return YES;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)])
		return [HVTableViewDelegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
	return NO;
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	if ([HVTableViewDelegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)])
		return [HVTableViewDelegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
}
*/

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.expandOnlyOneCell)
	{
		if (selectedIndexPath)
		if(selectedIndexPath.row == indexPath.row && selectedIndexPath.section == indexPath.section)
			return [HVTableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath isExpanded:YES];
		
		return [HVTableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath isExpanded:NO];
	}
	else
	{
		BOOL alreadyExpanded = NO;
		NSIndexPath* correspondingIndexPath;
		for (NSIndexPath* anIndexPath in expandedIndexPaths) {
			if (anIndexPath.row == indexPath.row && anIndexPath.section == indexPath.section)
			{alreadyExpanded = YES; correspondingIndexPath = anIndexPath;}
		}
		if (alreadyExpanded)
			return [HVTableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath isExpanded:YES];
		else
			return [HVTableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath isExpanded:NO];
	}
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
		return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (self.expandOnlyOneCell)
	{
		if (selectedIndexPath)
		if (selectedIndexPath.row != -1 && selectedIndexPath.row != -2) //collapse the last expanded item (if any)
		{
			BOOL dontExpandNewCell = NO;
			if (selectedIndexPath.row == indexPath.row && selectedIndexPath.section == indexPath.section)
				dontExpandNewCell = YES;
			
			NSIndexPath* tmp = [NSIndexPath indexPathForRow:selectedIndexPath.row inSection:selectedIndexPath.section];//tmp now holds the last expanded item
			selectedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
			
			actionToTake = -1;
			
			[tableView beginUpdates];
			[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tmp] withRowAnimation:UITableViewRowAnimationAutomatic];
			[tableView endUpdates];
			
			if (dontExpandNewCell) return; //the same expanded cell was touched and now I collapsed it. No new cell is touched
		}
		
		actionToTake = 1;
		///expand the new touched item
		
		selectedIndexPath = indexPath;
		[tableView beginUpdates];
		[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		[tableView endUpdates];
		if (self.enableAutoScroll)
			[tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
		
	}
	else
	{
		BOOL alreadyExpanded = NO;
		NSIndexPath* correspondingIndexPath;
		for (NSIndexPath* anIndexPath in expandedIndexPaths) {
			if (anIndexPath.row == indexPath.row && anIndexPath.section == indexPath.section)
			{alreadyExpanded = YES; correspondingIndexPath = anIndexPath;}
		}
		
		if (alreadyExpanded)////collapse it!
		{
			actionToTake = -1;
			[expandedIndexPaths removeObject:correspondingIndexPath];
			[tableView beginUpdates];
			[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
			[tableView endUpdates];
		}
		else ///expand it!
		{
			actionToTake = 1;
			[expandedIndexPaths addObject:indexPath];			
			[tableView beginUpdates];
			[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
			[tableView endUpdates];
			if (self.enableAutoScroll)
				[tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
		}
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
