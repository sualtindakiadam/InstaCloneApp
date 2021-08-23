//
//  ViewController.swift
//  InstaCloneApp
//
//  Created by Semih Kalaycı on 23.08.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    
    }

    @IBAction func singInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text! , password: passwordText.text!) { authData, error in
                if error != nil {
                    self.makeAlert(titleInput: "ERROR!", messageInput: error!.localizedDescription ?? "Error")
                            
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        
        
        }else{
            makeAlert(titleInput: "ERROR!", messageInput: "USERNAME or  PASSWORD can not be nil!")
          
        }
        
    
    }
    @IBAction func singUpClicked(_ sender: Any) {
        
        
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                
                if error != nil {
                    self.makeAlert(titleInput: "ERROR!", messageInput: error!.localizedDescription ?? "Error")
                            
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }

            
        }
        else{
            makeAlert(titleInput: "ERROR!", messageInput: "USERNAME or  PASSWORD can not be nil!")
          
        }
        
    
        
        
    }
    
    func  makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput  , message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

