//
//  FeedViewController.swift
//  InstaCloneApp
//
//  Created by Semih Kalaycı on 23.08.2021.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLablem.text = String(likeArray[indexPath.row])
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        
        return cell
    }
    
    func getDataFromFirestore(){
        
        
        
        let fireStoreDAtabase = Firestore.firestore()
        
        /* tarihle ilgili eski versiyonsa bunları eklemek gerekebilir
        let settings = fireStoreDAtabase.settings
         settings.areTimestampsInSnapshotEnamled = true eski sürümlerde olabilir
        fireStoreDAtabase.settings = settings
        */
        
        fireStoreDAtabase.collection("Post").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
                        
                        print("döküman id \(documentID)")
                        if let postedBy = document.get("postedBy") as? String{
                        
                            self.userEmailArray.append(postedBy)
                        }
                        
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.userImageArray.append(imageUrl)
                        }
                        
                        
                        
                        
                    }
                    
                    self.tableView.reloadData()
                    
                    
                }
            }
            
        }
        
        
    }


}
