//
//  WebViewController.h
//  NZBPusher
//
//  Created by Simon Maddox on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController {
    
	UIWebView *mainWebView;
	
	NSInteger spinnerCounter;
}

@property (nonatomic, retain) IBOutlet UIWebView *mainWebView;

@property (nonatomic, retain) NSString *searchString;

@property (nonatomic) NSInteger spinnerCounter;

@property (nonatomic, retain) NSDictionary *settings;

@end
