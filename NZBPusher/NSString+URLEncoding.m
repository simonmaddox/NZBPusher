//
//  NSString+URLEncoding.m
//  NZBPusher
//
//  Created by Simon Maddox on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+URLEncoding.h"


@implementation NSString (NSString_URLEncoding)

- (NSString *) urlEncodedString
{
	NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																				   NULL,
																				   (CFStringRef)self,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8 );
	
	return [encodedString autorelease];
}

@end
