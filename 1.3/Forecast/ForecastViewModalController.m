//
//  ForecastViewModalController.m
//  Forecast
//
//  Created by newbalance on 2014/06/08.
//  Copyright (c) 2014年 newbalance. All rights reserved.
//

#import "ForecastViewModalController.h"

// インターフェース
@interface ForecastViewModalController ()

@end

// クラス
@implementation ForecastViewModalController

// デリゲート
@synthesize delegate;

// xibを使用する際に呼び出される
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

// ロード時に呼び出される（未描画状態）
- (void)viewDidLoad
{
    // closeボタンを追加
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                         style:UIBarButtonItemStyleBordered
                                         target:self
                                         action:@selector(clickClose:)];
    
    // 乱数を生成
    NSInteger idx = arc4random_uniform(5);

    // 画像を配置
    NSMutableArray *viewImages = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        NSString *filename = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *img = [UIImage imageNamed:filename];
        [viewImages addObject:img];
        
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[viewImages objectAtIndex:idx]];
    imageView.frame = CGRectOffset(imageView.frame, 0.0, 64.0);
    [self.view insertSubview:imageView atIndex:0];

    // ラベルの配置
    NSArray *ary = [NSArray arrayWithObjects: @"おっと、上司の逆鱗に触れてしまったようだ！「大凶」",
                                              @"やれぇぇぇ大和田ぁぁぁ！！！！「大吉」",
                                              @"フォスターとの業務提携を成功させたぞ！「中吉」",
                                              @"近藤です「吉」",
                                              @"今日に限って金融庁検査が！！「凶」",
                                              nil];
    UILabel *labelResult = [[UILabel alloc] init];
    labelResult.text = [ary objectAtIndex:idx];
    labelResult.frame = CGRectMake(0,120,320,300);
    labelResult.font = [UIFont fontWithName:@"AppleGothic" size:12];
    labelResult.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelResult];

    // 西大阪スチールボタンを配置
    UIButton *btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNext.frame = CGRectMake(12,350,130,30);
    [btnNext.titleLabel setFont:[UIFont fontWithName:@"AppleGothic" size:16]];
    [btnNext setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNext setTitle:@"西大阪スチール" forState:UIControlStateNormal];
    [btnNext addTarget:self action:@selector(clickNext1:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btnNext];

    // 伊勢島ホテルボタンを配置
    UIButton *btnNext2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNext2.frame = CGRectMake(200,350,100,30);
    [btnNext2.titleLabel setFont:[UIFont fontWithName:@"AppleGothic" size:16]];
    [btnNext2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNext2 setTitle:@"伊勢島ホテル" forState:UIControlStateNormal];
    [btnNext2 addTarget:self action:@selector(clickNext2:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btnNext2];
    
    
    // バックボタン配置
    self.navigationItem.leftItemsSupplementBackButton = YES;

    [super viewDidLoad];
}

// メモリ不足時に呼び出される
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 西大阪スチールボタン押下時
- (IBAction)clickNext1:(id)sender {
    ForecastViewModalController *viewController = [[ForecastViewModalController alloc] init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

// 伊勢島ホテルボタン押下時
- (IBAction)clickNext2:(id)sender {
    [self.navigationController pushViewController:[[ForecastViewModalController alloc] init] animated:YES];

}

// close時に呼ばれる
- (void)clickClose:(id)sender
{
    // デリゲート先がちゃんと「stopAudio」というメソッドを持っているか?
    if ([self.delegate respondsToSelector:@selector(stopAudio)]) {
        // stopAudioを呼び出す
        [self.delegate stopAudio];
    }

    // モーダルウィンドウを閉じる
	[self dismissViewControllerAnimated:YES completion:nil];
}



@end
