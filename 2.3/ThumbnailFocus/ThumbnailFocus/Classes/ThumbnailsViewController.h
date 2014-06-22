//
//  ThumbnailsViewController.h
//  ThumbnailFocus
//
//  Created by 鄭 基旭 on 2013/04/18.
//  Copyright (c) 2013年 鄭 基旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusManager.h"

#warning ★HomeWork：iPadの回転にも対応する為に、本Projectをユニバーサルアプリに修正してください。
/*
 【 条件・ヒント 】
 1. Project設定を修正する。（info.plistにも追加や修正が必要）
　→ ThumbnailFocus-Info.plistを修正してユニバーサルアプリにしました
 2. Newファイルを追加（ファイル名は ThumbnailsViewController~ipad.xib）
　→ ThumbnailViewPadControllerPad.xibファイルを追加しました
 3. iPhone版と違うUIパターンを適用します。UITableViewは使わずに IBOutletCollection(UIImageView) を使って下さい
    TableViewみたいなスクロール機能は必要ありませんので、XIB上で直接につながっても構いません。
　→ ThumbnailViewPadControllerPad.xib上にUIMageViewを生成しました
 4. 修正クラスはThumbnailsViewControllerに限ります。
　→ 起動時にThumbnailsViewController.m内のinitWithNibNameでxibファイルを切り替えました
 　 
*/

@interface ThumbnailsViewController : UIViewController<FocusDelegate>
@end
