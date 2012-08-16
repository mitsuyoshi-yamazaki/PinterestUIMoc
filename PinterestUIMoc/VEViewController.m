//
//  VEViewController.m
//  PinterestUIMoc
//
//  Created by Mitsuyoshi Yamazaki on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VEViewController.h"

@interface VEViewController ()

@end

@implementation VEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

#pragma mark - VEPinterestViewDelegate 
- (void)pinterestView:(VEPinterestView *)pinterestView didSelectCellAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Cell selected %@", indexPath);
}

- (void)pinterestView:(VEPinterestView *)pinterestView didLongPressCellAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Cell long-pressed %@", indexPath);
}

#pragma mark - VEPinterestViewDatasource 
- (CGSize)sizeOfCellInPinterestView:(VEPinterestView *)pinterestView atIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(100.0f + (rand() % 3) * 100.0f, 100.0f + (rand() % 3) * 100.0f);
}

- (NSUInteger)numberOfSectionsInPinterestView:(VEPinterestView *)pinterestView {
	return 4;
}

- (NSUInteger)numberOfCellsInPinterestView:(VEPinterestView *)pinterestView section:(NSUInteger)section {
	return (section * 5) + 5;
}

- (void)pinterestView:(VEPinterestView *)pinterestView configureCell:(UIView *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	cell.backgroundColor = [UIColor whiteColor];
}

- (NSString *)pinterestView:(VEPinterestView *)pinterestView titleForHeaderInSection:(NSUInteger)section {
	if (section % 2 == 0) {
		return nil;
	}
	return [NSString stringWithFormat:@"Section%02d", section];
}

@end
