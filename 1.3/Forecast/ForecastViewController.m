//
//  ForecastViewController.m
//  Forecast
//
//  Created by newbalance on 2014/06/07.
//  Copyright (c) 2014年 newbalance. All rights reserved.
//

#import "ForecastViewController.h"
#import "UIViewController+ForecastAnimation.h"

// インターフェース
@interface ForecastViewController (){
    // audio関連
    // TODO:Audio関連は後ほ別ファイルに切り出す
    @private AVAudioPlayer *audio;
    @private NSURL *audio_url;
}

@end

// クラス
@implementation ForecastViewController

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
    // ロード時にAudioオブジェクトを生成する
    audio_url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"hanzawa" ofType:@"m4a"]];
    audio = [[AVAudioPlayer alloc] initWithContentsOfURL:audio_url error:nil];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 2.5; // アニメーション速度
    animation.repeatCount = 1; // 繰り返し回数
    
    [super viewDidLoad];
}

// メモリ不足時に呼び出される
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 画面が表示される直前に実行される
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self animationPopFrontScaleUp];
    // TODO:念の為にここでサウンド停止する　原因は後で調査
    [self stopAudio];
}

// 倍返しボタン押下
- (IBAction)pushPlay:(id)sender {
    // アニメーション
    [self animationPushBackScaleDown];

    // モーダル表示
    [self viewModal];
    
    // 音声を再生
    [self playAudio:1.0];
}

// 10倍返しボタン押下
- (IBAction)pushPlay10:(id)sender {
    
    // アニメーション
    [self animationPushBackScaleDown];

    // モーダル表示
    [self viewModal];

    // 音声を再生
    [self playAudio:10.0];
}

// モーダルウィンドウを表示
- (BOOL)viewModal {
    
    // モーダルウィンドウを表示
    @try {
        // delegate先を自分にしてモーダルウィンドウを表示
        ForecastViewModalController *viewModalController = [[ForecastViewModalController alloc] init];
        viewModalController.delegate = self;
        UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:viewModalController];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
        return NO;
    }
    @finally {
        NSLog(@"Successful view of the modal");
    }
    
    return YES;
}

// オーディオ再生
- (void)playAudio:(float)rate {
    NSLog(@"%s", __func__);

    // AVAudioFoundationで音声を再生
    @try {
        // 以下設定で音声を再生
        //  音量：0.8
        //  再生回数：1回
        //  速度の設定：あり
        //  速度：引数rate
        audio.currentTime = 0;
        audio.volume = 0.8;
        audio.numberOfLoops = 0;
        audio.enableRate = YES;
        audio.rate = rate;
        [audio prepareToPlay];
        [audio play];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    @finally {
        NSLog(@"Successful reproduction of the audio");
    }
}

// オーディオ停止
-(void)stopAudio {
    NSLog(@"%s", __func__);
    
    @try {
        [audio stop];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    @finally {
        NSLog(@"Successful stop of the audio");
    }
}

@end
