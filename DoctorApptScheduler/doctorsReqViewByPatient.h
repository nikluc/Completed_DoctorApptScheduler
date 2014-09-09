//
//  doctorsReqViewByPatient.h
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "ViewController.h"

@interface doctorsReqViewByPatient : ViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    IBOutlet UILabel *testLabelField;
    UIActionSheet *aac;
    UIDatePicker *theDatePicker;
    UIImageView *imageViewPro;
    
    NSArray *reasonArtArray;
    
	NSMutableData* reasonResponseData;
}
@property (retain, nonatomic) NSMutableData* reasonResponseData;

@property (nonatomic, strong) NSString *photoView;
@property (nonatomic, strong) NSString *nameView;
@property (nonatomic, strong) NSString *designationView;
@property (nonatomic, strong) NSString *addressView;
@property (nonatomic, strong) NSString *countryView;
@property (nonatomic, strong) NSString *doctorIdView;

@property (nonatomic, weak) IBOutlet UILabel *photoViewLab;
@property (nonatomic, weak) IBOutlet UILabel *nameViewLab;
@property (nonatomic, weak) IBOutlet UILabel *designationViewLab;
@property (nonatomic, weak) IBOutlet UILabel *addressViewLab;
@property (nonatomic, weak) IBOutlet UILabel *countryViewLab;






@property (nonatomic, weak) IBOutlet UITextField *selDate;
@property (nonatomic, weak) IBOutlet UITextField *reasonText;
@property (nonatomic, weak) IBOutlet UITextField *reasonTextId;
@property (nonatomic, weak) IBOutlet UITextField *emailText;
@property (nonatomic, weak) IBOutlet UITextField *passwordText;
@property (nonatomic, weak) IBOutlet UITextField *regFirstName;
@property (nonatomic, weak) IBOutlet UITextField *regLastName;
@property (nonatomic, weak) IBOutlet UITextField *regEmail;
@property (nonatomic, weak) IBOutlet UITextField *regPassword;
@property (nonatomic, weak) IBOutlet UITextField *regAge;
@property (nonatomic, weak) IBOutlet UITextField *sexSegment;


@property (nonatomic, weak) IBOutlet UILabel *selDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *reasonLabel;
@property (nonatomic, weak) IBOutlet UILabel *enterDetails;
@property (nonatomic, weak) IBOutlet UILabel *loginEmail;
@property (nonatomic, weak) IBOutlet UILabel *loginPassword;
@property (nonatomic, weak) IBOutlet UILabel *signupName;
@property (nonatomic, weak) IBOutlet UILabel *signupEmail;
@property (nonatomic, weak) IBOutlet UILabel *signupPassword;
@property (nonatomic, weak) IBOutlet UILabel *signupAge;
@property (nonatomic, weak) IBOutlet UILabel *signupSex;
@property (strong, nonatomic) IBOutlet UIButton *requestAppt;

@property (strong, nonatomic) IBOutlet UIButton *patientRegistration;
@property (nonatomic, retain)IBOutlet UIImageView *imageViewPro;





- (IBAction)indexChanged:(UISegmentedControl *)sender;
- (IBAction)sexChanged:(UISegmentedControl *)sender;



@end
