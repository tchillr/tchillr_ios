//
//  TCTheme.m
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTheme.h"
#import "TCTag.h"

#define kThemeTitleKey @"title"
#define kThemeIdentifierKey @"identifier"
#define kThemeTagsKey @"tags"


@implementation TCTheme

- (NSString *)title {
    return (NSString *)[self.jsonDictionary objectForKey:kThemeTitleKey];
}

- (NSArray *)tags {
    NSMutableArray * tagsArray = [[NSMutableArray alloc]init];
    NSArray * tags = (NSArray *)[self.jsonDictionary objectForKey:kThemeTagsKey];
    
    for (NSDictionary * tagsDict in tags) {
        TCTag * tag = [[TCTag alloc]initWithJsonDictionary:tagsDict];
        [tagsArray addObject:tag];
    }
    return [NSArray arrayWithArray:tagsArray];
}

- (NSNumber *)identifier {
    return (NSNumber *)[self.jsonDictionary objectForKey:kThemeIdentifierKey];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Id : %@, title : %@",self.identifier, self.title];
}

#pragma mark Tag Access 
- (TCTag *)tagAtIndex:(NSInteger)index{
    return [self.tags objectAtIndex:index];
}


@end
