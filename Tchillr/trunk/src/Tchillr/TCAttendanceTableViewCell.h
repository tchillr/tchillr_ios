//
//  TCAttendanceTableViewCell.h
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAFocusSegmentedControl.h"

@interface TCAttendanceTableViewCell : UITableViewCell

//@property (nonatomic, weak) IBOutlet UIButton * attendanceButton;
@property (nonatomic, weak) IBOutlet JAFocusSegmentedControl * segmentedControl;

@end
