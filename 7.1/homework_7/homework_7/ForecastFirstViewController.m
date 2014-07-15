//
//  ForecastFirstViewController.m
//  homework_7
//
//  Created by newbalance on 2014/07/15.
//  Copyright (c) 2014年 newbalance. All rights reserved.
//

#import "ForecastFirstViewController.h"

@interface ForecastFirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtInput;
@property (weak, nonatomic) IBOutlet UIButton *btnReturn;
- (IBAction)postComplaint:(id)sender;

@end

@implementation ForecastFirstViewController

@synthesize txtInput;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.title = @"受付";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // テキストエリアのdelegateを受け取る
    [txtInput setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma なんとこのメソッドを実装しないとテキスト入力から抜け出せない！！！
- (BOOL) textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == [self txtInput]) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (IBAction)postComplaint:(id)sender {
    
    // 愚痴をNotifiction
    NSDictionary *dict = @{@"key":txtInput.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationName" object:self userInfo:dict];

    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"完了" message:@"受け付けたでー"
                              delegate:self cancelButtonTitle:@"おｋ" otherButtonTitles:nil];
    [alert show];
}
@end
