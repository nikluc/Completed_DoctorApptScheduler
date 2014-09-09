//
//  doctorsLoginView.h
//  DoctorApptScheduler
//
//  Created by administrator on 11/08/14.
//
//

#import "ViewController.h"


@interface doctorsLoginView : ViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIScrollViewDelegate>

{
    NSArray *artArrayChooseDesg;
    NSArray *artArrayDoctorId;
	NSMutableData* responseDoctorRegister;
    UIImagePickerController* imagePickerViewController;
   
    UIImageView * logoDoc;
   
   
}

@property (nonatomic, weak) IBOutlet UILabel *logLicence;
@property (nonatomic, weak) IBOutlet UILabel *logDesignation;
@property (nonatomic, weak) IBOutlet UILabel *logFirstname;
@property (nonatomic, weak) IBOutlet UILabel *logLastname;
@property (nonatomic, weak) IBOutlet UILabel *logEmail;
@property (nonatomic, weak) IBOutlet UILabel *logPhone;
@property (nonatomic, weak) IBOutlet UILabel *logAddress;
@property (nonatomic, weak) IBOutlet UILabel *logCity;
@property (nonatomic, weak) IBOutlet UILabel *logState;
@property (nonatomic, weak) IBOutlet UILabel *logCountry;
@property (nonatomic, weak) IBOutlet UILabel *logPincode;
@property (nonatomic, weak) IBOutlet UILabel *logPass;
@property (nonatomic, weak) IBOutlet UILabel *logAge;
@property (nonatomic, weak) IBOutlet UILabel *logDescription;



@property (nonatomic, strong) IBOutlet UIImageView *logoDoc;
@property (nonatomic, weak) IBOutlet UITextField *logGenderText;

@property (nonatomic, weak) IBOutlet UITextField *logAgeText;
@property (nonatomic, weak) IBOutlet UITextField *logLicenceText;
@property (nonatomic, weak) IBOutlet UITextField *logDesignationText;
@property (nonatomic, weak) IBOutlet UITextField *logFirstnameText;
@property (nonatomic, weak) IBOutlet UITextField *logLastnameText;
@property (nonatomic, weak) IBOutlet UITextField *logEmailText;
@property (nonatomic, weak) IBOutlet UITextField *logPhoneText;
@property (nonatomic, weak) IBOutlet UITextField *logAddressText;
@property (nonatomic, weak) IBOutlet UITextField *logCityText;
@property (nonatomic, weak) IBOutlet UITextField *logStateText;
@property (nonatomic, weak) IBOutlet UITextField *logCountryText;
@property (nonatomic, weak) IBOutlet UITextField *logPincodeText;
@property (nonatomic, weak) IBOutlet UITextField *logPassReg;
@property (nonatomic, weak) IBOutlet UITextField *logDesignationTextId;

@property (nonatomic, weak) IBOutlet UITextView *logDesgText;

@property (nonatomic, weak) IBOutlet UITextField *logDoctorId;
@property (nonatomic, weak) IBOutlet UITextField *logDoctorPassword;
@property (nonatomic, weak) IBOutlet UITextField *logPasswordReq;

@property (strong, nonatomic) IBOutlet UIButton *uploadPic;
@property (strong, nonatomic) IBOutlet UIButton *doctorLogin;
@property (strong, nonatomic) IBOutlet UIButton *doctorRegister;
@property (strong, nonatomic) IBOutlet UIButton *forgotPassword;
@property (strong, nonatomic) IBOutlet UIButton *sendPasswordRequest;
@property (retain, nonatomic) NSMutableData* responseDoctorRegister;

- (IBAction)indexChanged:(UISegmentedControl *)sender;

- (IBAction)doctorLogin:(id)sender;
- (IBAction)doctorRegister:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)sendPasswordRequest:(id)sender;
- (IBAction)uploadPic:(id)sender;


@end
