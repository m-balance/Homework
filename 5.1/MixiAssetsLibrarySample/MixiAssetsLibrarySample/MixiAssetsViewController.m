//
//  MixiAssetsViewController.m
//  MixiAssetsLibrarySample
//
//  Created by 田村 航弥 on 2013/04/30.
//  Copyright (c) 2013年 mixi. All rights reserved.
//

#import "MixiAssetsViewController.h"

@interface MixiAssetsViewController ()

@property (strong, nonatomic) ALAssetsGroup *assetsGroup;
@property (strong, nonatomic) NSMutableArray *assets;
@property (strong, nonatomic) NSMutableArray *selectedIndices;
@property (strong, nonatomic) NSMutableArray *selectedAssets;

@property (weak, nonatomic) IBOutlet UITableView *assetsTableView;

@end

@implementation MixiAssetsViewController

- (id)initWithAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    self = [super initWithNibName:@"MixiAssetsViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _assetsGroup = assetsGroup;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressDoneButton)];

    _assets = [NSMutableArray array];
    _selectedIndices = [NSMutableArray array];
    [_assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        NSLog(@"asset %@", result);
        if(result) [_assets addObject:result];
        else [_assetsTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_assets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }

    ALAsset *asset = _assets[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [asset valueForProperty:ALAssetPropertyDate]];
    [cell.imageView setImage:[UIImage imageWithCGImage:[asset thumbnail]]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index:%d", indexPath.row);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    //TODO : accessoryType が UITableViewCellAccessoryNone だったら     UITableViewCellAccessoryCheckmark を、逆なら None を設定する
    //TODO : 選択された場合 index を _selectedIndices に add する、選択解除された場合 _selectedIndices から index を削除する
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [_selectedIndices addObject: indexPath];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [_selectedIndices removeObject: indexPath];
    }

    //TODO : このままだと _selectedIndices は順番が cell がおかしいので、_selectedIndices をソートする必要がある。ここでソートする。
    NSArray *sorted = [_selectedIndices sortedArrayUsingSelector:@selector(compare:)];
    _selectedIndices = [NSMutableArray arrayWithArray:sorted];
}

#pragma mark - private methods
-(void)pressDoneButton
{
    //TODO : _selectedAssets初期化
    _selectedAssets = [NSMutableArray array];
    
    //TODO : _selectedIndices に入ってる index の　asset を _assets から取得して、_selectedAssets に add する。
    for(NSIndexPath *indexPath in _selectedIndices) {
        ALAsset *asset = [_assets objectAtIndex:indexPath.row];
        [_selectedAssets addObject:asset];
    }

    //TODO : delegate methods コールして assets 渡す
    [self.delegate assetsViewControllerDidSelectedPhotos:_selectedAssets];
}

@end