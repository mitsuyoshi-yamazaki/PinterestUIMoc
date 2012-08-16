//
//  VEPinterestUIViewController.h
//  PinterestUIMoc
//
//  Created by Mitsuyoshi Yamazaki on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VEPinterestView.h"

@interface VEPinterestViewController : UIViewController <VEPinterestViewDelegate, VEPinterestViewDatasource>

@property (nonatomic, readonly) VEPinterestView *pinterestView;

@end
