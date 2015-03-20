//
//  ViewController.m
//  BackgroundApp
//
//  Created by Vinod Vishwakarma on 05/02/15.
//  Copyright (c) 2015 Vinod Vishwakarma. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(onMenuCickAtion)];
    self.navigationItem.backBarButtonItem = menuButtonItem;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onMenuCickAtion {

    [[self slidingPanelController] openLeftPanel];
}


@end
