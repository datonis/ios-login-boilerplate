//
//  RailsUtils.m
//  RailsLogin
//
//  Created by Brian Celenza on 10/25/11.
//  Copyright (c) 2011 Millennium Dreamworks. All rights reserved.
//

#import "RailsUtils.h"
#import "Inflector.h"
#import "SBJson.h"

@implementation RailsUtils

+ (NSArray *)errorsArrayFromJson:(NSString *)jsonString
{
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *errorsDict = [jsonParser objectWithString:jsonString];
    
    NSArray *errorsArray = [[[NSArray alloc] init] autorelease];
    for (NSString *key in errorsDict) {
        NSString *humanizedKey = [Inflector humanize:key];
        NSArray *errorMessages = [errorsDict objectForKey:key];
        int errorsCount = [errorMessages count];
        for (int i = 0; i < errorsCount; i++) {
            errorsArray = [errorsArray arrayByAddingObject:[NSString stringWithFormat:@"%@ %@", humanizedKey, [errorMessages objectAtIndex:i]]];
        }
    }
    
    // cleanup memory
    [jsonParser release];
    
    return errorsArray;
}

+ (NSString *)stringFromErrorsArray:(NSArray *)errors
{
    NSString *result = [[[NSString alloc] init] autorelease];
    int errorsCount = [errors count];
    for (int i = 0; i < errorsCount; i++) {
        NSString *error = [errors objectAtIndex:i];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"- %@\n", error]];
    }
    
    return result;
}

@end
