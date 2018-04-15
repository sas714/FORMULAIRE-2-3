//
//  ViewController.h
//  Formulaire
//
//  Created by AB2R AB2R on 28/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate> {
    IBOutlet UITextField *labelNom;
    IBOutlet UITextField *labelPrenom;
    IBOutlet UITextField *labeladresseemail;
    IBOutlet UIButton * buttonvalider;
    // Bouton de lancement de la sélection de la photo
	IBOutlet UIButton *boutonSelectionPhoto;
    // Bouton de l'upload de la photo
	//IBOutlet UIButton *boutonUploadPhoto;
    // Photo sélectionnée pour l'upload
	IBOutlet UIImageView *photo;
	// Sélecteur de photos
	//UIImagePickerController *selecteurPhoto;
    UIImagePickerController *picker;
    int compteur;
    
}
@property (retain,nonatomic) UITextField *labelNom;  
@property (retain,nonatomic) UITextField *labelPrenom;
@property (retain,nonatomic) UITextField *labeladresseemail;
@property (retain,nonatomic) UIButton * buttonvalider;
@property (nonatomic, retain) IBOutlet UIButton *boutonSelectionPhoto;
//@property (nonatomic, retain) IBOutlet UIButton *boutonUploadPhoto;
@property (nonatomic, retain) IBOutlet UIImageView *photo;
@property (nonatomic, retain) UIImagePickerController *selecteurPhoto;
@property (nonatomic, retain) UIPopoverController *popOverController;


//-(IBAction)selectionnerPhoto;
- (IBAction)selectionnerPhoto:(id)sender;
- (IBAction)uploaderPhoto;

- (IBAction) clicformulaire:(id)sender;    

@property (nonatomic, retain) IBOutlet UILabel *infos;
- (IBAction)prendPhoto:(id)sender;

@end
