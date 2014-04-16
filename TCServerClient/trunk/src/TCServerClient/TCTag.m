//
//  TCTag.m
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTag.h"
#define kTagTitleKey @"title"
#define kTagWeightKey @"weight"
#define kTagIdentifierKey @"identifier"
#define kTagThemeIdentifierKey @"themeID"

@implementation TCTag

#pragma mark Accessors
- (NSString *)title {
    return (NSString *)[self.jsonDictionary objectForKey:kTagTitleKey];
}

- (NSInteger)weight {
    return [(NSString *)[self.jsonDictionary objectForKey:kTagWeightKey] intValue];
}

- (NSNumber*)identifier {
    return (NSNumber *)[self.jsonDictionary objectForKey:kTagIdentifierKey];
}

- (NSNumber*)themeIdentifier {
    return (NSNumber *)[self.jsonDictionary objectForKey:kTagThemeIdentifierKey];
}

#pragma mark Color style from theme ID
- (TCActivityColorStyle)colorStyle {
    TCActivityColorStyle style;
    switch ([self.themeIdentifier intValue]) {
        case 1:
            style = TCActivityColorStyleMusique;
            break;
        case 2:
            style = TCActivityColorStyleActivites;
            break;
        case 4:
            style = TCActivityColorStyleEvenements;
            break;
        case 5:
            style = TCActivityColorStyleNature;
            break;
        case 6:
            style = TCActivityColorStyleCulture;
            break;
        case 7:
            style = TCActivityColorStyleSpectacles;
            break;
        default:
            style = TCActivityColorStyleNone;
            break;
    }
    return style;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@:%p] - title : %@, weight : %l, identifier : %@, themeIdentifier : %@",NSStringFromClass([self class]),self,self.title,self.weight,self.identifier,self.themeIdentifier];
}

@end
