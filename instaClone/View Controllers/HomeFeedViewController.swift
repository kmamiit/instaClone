//
//  HomeFeedViewController.swift
//  instaClone
//
//  Created by Kyle Mamiit (New) on 10/28/18.
//  Copyright © 2018 Kyle Mamiit. All rights reserved.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 300
        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeFeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        
        
        
//        let query = Post.query();
//
//        //query?.whereKey("likesCount", greaterThan: 0)
//        query?.includeKey("createdAt")
//        query?.limit = 20
//
//        query?.findObjectsInBackground(block: { (Post, error: Error?) -> Void in
//            if let posts = Post {
//                self.posts = posts as! [Post] //////////
//                self.tableView.reloadData() ///////////
//            } else {
//                print("Couldn't fetch in background");
//                print(error?.localizedDescription);
//            }
//        })
        fetchPosts()
    }

    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchPosts()
    }
    
    func fetchPosts(){
        // let url = URL
        
        // construct PFQuery
        let query = Post.query();
        query?.order(byDescending: "createdAt")
        query?.includeKey("Author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (Post, error: Error?) -> Void in
            if let posts = Post {
                self.posts = posts as! [Post] //////////
                self.tableView.reloadData() ///////////
                self.refreshControl.endRefreshing()
            } else {
                print("Couldn't fetch in background");
                print(error?.localizedDescription);
            }
        })
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSignOut(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil);
        
        /*
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful logout")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.window?.rootViewController = loginViewController;
            }
        }
        */
    }
    
    
    @IBAction func onCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "composeSegue", sender: nil)
    }
    
 

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! postCell
        
        let post = posts[indexPath.row]
        print(post)
        cell.captionLabel.text = post.caption
        if let imageFile: PFFile = post.media {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        cell.postImageView.image = image;
                    }
                } else {
                    print(error?.localizedDescription);
                }
            })
        }
        
        return cell;
//        if let photo = post.media {
//            photo.getDataInBackGround
//        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let post = posts[indexPath.row]
            let detailViewController = segue.destination as! detailViewController
            detailViewController.post = post
        }
        
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
