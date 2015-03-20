//
//  SplashViewController.m
//  BackgroundApp
//
//  Created by Vinod Vishwakarma on 05/02/15.
//  Copyright (c) 2015 Vinod Vishwakarma. All rights reserved.
//

#import "SplashViewController.h"
#import "AppDelegate.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad  {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performSelector:@selector(navigateMainController) withObject:nil afterDelay:5.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)navigateMainController {

    appDelegate.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    
}


@end
