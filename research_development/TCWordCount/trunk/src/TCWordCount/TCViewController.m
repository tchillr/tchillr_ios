//
//  TCViewController.m
//  TCWordCount
//
//  Created by Zouhair on 04/06/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import "TCViewController.h"
#import "TCResultTableViewController.h"

#import "TCWordCount.h"

@interface TCViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
- (NSArray *)countWords:(NSString *)text;

@end

@implementation TCViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.textView setText:@"Bonjour Monsieur le Prince. Comment va votre femme ? Est-elle toujours enceinte ? Et l'autre enfant, comment va-t'il ?"];
}

- (NSArray *)countWords:(NSString *)text {
	// 01. Enumerate all the words in the text and put them in an array
	NSMutableArray *words = [NSMutableArray array];
	
	[text enumerateLinguisticTagsInRange:NSMakeRange(0, [text length])
								  scheme:NSLinguisticTagSchemeTokenType
								 options:NSLinguisticTaggerOmitWhitespace|NSLinguisticTaggerOmitPunctuation|NSLinguisticTaggerOmitOther
							 orthography:nil
							  usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
								  NSString *token = [text substringWithRange:tokenRange];
								  if ([tag isEqualToString:NSLinguisticTagWord] && [token length] > 2) {
									  [words addObject:token];
								  }
							  }];
	
	// 02. Count the occurrences of each word
	NSMutableArray *wordCounts = [NSMutableArray array];
	for (NSString *word in words) {
		NSUInteger wordIndex = [wordCounts indexOfObjectPassingTest:^BOOL(TCWordCount *wordCount, NSUInteger idx, BOOL *stop) {
			return [wordCount.word compare:word options:NSCaseInsensitiveSearch] == NSOrderedSame;
		}];
		if (wordIndex != NSNotFound) {
			TCWordCount *wordCount = [wordCounts objectAtIndex:wordIndex];
			wordCount.count++;
		}
		else {
			TCWordCount *wordCount = [[TCWordCount alloc] initWithWord:word];
			wordCount.count++;
			[wordCounts addObject:wordCount];
		}
	}
	
	
	// 02. Sort the words from the most occurent to the less occurent
	[wordCounts sortUsingComparator:^NSComparisonResult(TCWordCount *wordCount1, TCWordCount *wordCount2) {
		if (wordCount1.count != wordCount2.count) {
			return wordCount1.count < wordCount2.count;
		}
		else {
			return [wordCount1.word compare:wordCount2.word options:NSCaseInsensitiveSearch];	
		}
	}];
	
	return [NSArray arrayWithArray:wordCounts];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	[self.textView resignFirstResponder];
	if ([segue.identifier isEqualToString:@"processTextSegue"]) {
		TCResultTableViewController *viewController = segue.destinationViewController;
		[viewController setWordCounts:[self countWords:self.textView.text]];
	}
}

@end
