//
//  VEPinterestUIView.h
//  PinterestUIMoc
//
//  Created by Mitsuyoshi Yamazaki on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VEPinterestView;

@protocol VEPinterestViewDelegate <NSObject, UIScrollViewDelegate>
@optional
- (void)pinterestView:(VEPinterestView *)pinterestView didSelectCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)pinterestView:(VEPinterestView *)pinterestView didLongPressCellAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol VEPinterestViewDatasource <NSObject>
@required
- (CGSize)sizeOfCellInPinterestView:(VEPinterestView *)pinterestView atIndexPath:(NSIndexPath *)indexPath;
- (NSUInteger)numberOfSectionsInPinterestView:(VEPinterestView *)pinterestView;
- (NSUInteger)numberOfCellsInPinterestView:(VEPinterestView *)pinterestView section:(NSUInteger)section;
- (void)pinterestView:(VEPinterestView *)pinterestView configureCell:(UIView *)cell atIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSString *)titleForHeaderInSection:(NSUInteger)section;
@end

@interface VEPinterestView : UIScrollView

@property (nonatomic, assign) id <VEPinterestViewDelegate> delegate;
@property (nonatomic, assign) id <VEPinterestViewDatasource> datasource;

@end
