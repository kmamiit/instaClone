//
//  ComposeViewController.swift
//  instaClone
//
//  Created by Kyle Mamiit (New) on 10/28/18.
//  Copyright © 2018 Kyle Mamiit. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    //@IBOutlet weak var caption: UITextView!
    
    @IBOutlet weak var caption: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        caption.delegate = self
        // Do any additional setup after loading the view.
        //var imagePicker: UIImagePickerController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func selectPhoto(){
        print("TAPPED PHOTO")
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        

        //vc.sourceType = UIImagePickerControllerSourceType.camera
        

        self.present(vc, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
            print("Finished")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        print("THIS")
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        print(originalImage);
        imageView.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func onCaption(_ sender: Any) {
//        print("GDGDGDFGDFGDF")
//        if self.textFieldShouldEndEditing(caption){
//            caption.resignFirstResponder();
//            return true;
//        }
//    }
//
    

    @IBAction func onShare(_ sender: Any) {
        print("this")
        //caption.resignFirstResponder()
        Post.postUserImage(image: imageView.image, withCaption: caption.text) { (success: Bool, error: Error?) in
            if success {
                print("Yay, posted user image and caption!")
                self.performSegue(withIdentifier: "shareSegue", sender: nil)
            } else if let error = error  {
                print("AHHHHHHHHHHHHHHH")
                print(error.localizedDescription);
                
                
            }
        }
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        //self.performSegue(withIdentifier: "loginSegue", sender: nil)
        NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil);
        //navigationController?.popViewController(animated: true)
    }
    
    
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
