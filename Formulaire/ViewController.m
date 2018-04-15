//
//  ViewController.m
//  Formulaire
//
//  Created by AB2R AB2R on 28/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
 

@implementation ViewController
@synthesize labelNom, labelPrenom, labeladresseemail, buttonvalider, boutonSelectionPhoto, popOverController, photo,
selecteurPhoto, infos; 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{  [super viewDidLoad];
	
    //On initialise notre variable de type UIImagePickerController et on lui donne son delegate
    selecteurPhoto = [[UIImagePickerController alloc] init];
    [selecteurPhoto setDelegate:self];
    
    //La source que nous allons afficher. Ici la librairie de photos
    [selecteurPhoto setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    //On initialise notre variable de type UIPopOverController en lui indiquant qu'il contiendra comme view controller imagePickerController
    //On lui donne son delegate
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:selecteurPhoto];    
    popover.delegate = self;
    
    //On donne au popOverController de la vue notre variable de type UIPopOverController
    self.popOverController = popover;
    [popover release];   
    
     // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{  // [self setToolBarBtn:nil];
  //  [self setNormalBtn:nil];
    [self setPhoto:nil];
    //[super viewDidUnload];
   // [super viewDidUnload];
    // Release any retained subviews of the main view.
}
/*- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}*/

- (void)dealloc {
   // [toolBarBtn release];
    //[normalBtn release];
    [photo release];
    [super dealloc];
}

//Fonction qui permet d'afficher la bibliothèque de photos via un bouton normal
- (IBAction)selectionnerPhoto:(id)sender {
    //On crée une variable de type CGRect pour indiquer à partir de quel endroit on va anchrer notre popOverController
    //Ici on veut l'attacher au bouton
    CGRect popoverRect = self.boutonSelectionPhoto.frame;
    //La même chose que pour la fonction précédente à cela près que l'on indique pas de quel BarButtonItem on veut afficher la fenêtre mais ici de quelle localisation via un CGRect
    [self.popOverController presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

//Fonction qui permet de récupérer l'image sélectionnée
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image              editingInfo:(NSDictionary *)editingInfo
{
    //On affiche l'image dans l'ImageView
    [photo setImage:image];
    //On fait disparaître le popOver
    [self.popOverController dismissPopoverAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];


}



- (IBAction) clicformulaire:(id)sender {
    //NSLog(@"click");
    //}
    NSData *imageData = UIImageJPEGRepresentation(photo.image, 90);
	
	// Paramétrage de l'URL de destination (application Web PHP réceptionnant le photo)
	NSString *urlString = @"http://192.168.1.153/test-upload.php";
	
	// Instanciation de la requête HTTP
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
	
	// Paramétrage de l'entête du message
	NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]]; 
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"photo.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	// Ajout du corps du message à la requête HTTP
	[request setHTTPBody:body];

    
    
   
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
   
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
  
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];  
    
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Nom\"\r\n\r\n%@", labelNom.text] dataUsingEncoding:NSUTF8StringEncoding]];  
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]]; 
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Prenom\"\r\n\r\n%@", labelPrenom.text] dataUsingEncoding:NSUTF8StringEncoding]];  
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]]; 
    
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"adresseemail\"\r\n\r\n%@", labeladresseemail.text] dataUsingEncoding:NSUTF8StringEncoding]];  
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    
	// Ajout du corps du message à la requête HTTP
	[request setHTTPBody:body];
	
	// Lancement de la requête HTTP
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
    NSString *testbody = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    
	// Affichage d'un message de contrôle en mode console
	NSLog(@"%@", returnString);    
    
} 

/*- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fond-ap-photo.jpg"]];
    compteur = 0;
}*/

/*- (void)imagePickerController:(UIImagePickerController *) Picker didFinishPickingMediaWithInfo:(NSDictionary *)photo 
{
    UIImage *image = [photo objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self dismissModalViewControllerAnimated:YES];
    
    

 
}*/

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    compteur++;
    if (compteur == 1)
        infos.text = @"1 photo ajoutée à l'album photo";
    else
        infos.text = [NSMutableString stringWithFormat:@"%i %@", compteur, @"photos ajoutées à l'album photo."];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker 
{    [self dismissModalViewControllerAnimated:YES];
     
}



/*- (void)viewDidUnload
{
    [self setInfos:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker 
{
    [[Picker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}*/

- (IBAction)prendPhoto:(id)sender 
{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:picker animated:YES];
}



@end
