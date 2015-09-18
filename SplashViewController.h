//
//  SplashViewController.h
//  Magazine
//
//  Created by Sky on 1/5/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SplashViewController : UIViewController

// progress bar
@property (nonatomic, retain)MBProgressHUD *HUD;
@property(nonatomic, retain) NSURLConnection *connection;
@property(nonatomic, retain) NSMutableData *responseData;

@end
