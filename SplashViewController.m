//
//  SplashViewController.m
//  Magazine
//
//  Created by Sky on 1/5/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "SplashViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface SplashViewController ()
{
    AppDelegate *app;
}
@end

@implementation SplashViewController

#define magazine_url @"http://yogic6.com/magazine/admin/json.php"

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
    [self.navigationController.navigationBar setHidden:YES];
    
    app = [[UIApplication sharedApplication] delegate];
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_HUD setLabelText:@"Loading..."];
  
    // Do any additional setup after loading the view.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:magazine_url]];
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

}

- (void)connection:(NSURLConnection*) connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *) connection didReceiveData:(NSData *)data
{
    if(data!=nil)
        [self.responseData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error=%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_HUD hide:YES];
    NSDictionary *jsondictionary = [self cleanJsonToObject:self.responseData];
    app.magazine_array = [jsondictionary objectForKey:@"magaine"];
    
    
    NSDictionary *contactdictionary  = [jsondictionary objectForKey:@"contact"];
    
    app.contact_array = [NSArray arrayWithObjects:[contactdictionary objectForKey:@"directory"], [contactdictionary objectForKey:@"contactus"] ,nil];
    NSLog(@"%@", app.contact_array);
    
    UIStoryboard  *mainStoryboard;
    
    if(IS_IPHONE)
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone"  bundle:nil];
    else
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad"  bundle:nil];
    
    ViewController *homecontroller = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:homecontroller animated:YES];
}

- (id)cleanJsonToObject:(id)data {
    NSError* error;
    if (data == (id)[NSNull null]){
        return [[NSObject alloc] init];
    }
    id jsonObject;
    if ([data isKindOfClass:[NSData class]]){
        jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    } else {
        jsonObject = data;
    }
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [jsonObject mutableCopy];
        for (int i = array.count-1; i >= 0; i--) {
            id a = array[i];
            if (a == (id)[NSNull null]){
                [array removeObjectAtIndex:i];
            } else {
                array[i] = [self cleanJsonToObject:a];
            }
        }
        return array;
    } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dictionary = [jsonObject mutableCopy];
        for(NSString *key in [dictionary allKeys]) {
            id d = dictionary[key];
            if (d == (id)[NSNull null]){
                dictionary[key] = @"";
            } else {
                dictionary[key] = [self cleanJsonToObject:d];
            }
        }
        return dictionary;
    } else {
        return jsonObject;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
