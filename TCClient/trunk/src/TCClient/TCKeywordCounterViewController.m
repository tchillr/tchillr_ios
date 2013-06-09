//
//  TCKeywordCounterViewController.m
//  TCClient
//
//  Created by Jad on 06/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCKeywordCounterViewController.h"
#import "TCTchillrServerClient.h"
#import "TCActivity.h"
#import "TCKeyword.h"
#import "TCActivityTableViewCell.h"

@interface TCKeywordCounterViewController ()

@property (nonatomic, retain) NSArray * activities;
@property (nonatomic, retain) NSArray * keywords;
@property (nonatomic, retain) IBOutlet UITableView * tableView;

@end

@implementation TCKeywordCounterViewController

@synthesize activities = _activities;
- (NSArray *)activities {
    if (_activities == nil) {
        _activities = [[NSArray alloc] init];
    }
    return _activities;
}

@synthesize keywords = _keywords;
- (NSArray *)keywords {
    if (_keywords == nil) {
        _keywords = [[NSArray alloc] init];
    }
    return _keywords;
}

#pragma mark Keyword counter
- (NSArray *)countWords{
	// 01. Enumerate all the words in the text and put them in an array
	NSMutableArray *words = [NSMutableArray array];
    
    for (TCActivity * activity in self.activities) {
        [words addObjectsFromArray:activity.keywords];    
    }


	// 02. Count the occurrences of each word
	NSMutableArray *wordCounts = [NSMutableArray array];
	for (int i = 0; i < [words count]; i++) {
        TCKeyword * kWord = (TCKeyword *) [words objectAtIndex:i];
		NSUInteger wordIndex = [wordCounts indexOfObjectPassingTest:^BOOL(TCKeyword *keyword, NSUInteger idx, BOOL *stop) {
			return [keyword.word compare:kWord.word options:NSCaseInsensitiveSearch] == NSOrderedSame;
		}];
		if (wordIndex != NSNotFound) {
			TCKeyword *keyword = [wordCounts objectAtIndex:wordIndex];
			keyword.weight += kWord.weight;
		}
		else {
			TCKeyword *keyword = [[TCKeyword alloc] initWithWord:kWord.word andWeight:kWord.weight];
			[wordCounts addObject:keyword];
		}
	}
	
	// 02. Sort the words from the most occurent to the less occurent
	[wordCounts sortUsingComparator:^NSComparisonResult(TCKeyword *keyword1, TCKeyword *keyword2) {
		if (keyword1.weight != keyword2.weight) {
			return keyword1.weight < keyword2.weight;
		}
		else {
			return [keyword1.word compare:keyword2.word options:NSCaseInsensitiveSearch];
		}
	}];
	
	return [NSArray arrayWithArray:wordCounts];
}


#pragma mark Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    [[TCTchillrServerClient sharedTchillrServerClient] startActivitiesRequestWithSuccess:^(NSArray *activitiesArray) {
        self.activities = activitiesArray;
        self.keywords = [self countWords];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    } offset:0 limit:1000];
     */

}
#pragma mark Keyword Access

- (NSUInteger)numberOfKeywords {
    return [self.keywords count];
}

- (TCKeyword *)keywordAtIndex:(NSUInteger)index {
    return (TCKeyword*)[self.keywords objectAtIndex:index];
}

#pragma mark - UITableViewDataSource / Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfKeywords];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityTableViewCellIdentifier"];
    TCKeyword * keyword = [self keywordAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"Hits:(%i) / %@",keyword.weight,keyword.word]];
    NSLog(@"%@",keyword.word);
    
    return cell;
}

@end
