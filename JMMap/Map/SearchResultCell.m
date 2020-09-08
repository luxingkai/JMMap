//
//  SearchResultCell.m
//  JMMap
//
//  Created by tigerfly on 2020/9/7.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


@end
