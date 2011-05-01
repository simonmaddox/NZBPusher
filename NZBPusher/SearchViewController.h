//
//  SearchViewController.h
//  NZBPusher
//
//  Created by Simon Maddox on 01/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchViewController : UIViewController <UITextFieldDelegate> {
    
	UITextField *searchField;
}

@property (nonatomic, retain) IBOutlet UITextField *searchField;

- (IBAction)search;

@end
