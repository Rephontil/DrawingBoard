//
//  DrawView.m
//  DrawingBoard
//
//  Created by ZhouYong on 16/10/25.
//  Copyright © 2016年 Rephontil/Yong Zhou. All rights reserved.
//

#import "DrawView.h"
#import "BezierPathColour.h"

@interface DrawView ()

@property (nonatomic, strong)BezierPathColour *path;
//用于存放路径的数据源
@property (nonatomic, strong)NSMutableArray *pathArray;


@end

@implementation DrawView

- (NSMutableArray<BezierPathColour *> *)pathArray{
    if (_path == nil) {
        _pathArray = [NSMutableArray arrayWithCapacity:0];
    }
    return  _pathArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];

    }return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setUp];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.pathArray addObject:_image];
    [self setNeedsDisplay];
    
}

- (void)setUp
{
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    _path.lineWidth = 2;
    _lineWidth = 2;
    _path.pathColour = [UIColor blackColor];
    
}

- (void)pan: (UIPanGestureRecognizer *)pan
{
//    手指位置
    CGPoint currentPoint = [pan locationInView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        _path = [[BezierPathColour alloc] init];
        _path.pathColour = self.pathColour;
        _path.lineWidth = self.lineWidth;
        [_pathArray addObject:_path];
        [_path moveToPoint:currentPoint];
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        [_path addLineToPoint:currentPoint];

        
    }
    //每次手指滑动都要调用drawRect方法
    [self setNeedsDisplay];
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    for (BezierPathColour *path in self.pathArray) {

        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else{
            [path.pathColour set];
            [path stroke];
        }
        
    }

}

- (void)clean{
    [self.pathArray removeAllObjects];
//    self.pathArray = nil;  //如果赋值nil的话,下次使用这个可变数组的时候需要重新初始化
    [self setNeedsDisplay];
}

- (void)unDo{
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)eraser{
    _pathColour = [UIColor whiteColor];
    _lineWidth = 10;
    [self setNeedsDisplay];

}






@end
