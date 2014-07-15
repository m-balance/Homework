//
//  ForecastSecondViewController.m
//  homework_7
//
//  Created by newbalance on 2014/07/15.
//  Copyright (c) 2014年 newbalance. All rights reserved.
//

#import "ForecastSecondViewController.h"

@interface ForecastSecondViewController ()

@property (strong, nonatomic) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UITableView *tableList;

- (IBAction)btnClear:(id)sender;

@end

@implementation ForecastSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.title = @"表示";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

-(void)dealloc
{
    // メモリ破棄時に通知センターから削除する
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // items の初期化
    _items = [NSMutableArray array];
    
    // tableview の初期化
    self.tableList.delegate = self;
    self.tableList.dataSource = self;
    
    // 通知センターの登録
    //  メッセージを受け取ったら usingBlock が実行されるので、ここで items に要素を追加する
    [[NSNotificationCenter defaultCenter] addObserverForName:@"notificationName"
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      NSDictionary *userInfo = note.userInfo;
                                                      NSLog(@"%@:%@", @"usingBlock", userInfo[@"key"]);
                                                      [self.items insertObject:userInfo[@"key"] atIndex:0];
                                                  }];

}

- (void)viewDidAppear:(BOOL)animated
{
    // 表示されるたびに tableview をリロードして表示を更新する
    [_tableList reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // items のカウントを tableview の行数にする
    return [_items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // セルの設定 items を元に tableview を構築する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    NSString *text = [_items objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (IBAction)btnClear:(id)sender {
    // items をクリアして再描画
    [_items removeAllObjects];
    [_tableList reloadData];
}


@end
