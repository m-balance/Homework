//
//  SVSViewController.m
//  scrollViewSample
//
//  Created by 武田 祐一 on 2013/04/19.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "SVSViewController.h"

@interface SVSViewController (){
    @private UIImage *image;
    @private UIImageView *imageView;
}
@end

@implementation SVSViewController

- (void)viewDidLoad
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    
    image = [UIImage imageNamed:@"big_image.jpg"];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    imageView.image = image;
    [scrollView addSubview:imageView];
    scrollView.contentSize = imageView.frame.size;
    
    scrollView.maximumZoomScale = 3.0; // 最大倍率
    scrollView.minimumZoomScale = 0.5; // 最小倍率
    
    // delegateの設定
    scrollView.delegate = self;

    // 課題：起動時に、アニメーション付きで自動的にあるポジションへ移動させてください。
    [UIScrollView animateWithDuration:2.0f
                          delay:1.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect rect;
                         rect = CGRectMake(0, 1000, image.size.width, image.size.height);
                         imageView.frame = rect;
                         rect = CGRectMake(0, 0, image.size.width, image.size.height);
                         imageView.frame = rect;
                     } completion:^(BOOL finished) {
                     }];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
    for (UIView *view in scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            return view;
        }
    }
    return nil;
}

// 課題：現在のscrollviewのコンテンツの位置をscrollする度にNSLogで出力してください
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"スクロールしてるでー");
}

// 課題：ステータスバー(上部の時計や電波強度を示すバー)をタップすると一番上にスクロールできるようにしてください
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    // もともと実装していないくても上にスクロールするがこれは一体？？？
    return YES;
}

@end
