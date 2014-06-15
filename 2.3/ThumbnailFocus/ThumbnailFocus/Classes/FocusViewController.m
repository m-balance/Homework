//
//  FocusViewController.m
//  ThumbnailFocus
//
//  Created by 鄭 基旭 on 2013/04/18.
//  Copyright (c) 2013年 鄭 基旭. All rights reserved.
//

#import "FocusViewController.h"

static NSTimeInterval const kDefaultOrientationAnimationDuration = 0.4;

@interface FocusViewController ()
@property (nonatomic, assign) UIDeviceOrientation previousOrientation;
@end

#warning 「⬇ Answer：」マークがあるラインにコメントで簡単な解説文を書いてください。

@implementation FocusViewController

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mainImageView = nil;
    self.contentView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // ⬇Answer：画面の向きが変わったらorientationDidChangeNotificationメソッドを呼ぶように設定
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    // ⬇Answer：画面の向きを監視して回転した際に通知を発火
    //          ※この指定が無くても上で設定した通知は発火されるがUIDeviceOrientationの値がUIDeviceOrientationUnknownになり
    //           画面の向きが把握出来なくなる
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // ⬇Answer：通知設定を削除　削除しないと破棄されるまで通知を続けてしまう
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    // ⬇Answer：beginGeneratingDeviceOrientationNotificationsと対で回転検知を辞める際に呼び出す
    //          Answer：beginGeneratingDeviceOrientationNotificationsと呼びし回数が対になってないと通知処理がうまく行かなくなるらしい
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (NSUInteger)supportedInterfaceOrientations
{
    // ⬇Answer：ホームボタンが上の場合のみサポートする
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)isParentSupportingInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    switch(toInterfaceOrientation)
    {
        case UIInterfaceOrientationPortrait:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskPortrait;

        case UIInterfaceOrientationPortraitUpsideDown:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskPortraitUpsideDown;

        case UIInterfaceOrientationLandscapeLeft:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeLeft;

        case UIInterfaceOrientationLandscapeRight:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeRight;
    }
}


/////////////////////////////////////////////////////////////
// ⬇Answer： 次の関数は回転時のアニメーションを担当しています。
//　82ラインから140ラインまで、すべてのラインにコメントを書いてください。
/////////////////////////////////////////////////////////////
- (void)updateOrientationAnimated:(BOOL)animated
{
    // アフィン変換（画像の拡大縮小、回転、平行移動）用オブジェクト
    CGAffineTransform transform;
    // アニメーションの実行時間 0.4秒
    // static NSTimeInterval const kDefaultOrientationAnimationDuration = 0.4;
    NSTimeInterval duration = kDefaultOrientationAnimationDuration;

    // 同じ向きだった場合にはアニメーションを行わない
    if([UIDevice currentDevice].orientation == self.previousOrientation){
        return;
    }
    
    // 回転アニメーションが２コマ分になった場合にアニメーション時間を倍にする
    if((UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation) && UIInterfaceOrientationIsLandscape(self.previousOrientation))
       || (UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation) && UIInterfaceOrientationIsPortrait(self.previousOrientation)))
    {
        duration *= 2;
    }
    
    // 画面が通常縦の場合と親クラスが画像の回転を許可している場合は画像を元に戻す
    if(([UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait)
       || [self isParentSupportingInterfaceOrientation:(UIInterfaceOrientation)[UIDevice currentDevice].orientation]) {
        // 元の画像に戻す
        transform = CGAffineTransformIdentity;
    }else {
        
        // 画面の向き別に処理
        switch ([UIDevice currentDevice].orientation){
                
            // 横（ホームボタン左）
            case UIInterfaceOrientationLandscapeLeft:
                if(self.parentViewController.interfaceOrientation == UIInterfaceOrientationPortrait) {
                    // 画像の回転設定(π/2 90°右に回転)
                    transform = CGAffineTransformMakeRotation(-M_PI_2);
                }else {
                    // 画像の回転設定(π/2 90°左に回転)
                    transform = CGAffineTransformMakeRotation(M_PI_2);
                }
                break;

            // 横（ホームボタン右）
            case UIInterfaceOrientationLandscapeRight:
                if(self.parentViewController.interfaceOrientation == UIInterfaceOrientationPortrait) {
                    // 画像の回転設定(π/2 90°左に回転)
                    transform = CGAffineTransformMakeRotation(M_PI_2);
                }else {
                    // 画像の回転設定(π/2 90°右に回転)
                    transform = CGAffineTransformMakeRotation(-M_PI_2);
                }
                break;

            // 縦（ホームボタン下）
            case UIInterfaceOrientationPortrait:
                // 元の画像に戻す
                transform = CGAffineTransformIdentity;
                break;

            // 縦（ホームボタン上）
            case UIInterfaceOrientationPortraitUpsideDown:

                // 今回はホームボタンが上（逆）の場合は画面を遷移させないように実装したのでここでは何もせず復帰する
                //transform = CGAffineTransformMakeRotation(M_PI);
                //break;
                return;

            // 他
            case UIDeviceOrientationFaceDown:
            case UIDeviceOrientationFaceUp:
            case UIDeviceOrientationUnknown:
                return;
        }
    }

    // frameの初期値に(0,0)を設定
    CGRect frame = CGRectZero;
    
    // アニメーション指定あり：必ずありで呼ばれてるけど。。。
    if(animated) {
        // 自分のframeを保持
        frame = self.contentView.frame;
        // 設定したtransformでアニメーションを行う
        [UIView animateWithDuration:duration
                         animations:^{
                             self.contentView.transform = transform;
                             self.contentView.frame = frame;
                         }];
    // アニメーションなし
    }else {
        frame = self.contentView.frame;
        self.contentView.transform = transform;
        self.contentView.frame = frame;
    }
    
    // 次回との比較用に画面の向きを保持する
    self.previousOrientation = [UIDevice currentDevice].orientation;
}

#pragma mark - Notifications
// ⬇Answer：画面の向きが変わった際に呼び出される
- (void)orientationDidChangeNotification:(NSNotification *)notification
{
    NSLog(@"%s", __func__);
    
    // 画面の向きが変わった為、描画処理を再度やり直す
    [self updateOrientationAnimated:YES];
}

@end