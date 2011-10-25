//
//  Inflector.m
//  RailsLogin
//
//  Created by Brian Celenza on 10/25/11.
//  Copyright (c) 2011 Millennium Dreamworks. All rights reserved.
//

#import "Inflector.h"

@implementation Inflector

+ (NSString *)humanize:(NSString *)string
{
    NSString *result = string;
    NSError *error = NULL;
    
    // first, replace underscores with spaces
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"_+" options:0 error:&error];
    
    // fail silently
    if(regex == nil) {
        return result;
    }
    result = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@" "];
    
    // next, capitalize the first letter in the string and ensure lowercase for the rest
    result = [[result lowercaseString] stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[result substringToIndex:1] uppercaseString]];
    
    // return the result
    return result;
}

@end
