//
//  historyOfVisitToDoctor.h
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "ViewController.h"

@interface historyOfVisitToDoctor : ViewController<UITableViewDataSource,
UITableViewDelegate>

{
      IBOutlet UITableView *patTableView;
    IBOutlet UITextField *patAcceptReject;
    IBOutlet UILabel *patientName;
    NSArray *artArrayPendingList;
  
}
- (IBAction)indexChanged:(UISegmentedControl *)sender;
@property (nonatomic, strong) UITextField *patAcceptReject;
@property (nonatomic, strong) UITableView *patTableView;

@property (nonatomic, strong) NSString *patientId;
@property (nonatomic, strong) NSString *patName;

@property (nonatomic, strong) UILabel *patientName;


@end
