//
//  ViewController.h
//  Magazine
//
//  Created by Sky on 1/4/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"

@interface ViewController : UIViewController<SlideNavigationControllerDelegate, UIScrollViewDelegate>
{
    NSString *facebook_linkurl;
    NSString *twitter_linkurl;
    NSString *youtube_linkurl;
    NSString *instagram_linkurl;
    NSString *videoplay_linkurl;
    NSString *website_linkurl;
    
    int magazine_index;
}
// social link buttons
@property(nonatomic, retain)  UIButton *facebookbtn;
@property(nonatomic, retain)  UIButton *twitterbtn;
@property(nonatomic, retain)  UIButton *youtubebtn;
@property(nonatomic, retain)  UIButton *instagrambtn;
@property(nonatomic, retain)  UIButton *vidoplaybn;
@property(nonatomic, strong) NSString *magazine_indexstring;

@property(nonatomic, retain)  IBOutlet UIView *socailview;
@property(nonatomic, retain)  IBOutlet UIButton *websitebtn;
@property(nonatomic, retain)  IBOutlet HJManagedImageV *mian_magazine_view;
@property(nonatomic, retain)  IBOutlet UILabel *title_label;
@property(nonatomic, retain) IBOutlet UIScrollView *scrollview;
@property(nonatomic, retain)  IBOutlet UILabel *descriptionlbl;
@property(nonatomic, retain) IBOutlet UIButton *openmagazine_btn;
@property (nonatomic,retain) HJObjManager *objmanager;

- (IBAction)rightbtnclick:(id)sender;
- (IBAction)leftbtnclick:(id)sender;
@end
