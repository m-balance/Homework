//
//  ThumbnailsViewController.m
//  ThumbnailFocus
//
//  Created by 鄭 基旭 on 2013/04/18.
//  Copyright (c) 2013年 鄭 基旭. All rights reserved.
//

#import "ThumbnailsViewController.h"

@interface ThumbnailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutletCollection (UIImageView) NSArray *imageViews;

@property (strong, nonatomic) FocusManager *focusManager;
@end

@implementation ThumbnailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    // iPhoneとiPadでxibファイルを変える
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        nibNameOrNil = @"ThumbnailsViewController";
    }
    else {
        nibNameOrNil = @"ThumbnailsViewControlleriPad";
    }
    
    // Xibファイル名を元に、インスタンスを生成する
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.focusManager = [[FocusManager alloc] init];
    self.focusManager.delegate = self;
    
    // iPadの処理 subviewから要素をたどってUIImageViewのみfocusManagerに追加する
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSArray *views = self.view.subviews;
        for(NSObject *obj in views) {
            if([obj isKindOfClass:[UIImageView class]]){
                [self.focusManager installOnView:(UIImageView *)obj];
            }
        }
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
    //return UIInterfaceOrientationMaskAll;
    //return UIInterfaceOrientationPortrait;
}

#pragma mark - FocusDelegate
- (UIViewController *)parentViewControllerForFocusManager
{
    NSLog(@"parentViewControllerForFocusManager");
    return self.parentViewController;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [self.focusManager installOnView:cell.imageView];
    }
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", indexPath.row + 1]];
    cell.imageView.image = image;
    cell.imageView.tag = indexPath.row + 1;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
@end
