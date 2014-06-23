//
//  MainViewController.m
//  ThumbnailFocus
//
//  Created by 鄭 基旭 on 2013/04/18.
//  Copyright (c) 2013年 鄭 基旭. All rights reserved.
//

#import "MainViewController.h"
#import "ThumbnailsViewController.h"
#import "ThumbnailsViewPadController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) ThumbnailsViewController *thumbnailsViewController;
@property (strong, nonatomic) ThumbnailsViewPadController *thumbnailsViewPadController;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.thumbnailsViewController = [[ThumbnailsViewController alloc] initWithNibName:nil bundle:nil];
    [self addChildViewController:self.thumbnailsViewController];
    [self.contentView addSubview:self.thumbnailsViewController.view];
    self.thumbnailsViewController.view.frame = self.contentView.bounds;
    self.view.clipsToBounds = NO;
}

#warning ⬇ HomeWork　iPadの場合は回転に対応してください。
// 本来shouldAutorotateToInterfaceOrientationで設定していたが、iOS6からはsupportedInterfaceOrientationsになる
- (NSUInteger)supportedInterfaceOrientations
{
//    NSLog(@"%s", __func__);

    // デバイス別に回転の向きを決定
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        // 縦方向のみ許可
        return UIDeviceOrientationPortrait + UIDeviceOrientationPortraitUpsideDown;
    } else {
        // 全ての方向の回転を許可
        return UIInterfaceOrientationMaskAllButUpsideDown;
        //return UIInterfaceOrientationMaskAll;
    }
    
}

// 指定をYESにした場合にsupportedInterfaceOrientationsが呼ばれて回転の方向を指示する
-(BOOL)shouldAutorotate {
    return YES;
}

// デバイスの回転開始時に呼び出される
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)FromInterfaceOrientation duration:(NSTimeInterval)duration{
    // 縦表示（ホームボタン下）
/*
    if(FromInterfaceOrientation == UIInterfaceOrientationPortrait){
        NSLog(@"will to   Portrait");
    }else if(FromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ){
        NSLog(@"will to   UpsideDown");
    }else if(FromInterfaceOrientation == UIInterfaceOrientationLandscapeRight ){
        NSLog(@"will to   LandscapeRight");
    }else if(FromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        NSLog(@"will to   LandscapeLeft");
    }else{
        NSLog(@"will 何が起きた？！");
    }
*/
}

// デバイスの回転後に呼び出される
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)FromInterfaceOrientation {
/*
    if(FromInterfaceOrientation == UIInterfaceOrientationPortrait){
        NSLog(@"did  from Portrait");
    }else if(FromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ){
        NSLog(@"did  from UpsideDown");
    }else if(FromInterfaceOrientation == UIInterfaceOrientationLandscapeRight ){
        NSLog(@"did  from LandscapeRight");
    }else if(FromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        NSLog(@"did  from LandscapeLeft");
    }else{
        NSLog(@"did  何が起きた？！");
    }
*/
}

#warning ⬇ HomeWork
// ここがコメントでも動いているのはこのクラスがUIViewControllerを継承している為

/*ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
// １。５０ラインからのメソッドはコメント処理したのに、なんでうまく動いているか？ 考えてみてください。
// ２。下記は必ず覚えていきましょう
ー【UIViewControllerのViewロードに関する主要デリゲートメソッド】ーー
-(void)viewDidLoad	初回ロードされた時のみ呼び出される
-(void)viewWillAppear:(BOOL)animated	画面が表示される都度呼び出される
-(void)viewDidAppear:(BOOL)animated	画面が表示された後に呼び出される
-(void)viewWillDisappear:(BOOL)animated	画面が閉じる前に呼び出される
-(void)viewDidDisappear:(BOOL)animated	画面が閉じた後に呼び出される
-(void)viewDidUnload	画面がアンロードされたときに呼び出される
-(void)didReceiveMemoryWarning	メモリ不足時に呼び出される
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー*/
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
*/
@end
