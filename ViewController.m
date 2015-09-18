//
//  ViewController.m
//  Magazine
//
//  Created by Sky on 1/4/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "ViewController.h"
#import "LeftMenuViewController.h"
#import "AppDelegate.h"
#import "MagazineViewController.h"

@interface ViewController ()
{
    AppDelegate *app;
}
@end

@implementation ViewController

@synthesize scrollview;
@synthesize facebookbtn, twitterbtn, youtubebtn, instagrambtn, vidoplaybn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(gotomagazine:)
//                                                 name:@"GOTOMAGAZINE"
//                                               object:nil];
    
    
    _openmagazine_btn.layer.cornerRadius = 3.0f;
    _openmagazine_btn.layer.borderColor = [UIColor greenColor].CGColor;
    _openmagazine_btn.layer.borderWidth = 1;
    
    // socail button setting
    facebookbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twitterbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    youtubebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    instagrambtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vidoplaybn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    magazine_index = 0;
    
     [facebookbtn addTarget:self action:@selector(facebookbtnclik) forControlEvents:UIControlEventTouchUpInside];
     [twitterbtn addTarget:self action:@selector(twitterbtnclick) forControlEvents:UIControlEventTouchUpInside];
     [youtubebtn addTarget:self action:@selector(youtubebtnclick) forControlEvents:UIControlEventTouchUpInside];
     [instagrambtn addTarget:self action:@selector(instagrambtnclick) forControlEvents:UIControlEventTouchUpInside];
     [vidoplaybn addTarget:self action:@selector(videoplaybtnclick) forControlEvents:UIControlEventTouchUpInside];
    
	// Do any additional setup after loading the view, typically from a nib.
    app = [[UIApplication sharedApplication]delegate];
    
    
//    scrollview.pagingEnabled = YES;
    scrollview.contentSize = CGSizeMake((app.magazine_array.count) * self.view.frame.size.width, 0);
    scrollview.scrollEnabled = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.delegate = self;
    
    scrollview.backgroundColor = [UIColor clearColor];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        for (int i=0;i<app.magazine_array.count; i++) {
        
            HJManagedImageV *imageV = [[HJManagedImageV alloc]init];
            [imageV setFrame:CGRectMake((scrollview.frame.size.width/3+8)*(i+1), 0, scrollview.frame.size.width/3-5, scrollview.frame.size.height-40)];
            [imageV clear];
            [imageV showLoadingWheel];
            NSString *imageurl = [[app.magazine_array objectAtIndex:i] objectForKey:@"magaine_imageurl"];
            imageurl = [imageurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [imageV setUrl:[NSURL URLWithString:imageurl]];
            [app.objmanager manage:imageV];
            [scrollview addSubview:imageV];
            
            UILabel *title_lbl = [[UILabel alloc]initWithFrame:IS_IPHONE_5? CGRectMake((self.view.frame.size.width/3-10)*(i+1), scrollview.frame.size.height-50, imageV.frame.size.width, 38):CGRectMake((scrollview.frame.size.width/3+8)*(i+1), scrollview.frame.size.height-50, scrollview.frame.size.width/3-5, 40)];
            
            [title_lbl setFont:IS_IPHONE_5?[UIFont systemFontOfSize:14.0f]:[UIFont systemFontOfSize:24.0f]];
            title_lbl.textAlignment = UITextAlignmentCenter;
            title_lbl.text = [[app.magazine_array objectAtIndex:i] objectForKey:@"magaine_title"];
            [scrollview addSubview:title_lbl];
        }
   });
    [_websitebtn setEnabled:FALSE];
    
    if(app.magazine_array.count>0)
        [self socialbuttonsetting:0];
    
    int indexvalue = [_magazine_indexstring intValue];
    [self gotomagazine:indexvalue];
}

- (IBAction)magazineclick:(id)sender
{
    UIStoryboard  *mainStoryboard;
    
    if(IS_IPHONE)
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone"  bundle:nil];
    else
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad"  bundle:nil];
    
    MagazineViewController *magazinecontroller = [mainStoryboard instantiateViewControllerWithIdentifier:@"MagazineViewController"];
    magazinecontroller.magazine_index = magazine_index;
    [self.navigationController pushViewController:magazinecontroller animated:YES];
}


#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}

-(void) gotomagazine:(int) index
{
    NSLog(@"index=%d",index);
    magazine_index = index;
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                            [scrollview setContentOffset:CGPointMake(index*(scrollview.frame.size.width/3+10), scrollview.bounds.origin.y) animated:NO];
                            [self buttonsinit];
                            [self socialbuttonsetting:magazine_index];
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

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    int index = scrollView.contentOffset.x/self.view.frame.size.width;
//    
//    if(app.magazine_array.count>0)
//    {
//        [self buttonsinit];
//        [self socialbuttonsetting:index];
//    }
//}
//
- (void)socialbuttonsetting:(int)index
{
    [self buttonsinit];
    NSString *imageurl = [[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_imageurl"];
    imageurl = [imageurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_mian_magazine_view clear];
    [_mian_magazine_view showLoadingWheel];
    [_mian_magazine_view setUrl:[NSURL URLWithString:imageurl]];
    [app.objmanager manage:_mian_magazine_view];
    
    _title_label.text = [[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_title"];
    _descriptionlbl.text = [[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_description"];
    int count = 1;
    if(![[[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_video"] isEqualToString:@""])
    {
        videoplay_linkurl = [[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_video"];
        if(IS_IPHONE_5)
            [vidoplaybn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [vidoplaybn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [vidoplaybn setBackgroundImage:[UIImage imageNamed:@"videoplay.png"] forState:UIControlStateNormal];
        [_socailview addSubview:vidoplaybn];
        count++ ;
    }
    if(![[[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_youtube"] isEqualToString:@""])
    {
        youtube_linkurl = [[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_youtube"];
        if(IS_IPHONE_5)
            [youtubebtn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [youtubebtn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [youtubebtn setBackgroundImage:[UIImage imageNamed:@"youtube.png"] forState:UIControlStateNormal];
        [_socailview addSubview:youtubebtn];
        count++ ;
    }
    if(![[[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_instagram"] isEqualToString:@""])
    {
        instagram_linkurl = [[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_instagram"];
        if(IS_IPHONE_5)
            [instagrambtn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [instagrambtn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [instagrambtn setBackgroundImage:[UIImage imageNamed:@"instagram.png"] forState:UIControlStateNormal];
        [_socailview addSubview:instagrambtn];
        count++ ;
    }
    if(![[[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_twitter"] isEqualToString:@""])
    {
        twitter_linkurl = [[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_twitter"];
        if(IS_IPHONE_5)
            [twitterbtn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [twitterbtn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [twitterbtn setBackgroundImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
        [_socailview addSubview:twitterbtn];
        count++ ;
    }
    if(![[[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_facebook"] isEqualToString:@""])
    {
        facebook_linkurl = [[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_facebook"];
        if(IS_IPHONE_5)
            [facebookbtn setFrame:CGRectMake(self.view.frame.size.width-30*count, 7, 25, 25)];
        else
            [facebookbtn setFrame:CGRectMake(self.view.frame.size.width-60*count, 15, 50, 50)];
        [facebookbtn setBackgroundImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
        [_socailview addSubview:facebookbtn];
        count++ ;
    }
    if(![[[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_website"] isEqualToString:@""])
    {
        website_linkurl = [[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_website"];
        [_websitebtn setTitle:[[app.magazine_array objectAtIndex:index] objectForKey:@"magaine_website"] forState:UIControlStateNormal];
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

- (IBAction)rightbtnclick:(id)sender
{
    if(magazine_index<app.magazine_array.count-1)
    {
        [scrollview setContentOffset:CGPointMake((scrollview.frame.size.width/3+10) +scrollview.contentOffset.x, scrollview.contentOffset.y) animated:YES];
        magazine_index = magazine_index + 1;
        [self socialbuttonsetting:magazine_index];
    }
    NSLog(@"magazine_index=%d", magazine_index);
}

- (IBAction)leftbtnclick:(id)sender
{
    if(magazine_index>0)
    {
        [scrollview setContentOffset:CGPointMake(scrollview.contentOffset.x-(scrollview.frame.size.width/3+10), scrollview.contentOffset.y) animated:YES];
        magazine_index = magazine_index - 1;
        [self socialbuttonsetting:magazine_index];
    }
    NSLog(@"magazine_index=%d", magazine_index);
}

- (IBAction)menubtnclicked:(id)sender
{
    [[SlideNavigationController sharedInstance] toggleRightMenu];
}

- (void)viewDidDisappear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOTOMAGAZINE" object:nil];
}
#pragma mark - Zoom methods


@end
