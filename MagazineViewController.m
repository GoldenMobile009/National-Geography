//
//  MagazineViewController.m
//  Magazine
//
//  Created by Sky on 1/13/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "MagazineViewController.h"
//#import "LeftMenuViewController.h"
@interface MagazineViewController ()
{
    AppDelegate *app;
}
@end

@implementation MagazineViewController
@synthesize scrollview;
@synthesize facebookbtn, twitterbtn, youtubebtn, instagrambtn, vidoplaybn;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submagazineclick:) name:@"GOTOSUBIMAGE" object:nil];
    
    app = [[UIApplication sharedApplication]delegate];
    // Do any additional setup after loading the view.
    
    
    // socail button setting
    facebookbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twitterbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    youtubebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    instagrambtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vidoplaybn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [facebookbtn addTarget:self action:@selector(facebookbtnclik) forControlEvents:UIControlEventTouchUpInside];
    [twitterbtn addTarget:self action:@selector(twitterbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [youtubebtn addTarget:self action:@selector(youtubebtnclick) forControlEvents:UIControlEventTouchUpInside];
    [instagrambtn addTarget:self action:@selector(instagrambtnclick) forControlEvents:UIControlEventTouchUpInside];
    [vidoplaybn addTarget:self action:@selector(videoplaybtnclick) forControlEvents:UIControlEventTouchUpInside];

   
    scrollview.pagingEnabled = YES;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.delegate = self;
    
    [self multimageloading];

    scrollview.backgroundColor = [UIColor clearColor];
    
    if(magazine_image_array.count>0)
        [self socialbuttonsetting:0];
   }

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOTOSUBIMAGE" object:nil];
}

- (void)multimageloading
{
    [app.pulldown_array removeAllObjects];
    magazine_image_array = [[app.magazine_array objectAtIndex:_magazine_index] objectForKey:@"images"];
    for(NSDictionary *dictionary in magazine_image_array)
    {
        NSString *menutitle = [dictionary objectForKey:@"menutitle"];
        if(![menutitle isEqualToString:@""])
           [app.pulldown_array addObject:dictionary];
    }
    NSLog(@"%@", app.pulldown_array);
    scrollview.contentSize = CGSizeMake((magazine_image_array.count) * self.view.frame.size.width, 350);

    for (int i=0;i<magazine_image_array.count; i++) {
        HJManagedImageV *mainimageV = [[HJManagedImageV alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, scrollview.bounds.size.width, scrollview.bounds.size.height)];
        [mainimageV clear];
        [mainimageV showLoadingWheel];
        NSString *imageurl = [[magazine_image_array objectAtIndex:(i)] objectForKey:@"image_url"];
       
        imageurl = [imageurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mainimageV setUrl:[NSURL URLWithString:imageurl]];
        [app.objmanager manage:mainimageV];
        [scrollview addSubview:mainimageV];
    }

}

- (void)submagazineclick:(NSNotification *)notification
{
    int subtitle_index = [notification.object intValue];
    NSDictionary *sub_dictionary = [app.pulldown_array  objectAtIndex:subtitle_index];
    int subtitle_order = [[sub_dictionary objectForKey:@"order"] intValue];
    int index = 0;
    
    for(NSDictionary *dictionary in magazine_image_array)
    {
        int order = [[dictionary objectForKey:@"order"] intValue];
        if(order == subtitle_order)
            break;
        else
            index++;
    }
   
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         [scrollview setContentOffset:CGPointMake(index*self.view.frame.size.width, scrollview.bounds.origin.y) animated:NO];
                         [self socialbuttonsetting:index];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark scrollview delgate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x/self.view.frame.size.width;
    
    if(magazine_image_array.count>0)
    {
        [self buttonsinit];
        [self socialbuttonsetting:index];
    }
}

#pragma mark slide delgate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}

- (IBAction)donebtnclick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)socialbuttonsetting:(int)index
{
    int count = 1;
    if(![[[magazine_image_array objectAtIndex:index] objectForKey:@"video"] isEqualToString:@""])
    {
        videoplay_linkurl = [[magazine_image_array objectAtIndex:index] objectForKey:@"video"];
        if(IS_IPHONE_5)
            [vidoplaybn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [vidoplaybn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [vidoplaybn setBackgroundImage:[UIImage imageNamed:@"videoplay.png"] forState:UIControlStateNormal];
        [_socailview addSubview:vidoplaybn];
        count++ ;
    }
    if(![[[magazine_image_array objectAtIndex:index] objectForKey:@"youtube"] isEqualToString:@""])
    {
        youtube_linkurl = [[magazine_image_array objectAtIndex:index] objectForKey:@"youtube"];
        if(IS_IPHONE_5)
            [youtubebtn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [youtubebtn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [youtubebtn setBackgroundImage:[UIImage imageNamed:@"youtube.png"] forState:UIControlStateNormal];
        [_socailview addSubview:youtubebtn];
        count++ ;
    }
    if(![[[magazine_image_array objectAtIndex:index] objectForKey:@"instagram"] isEqualToString:@""])
    {
        instagram_linkurl = [[magazine_image_array objectAtIndex:index] objectForKey:@"instagram"];
        if(IS_IPHONE_5)
            [instagrambtn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [instagrambtn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [instagrambtn setBackgroundImage:[UIImage imageNamed:@"instagram.png"] forState:UIControlStateNormal];
        [_socailview addSubview:instagrambtn];
        count++ ;
    }
    if(![[[magazine_image_array objectAtIndex:index] objectForKey:@"twitter"] isEqualToString:@""])
    {
        twitter_linkurl = [[magazine_image_array objectAtIndex:index] objectForKey:@"twitter"];
        if(IS_IPHONE_5)
            [twitterbtn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [twitterbtn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [twitterbtn setBackgroundImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
        [_socailview addSubview:twitterbtn];
        count++ ;
    }
    if(![[[magazine_image_array objectAtIndex:index] objectForKey:@"facebook"] isEqualToString:@""])
    {
        facebook_linkurl = [[magazine_image_array objectAtIndex:index] objectForKey:@"facebook"];
        if(IS_IPHONE_5)
            [facebookbtn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [facebookbtn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [facebookbtn setBackgroundImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
        [_socailview addSubview:facebookbtn];
        count++ ;
    }
    if(![[[magazine_image_array objectAtIndex:index] objectForKey:@"website"] isEqualToString:@""])
    {
        website_linkurl = [[magazine_image_array objectAtIndex:index] objectForKey:@"website"];
        [_websitebtn setTitle:[[magazine_image_array objectAtIndex:index] objectForKey:@"website"] forState:UIControlStateNormal];
        [_websitebtn setEnabled:true];
    }
}

- (void)buttonsinit
{
    [_websitebtn setEnabled:FALSE];
    [_websitebtn setTitle:@"" forState:UIControlStateNormal];
    [facebookbtn removeFromSuperview];
    [twitterbtn removeFromSuperview];
    [instagrambtn removeFromSuperview];
    [youtubebtn removeFromSuperview];
    [vidoplaybn removeFromSuperview];
}

- (void)facebookbtnclik
{
    NSLog(@"facebook=%@", facebook_linkurl);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self httpstrcheck:facebook_linkurl]]];
}

- (void)twitterbtnclick
{
    NSLog(@"twitter=%@", twitter_linkurl);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self httpstrcheck:twitter_linkurl]]];
}

- (void)youtubebtnclick
{
    NSLog(@"youtube=%@", youtube_linkurl);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self httpstrcheck:youtube_linkurl]]];
}

- (void)instagrambtnclick
{
    NSLog(@"instagram=%@", instagram_linkurl);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self httpstrcheck:instagram_linkurl]]];
}

- (void)videoplaybtnclick
{
    NSLog(@"videoplay=%@", videoplay_linkurl);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self httpstrcheck:videoplay_linkurl]]];
}

- (IBAction)websitebtnclick:(id)sender
{
    NSLog(@"website=%@", website_linkurl);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self httpstrcheck:website_linkurl]]];
}

- (NSString *)httpstrcheck:(NSString *)orginalurl
{
    if ([orginalurl rangeOfString:@"http"].location == NSNotFound) {
        orginalurl = [NSString stringWithFormat:@"http://%@", orginalurl];
    }
    return orginalurl;
}

- (IBAction)pullmenubtnclicked:(id)sender
{
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RELOADTABLE" object:nil];
}

@end
