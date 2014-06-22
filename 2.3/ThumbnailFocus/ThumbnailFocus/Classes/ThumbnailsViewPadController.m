//
//  ThumbnailsViewPadController.m
//  ThumbnailFocus
//
//  Created by newbalance on 2014/06/18.
//  Copyright (c) 2014年 鄭 基旭. All rights reserved.
//

#import "ThumbnailsViewPadController.h"

@interface ThumbnailsViewPadController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ThumbnailsViewPadController

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

    UIImage *uiImage = [UIImage imageNamed:@"4.jpg"];
    self.imgView.image = uiImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
