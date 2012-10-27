//
//  VEPinterestUIView.m
//  PinterestUIMoc
//
//  Created by Mitsuyoshi Yamazaki on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VEPinterestView.h"
//#import <QuartzCore/QuartzCore.h>

CGFloat const _pinterestViewCellMarginRatio = 0.03f; // ratio of line width to margin
CGFloat const _pinterestViewCellMinimumHeightRatio = 0.8f; // ratio of line width to minimum cell height
CGFloat const _pinterestViewCellCornerRadius = 5.0f;
NSUInteger const _pinterestViewDefaultLineCount = 3;
NSInteger const _pinterestViewTagHeaderView = -1;

@interface VEPinterestView ()
- (void)initializePinterestView;
- (UIView *)sectionHeaderViewAtSection:(NSUInteger)section;
- (void)configureCell:(UIView *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectCell:(UITapGestureRecognizer *)tapGestureRecognizer;
- (void)didLongPressCell:(UILongPressGestureRecognizer *)longPressGestureRecognizer;

NSUInteger VEPinterestViewShortestLine(CGFloat lineHeight[], NSUInteger lineCount);
NSUInteger VEPinterestViewLongestLine(CGFloat lineHeight[], NSUInteger lineCount);
CGSize VEPinterestViewFitCellSizeToLineWidth(CGSize size, CGFloat lineWidth);
@end

@implementation VEPinterestView

@synthesize delegate;
@synthesize datasource;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize lineCount = _lineCount;

#pragma mark - Accessor
- (void)setLineCount:(NSUInteger)newValue {
	
	if (newValue == 0) {
		return;
	}
	
	_lineCount = newValue;
	[self reloadData];
}

#pragma mark - Lifecycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializePinterestView];
    }
    return self;
}

- (void)initializePinterestView {
	
	_selectedIndexPath = nil;
	_lineCount = _pinterestViewDefaultLineCount;
}

- (void)dealloc
{
    [_selectedIndexPath release], _selectedIndexPath = nil;
	
    [super dealloc];
}

#pragma mark - Reloading
- (void)reloadData {
	
	if (![self.datasource conformsToProtocol:@protocol(VEPinterestViewDatasource)]) {
		[NSException raise:@"もんだいがおきましたほげ" format:@"でーたそーすがないよ"];
	}
	
	for (UIView *aSubview in self.subviews) {
		[aSubview removeFromSuperview];
	}
	
	NSUInteger sectionCount = [self.datasource numberOfSectionsInPinterestView:self];
	CGFloat sectionHeight = 0.0f;
	CGFloat lineWidth = self.bounds.size.width / (CGFloat)self.lineCount;
	CGFloat cellMargin = lineWidth * _pinterestViewCellMarginRatio;

	for (NSUInteger section = 0; section < sectionCount; section++) {
	
		UIView *sectionHeaderView = [self sectionHeaderViewAtSection:section];
		
		if (sectionHeaderView) {
			CGRect headerViewRect = sectionHeaderView.frame;
			headerViewRect.origin.y += sectionHeight;
			[sectionHeaderView setFrame:headerViewRect];
			
			[self addSubview:sectionHeaderView];
			
			sectionHeight += headerViewRect.size.height + cellMargin * 2.0f;
		}
		
		NSUInteger cellCount = [self.datasource numberOfCellsInPinterestView:self section:section];
		CGFloat lineHeight[self.lineCount];
		
		for (NSUInteger lineIndex = 0; lineIndex < self.lineCount; lineIndex++) {
			lineHeight[lineIndex] = sectionHeight;
		}

		for (NSUInteger cellIndex = 0; cellIndex < cellCount; cellIndex++) {
			
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellIndex inSection:section];
			CGSize cellSize = [self.datasource sizeOfCellInPinterestView:self atIndexPath:indexPath];
			cellSize = VEPinterestViewFitCellSizeToLineWidth(cellSize, lineWidth);
			
			NSUInteger shortestLineIndex = VEPinterestViewShortestLine(lineHeight, self.lineCount);
				
			CGRect cellBackgroundRect;
			cellBackgroundRect.origin.x = shortestLineIndex * lineWidth + cellMargin - 1.0f;
			cellBackgroundRect.origin.y = lineHeight[shortestLineIndex] + cellMargin - 1.0f;
			cellBackgroundRect.size.width = cellSize.width - cellMargin * 2 + 2.0f;
			cellBackgroundRect.size.height = cellSize.height - cellMargin * 2 + 2.0f;
			
			CGRect cellRect = cellBackgroundRect;
			cellRect.origin = CGPointMake(1.0f, 1.0f);
			cellRect.size.width -= 2.0f;
			cellRect.size.height -= 2.0f;
			
			UIView *cellBackgroundView = [[UIView alloc] initWithFrame:cellBackgroundRect];
			cellBackgroundView.backgroundColor = [UIColor clearColor];
//			cellBackgroundView.clipsToBounds = YES;
//			cellBackgroundView.layer.cornerRadius = _pinterestViewCellCornerRadius + 1.0f;
			cellBackgroundView.tag = indexPath.section;
			
			UIView *cell = [[UIView alloc] initWithFrame:cellRect];
			cell.tag = indexPath.row;
			
			[self configureCell:cell atIndexPath:indexPath];
			
			[cellBackgroundView addSubview:cell];
			[cell release];
			
			[self addSubview:cellBackgroundView];
			[cellBackgroundView release];
						
			lineHeight[shortestLineIndex] += cellSize.height;
		}
		
		NSUInteger longestLineIndex = VEPinterestViewLongestLine(lineHeight, self.lineCount);
		sectionHeight = lineHeight[longestLineIndex];		
	}	
	
	CGSize contentSize = self.contentSize;
	contentSize.height = sectionHeight;
	self.contentSize = contentSize;
}

- (void)configureCell:(UIView *)cell atIndexPath:(NSIndexPath *)indexPath {
			
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectCell:)];
	[cell addGestureRecognizer:tapGestureRecognizer];
	[tapGestureRecognizer release];
	
	UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPressCell:)];
	[cell addGestureRecognizer:longPressGestureRecognizer];
	[longPressGestureRecognizer release];
	
	[self.datasource pinterestView:self configureCell:cell atIndexPath:indexPath];
}

- (UIView *)sectionHeaderViewAtSection:(NSUInteger)section {
		
	NSString *headerTitle = nil;
	
	if ([self.datasource respondsToSelector:@selector(pinterestView:titleForHeaderInSection:)]) {
		headerTitle = [self.datasource pinterestView:self titleForHeaderInSection:section];
	}

	if (headerTitle == nil) {
		return nil;
	}

	CGFloat lineWidth = self.bounds.size.width / 3.0f;
	CGFloat cellMargin = lineWidth * _pinterestViewCellMarginRatio;
	
	CGRect headerRect;
	headerRect.origin = CGPointMake(cellMargin, cellMargin);
	headerRect.size.width = self.frame.size.width - (cellMargin * 2.0f);
	headerRect.size.height = 30.0f;
	
	UIView *headerView = [[[UIView alloc] initWithFrame:headerRect] autorelease];
	headerView.backgroundColor = [UIColor darkGrayColor];
	headerView.tag = _pinterestViewTagHeaderView;
	headerView.clipsToBounds = YES;
	
	CGRect titleRect = headerRect;
	titleRect.origin = CGPointMake(5.0f, 5.0f);
	titleRect.size.width -= 10.0f;
	titleRect.size.height -= 10.0f;
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleRect];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.textColor = [UIColor whiteColor];
	
	titleLabel.text = headerTitle;
	
	[headerView addSubview:titleLabel];
	[titleLabel release];
	
//	headerView.layer.cornerRadius = 10.0f;
	headerRect.size.height = 30.0f;
	titleLabel.hidden = NO;
	
	[headerView setFrame:headerRect];
	
	return headerView;
}

#pragma mark - Selection Handler
- (void)didSelectCell:(UITapGestureRecognizer *)tapGestureRecognizer {
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tapGestureRecognizer.view.tag inSection:tapGestureRecognizer.view.superview.tag];
	
	[_selectedIndexPath release], _selectedIndexPath = nil;
	_selectedIndexPath = [indexPath retain];
	
	if ([self.delegate respondsToSelector:@selector(pinterestView:didSelectCellAtIndexPath:)]) {
		[self.delegate pinterestView:self didSelectCellAtIndexPath:indexPath];
	}
}

- (void)didLongPressCell:(UILongPressGestureRecognizer *)longPressGestureRecognizer {

	if (longPressGestureRecognizer.state == UIGestureRecognizerStateBegan) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:longPressGestureRecognizer.view.tag inSection:longPressGestureRecognizer.view.superview.tag];
		
		[_selectedIndexPath release], _selectedIndexPath = nil;
		_selectedIndexPath = [indexPath retain];

		if ([self.delegate respondsToSelector:@selector(pinterestView:didLongPressCellAtIndexPath:)]) {
			[self.delegate pinterestView:self didLongPressCellAtIndexPath:indexPath];
		}
	}
}


#pragma mark - 
NSUInteger VEPinterestViewShortestLine(CGFloat lineHeight[], NSUInteger lineCount) {
	
	NSUInteger index = 0;
	
	for (NSUInteger i = 1; i < lineCount; i++) {
		if (lineHeight[i] < lineHeight[index]) {
			index = i;
		}
	}
	return index;
}

NSUInteger VEPinterestViewLongestLine(CGFloat lineHeight[], NSUInteger lineCount) {
	
	NSUInteger index = 0;
	
	for (NSUInteger i = 1; i < lineCount; i++) {
		if (lineHeight[i] > lineHeight[index]) {
			index = i;
		}
	}
	return index;
}

CGSize VEPinterestViewFitCellSizeToLineWidth(CGSize size, CGFloat lineWidth) {
	
	CGSize fitSize;
	fitSize.width = lineWidth;
	fitSize.height = lineWidth * (size.height / size.width);
	
	CGFloat minimumHeight = lineWidth * _pinterestViewCellMinimumHeightRatio;
	fitSize.height = (fitSize.height < minimumHeight) ? minimumHeight : fitSize.height;
	
	return fitSize;
}

@end
