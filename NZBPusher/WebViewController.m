//
//  WebViewController.m
//  NZBPusher
//
//  Created by Simon Maddox on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

#import "ASIHTTPRequest.h"

#define SearchExtension @"nzb"

@interface WebViewController () <ASIHTTPRequestDelegate>
- (void) downloadFile:(NSURL *)url;
@end

@implementation WebViewController
@synthesize mainWebView, searchString, spinnerCounter, settings;

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
	[self removeObserver:self forKeyPath:@"spinnerCounter"];
	
    [mainWebView release];
	self.searchString = nil;
	self.settings = nil;
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
	
	self.spinnerCounter = 0;
	
	self.settings = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"]];
	
	[self addObserver:self forKeyPath:@"spinnerCounter" options:NSKeyValueObservingOptionNew context:nil];
			
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://nzbindex.nl/search/?q=%@&age=&sort=agedesc&minsize=200&maxsize=2000&dq=&poster=&nfo=&complete=1&hidespam=0&hidespam=1&more=1", self.searchString]];
		
	[self.mainWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)viewDidUnload
{
    [self setMainWebView:nil];
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"spinnerCounter"]){
		if (self.spinnerCounter <= 0){
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		} else{
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		}
	}
}

#pragma mark - UIWebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	self.spinnerCounter++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	self.spinnerCounter--;
	NSLog(@"Done");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	self.spinnerCounter--;
	NSLog(@"Error: %@", error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSString *extension = [[[[request URL] path] componentsSeparatedByString:@"."] lastObject];
	
	if ([extension isEqualToString:SearchExtension]){
		NSLog(@"Found File: %@", [request URL]);
		[self downloadFile:[request URL]];
		return NO;
	}
	
	return YES;
}

- (void) downloadFile:(NSURL *)url
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api?apikey=%@&mode=addurl&name=%@", [self.settings objectForKey:@"SabURL"], [self.settings objectForKey:@"APIKey"], [url absoluteString]]]];
	[request setDelegate:self];
	[request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"NZB added" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] autorelease];
	[alert show];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[[request error] localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] autorelease];
	[alert show];
}

@end
