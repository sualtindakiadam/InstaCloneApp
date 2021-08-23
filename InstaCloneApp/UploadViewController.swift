//
//  UploadViewController.swift
//  InstaCloneApp
//
//  Created by Semih Kalaycı on 23.08.2021.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var iimageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        iimageView.isUserInteractionEnabled = true
        let gestureRecogize = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        
        iimageView.addGestureRecognizer(gestureRecogize)
    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        iimageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media") // eğer storage altında media klasörğ varsa onuçağırır yoksa oluşturur. .child dersek te klasör altında klasör şeklinde ilerler
        if let data = iimageView.image?.jpegData(compressionQuality: 0.5){
            let imageRef = mediaFolder.child("image.jpg")
            imageRef.putData(data, metadata: nil) { metaData, error in
                
                
                if error != nil {
                    
                    print(error!.localizedDescription)
                    
                }else{
                    imageRef.downloadURL { url, error in
                        
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        }
                        
                        
                    }
                }
                
                
            }
        }
        
        
    }
    

}
