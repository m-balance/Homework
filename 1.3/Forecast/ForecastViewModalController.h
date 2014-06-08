//
//  ForecastViewModalController.h
//  Forecast
//
//  Created by newbalance on 2014/06/08.
//  Copyright (c) 2014年 newbalance. All rights reserved.
//

#import <UIKit/UIKit.h>

// delegateさせるメソッド
@protocol ForecastViewDelegate <NSObject>
- (void) stopAudio;
- (void) playAudio:(float)rate;
@end

// インターフェース
@interface ForecastViewModalController : UIViewController

// デリゲート先で参照できるようにするためプロパティを定義しておく
@property (nonatomic, assign) id<ForecastViewDelegate> delegate;
@end
