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
    [super viewDidLoad];

    // closeボタンを追加
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                         style:UIBarButtonItemStyleBordered
                                         target:self
                                         action:@selector(clickClose:)];
    
    // 乱数を生成
    NSInteger idx = arc4random_uniform(5);

    // ランダムで表示する画像(画像は全部で5個)
    NSMutableArray *viewImages = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        NSString *filename = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *img = [UIImage imageNamed:filename];
        [viewImages addObject:img];
        
    }

    // 画像をviewに配置
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[viewImages objectAtIndex:idx]];
    imageView.frame = CGRectOffset(imageView.frame, 0.0, 64.0);
    [self.view insertSubview:imageView atIndex:0];

    // ラベルの生成
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
    
    // ラベルをviewに配置
    [self.view addSubview:labelResult];
}

// メモリ不足時に呼び出される
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
