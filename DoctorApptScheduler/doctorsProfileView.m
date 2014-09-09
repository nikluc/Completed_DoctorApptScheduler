//
//  doctorsProfileView.m
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "doctorsProfileView.h"
#import "doctorsListView.h"

@interface doctorsProfileView ()

@end

@implementation doctorsProfileView
@synthesize photoViewPro,nameViewPro,designationViewPro,addressViewPro,countryViewPro,emailViewPro,profileViewPro,imageViewPro;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.nameViewLab.text=nameViewPro;
    self.designationViewLab.text=designationViewPro;
    self.addressViewLab.text=addressViewPro;
    self.countryViewLab.text=countryViewPro;
    self.emailViewLab.text=emailViewPro;
    self.profileViewLab.text=profileViewPro;
    
    
    NSLog(@"vdfhgdfgsfg%@",photoViewPro);

    
 //   self.imageViewPro.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: photoViewPro]]];
    
    imageViewPro.layer.cornerRadius = 25;
    imageViewPro.layer.borderWidth = 2.0f;
    imageViewPro.layer.borderColor = [UIColor cyanColor].CGColor;
    imageViewPro.clipsToBounds = YES;

  //  NSData *imageData = UIImagePNGRepresentation(imageViewPro.image);
   // NSString *imageString = [[NSString alloc] initWithData:imageData encoding:NSASCIIStringEncoding];
    
    NSLog(@"photooooooo :%@",imageViewPro);
   
    
    
    
   
    
    
    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"Back"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(OnClick_btnBack:)];
    self.navigationItem.leftBarButtonItem = btnBack;

    
}
-(IBAction)OnClick_btnBack:(id)sender  {
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController pushViewController:self.navigationController.parentViewController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:
(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"Did begin editing");
}
-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"Did Change");
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"Did End editing");
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}


@end
