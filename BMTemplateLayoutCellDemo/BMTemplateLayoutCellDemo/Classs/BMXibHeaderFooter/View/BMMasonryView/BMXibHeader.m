//
//  BMXibHeader.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/28.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMXibHeader.h"
#import "Masonry.h"
#import "UITableViewHeaderFooterView+BMReusable.h"

@interface BMMasonryView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation BMMasonryView

@end


@interface BMXibHeader ()

kBMTableViewHeaderFooterViewProperty(BMMasonryView, masonryView)

@end

@implementation BMXibHeader

kBMTableViewHeaderFooterViewInit(BMMasonryView, masonryView)

- (void)setModel:(BMModel *)model {
    if (_model == model) {
        return;
    }
    _model = model;
    self.masonryView.nameLabel.text = [NSString stringWithFormat:@"%@ - %@", model.name, model.ID];
    self.masonryView.iconImageView.image = [UIImage imageNamed:model.icon];
    self.masonryView.descLabel.text = model.desc;
}

@end
