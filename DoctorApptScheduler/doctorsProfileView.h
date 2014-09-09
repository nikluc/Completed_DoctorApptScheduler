//
//  doctorsProfileView.h
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "ViewController.h"

@interface doctorsProfileView : ViewController<UITextViewDelegate>
{
    UIImageView *imageViewPro;
}

@property (nonatomic, strong) NSString *photoViewPro;
@property (nonatomic, strong) NSString *nameViewPro;
@property (nonatomic, strong) NSString *designationViewPro;
@property (nonatomic, strong) NSString *addressViewPro;
@property (nonatomic, strong) NSString *countryViewPro;
@property (nonatomic, strong) NSString *emailViewPro;
@property (nonatomic, strong) NSString *profileViewPro;


@property (nonatomic, weak) IBOutlet UILabel *nameViewLab;
@property (nonatomic, weak) IBOutlet UILabel *designationViewLab;
@property (nonatomic, weak) IBOutlet UILabel *addressViewLab;
@property (nonatomic, weak) IBOutlet UILabel *countryViewLab;
@property (nonatomic, weak) IBOutlet UILabel *emailViewLab;
@property (nonatomic, weak) IBOutlet UITextView *profileViewLab;

@property (nonatomic, retain)IBOutlet UIImageView *imageViewPro;

@end
