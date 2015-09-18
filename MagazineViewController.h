//
//  MagazineViewController.h
//  Magazine
//
//  Created by Sky on 1/13/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "AppDelegate.h"
@interface MagazineViewController : UIViewController<SlideNavigationControllerDelegate, UIScrollViewDelegate>
{
    NSArray *magazine_image_array;
    CGRect subscroll_rect;
    
    NSString *facebook_linkurl;
    NSString *twitter_linkurl;
    NSString *youtube_linkurl;
    NSString *instagram_linkurl;
    NSString *videoplay_linkurl;
    NSString *website_linkurl;
    
    NSTimer *imageload_timer;
  
}
@property(nonatomic, retain) IBOutlet UIScrollView *scrollview;
@property (nonatomic,retain) HJObjManager *objmanager;

// social link buttons
@property(nonatomic, retain)  UIButton *facebookbtn;
@property(nonatomic, retain)  UIButton *twitterbtn;
@property(nonatomic, retain)  UIButton *youtubebtn;
@property(nonatomic, retain)  UIButton *instagrambtn;
@property(nonatomic, retain)  UIButton *vidoplaybn;

@property(nonatomic, retain)  IBOutlet UIView *socailview;
@property(nonatomic, retain)  IBOutlet UIButton *websitebtn;

@property int magazine_index;

- (IBAction)skipbtnclick:(id)sender;
@end
