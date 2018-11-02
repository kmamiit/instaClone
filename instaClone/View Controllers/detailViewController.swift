//
//  detailViewController.swift
//  instaClone
//
//  Created by Kyle Mamiit (New) on 11/1/18.
//  Copyright © 2018 Kyle Mamiit. All rights reserved.
//

import UIKit
import Parse

class detailViewController: UIViewController {

    @IBOutlet weak var detailedImageView: UIImageView!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!

    var post: Post?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View Loaded")
        
        if let post = post {
            print("Post = Post")
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = DateFormatter.Style.short
            dateformatter.timeStyle = DateFormatter.Style.short
            let date = dateformatter.string(from: post.createdAt!)
            
            timestampLabel.text = date
            captionLabel.text = post.caption
            
            
            if let imageFile: PFFile = post.media {
                imageFile.getDataInBackground(block: { (data, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data!)
                            self.detailedImageView.image = image;
                        }
                    } else {
                        print(error?.localizedDescription);
                    }
                })
            }
            
        }
        print("It's not post = post")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
