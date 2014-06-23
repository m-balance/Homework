//
//  TVSCustomCell.m
//  TableViewSample
//
//  Created by 武田 祐一 on 2013/04/23.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "TVSCustomCell.h"

@implementation TVSCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(CGFloat)calculateCellHeightWithText:(NSString *)text
{
    // TODO : UILabel の高さ計算 [2]
    // HINT : (CGSize)     sizeWithFont:(UIFont *)font
    //                constrainedToSize:(CGSize)size
    //                    lineBreakMode:(NSLineBreakMode)lineBreakMode
    // ひとまずMAXの高さは1000を設定
    CGSize size = [text sizeWithFont:_bodyLabel.font
                   constrainedToSize:CGSizeMake(_bodyLabel.frame.size.width, 1000)
                       lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat top = 20.0f;
    CGFloat bottom = 20.0f;
    return size.height + top + bottom;
}

@end
