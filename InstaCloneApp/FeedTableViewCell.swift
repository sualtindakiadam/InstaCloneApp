//
//  FeedTableViewCell.swift
//  InstaCloneApp
//
//  Created by Semih Kalaycı on 23.08.2021.
//

import UIKit
import Firebase

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLablem: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let firestoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLablem.text!) {
            
            let likeStore = ["likes" : likeCount+1 ] as [String : Any]
            
            firestoreDatabase.collection("Post").document(documentIdLabel.text!).setData(likeStore, merge: true) // sadece like değiş tirmeyi sağlar merge olunca diğerleri aynı kalır
        }
        
      
        
        
    }
    
}
