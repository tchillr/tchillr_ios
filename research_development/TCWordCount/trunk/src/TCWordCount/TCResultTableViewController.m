//
//  TCResultTableViewController.m
//  TCWordCount
//
//  Created by Zouhair on 04/06/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import "TCResultTableViewController.h"
#import "TCWordCount.h"

@implementation TCResultTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.wordCounts count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WordCellIdentifier"];
	
	TCWordCount *wordCount = [self.wordCounts objectAtIndex:indexPath.row];
	
	[cell.textLabel setText:wordCount.word];
	[cell.detailTextLabel setText:[NSString stringWithFormat:@"%d", wordCount.count]];
	
	return cell;
}

@end
