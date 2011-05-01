//
//  SearchViewController.m
//  NZBPusher
//
//  Created by Simon Maddox on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"

#import "WebViewController.h"

#import "NSString+URLEncoding.h"

@implementation SearchViewController
@synthesize searchField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
	[searchField release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Search for NZB";
}

- (void)viewDidUnload
{
	[self setSearchField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)search {
	WebViewController *webViewController = [[WebViewController alloc] init];
	[webViewController setSearchString:[self.searchField.text urlEncodedString]];
	[self.navigationController pushViewController:webViewController animated:YES];
	[webViewController release];
}

@end
