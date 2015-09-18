//
//  WeViewController.m
//  Magazine
//
//  Created by Sky on 2/5/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "WeViewController.h"

@interface WeViewController ()

@end

@implementation WeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL* nsUrl = [NSURL URLWithString:_weburl_string];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    _webview.scalesPageToFit = YES;
    _webview.scrollView.bounces = false;
    [_indicatorview startAnimating];
    [_webview loadRequest:request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backbuttonclick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start load");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    NSLog(@"load error");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"fnish load");
    [_indicatorview stopAnimating];
    [_indicatorview setHidden:YES];
}

@end
