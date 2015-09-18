//
//  WeViewController.h
//  Magazine
//
//  Created by Sky on 2/5/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic, retain) IBOutlet UIWebView *webview;
@property(strong, nonatomic)IBOutlet UIActivityIndicatorView *indicatorview;
@property(nonatomic, strong) NSString *weburl_string;
@end
