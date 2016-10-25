//
//  DrawView.h
//  DrawingBoard
//
//  Created by ZhouYong on 16/10/25.
//  Copyright © 2016年 Rephontil/Yong Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (nonatomic, strong)UIColor *pathColour;
@property (nonatomic, assign)CGFloat lineWidth;

@property (nonatomic ,strong)UIImage *image;


- (void)clean;
- (void)unDo;
- (void)eraser;

@end
