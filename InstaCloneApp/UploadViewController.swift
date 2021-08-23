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
    
    func makeAlert(titleInput:String, messageInput:String){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    
    }
    
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media") // eğer storage altında media klasörğ varsa onuçağırır yoksa oluşturur. .child dersek te klasör altında klasör şeklinde ilerler
        if let data = iimageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { metaData, error in
                
                
                if error != nil {
                    
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    
                }else{
                    imageRef.downloadURL { url, error in
                        
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            //database işlemlerini
                            let fireStoreDatabase = Firestore.firestore()
                            
                            
                            var fireStoreRef : DocumentReference? = nil
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy": Auth.auth().currentUser!.email, "postComment":self.commentText.text!,"date":FieldValue.serverTimestamp(), "likes":0] as [String : Any]
                            
                            fireStoreRef = fireStoreDatabase.collection("Post").addDocument(data: firestorePost, completion: { error in
                                
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput:error?.localizedDescription ?? "Error")
                                }else{
                                    self.iimageView.image = UIImage(named: "uploadImage.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            })
                            



                        }
                        
                        
                    }
                }
                
                
            }
        }
        
        
    }
    

}
