//
//  FriendsViewController.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/07.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    var friendsViewModel =  FriendsViewModel()
    var detailViewController: FriendsDetailViewController? = nil
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
          return friendsViewModel.friendsList?.count ?? 0
      }
      
  
      
      // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 5
      }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell") as! FriendCell
        let friend = friendsViewModel.friendsList?[indexPath.section]
        cell.lbl_alias_name.text = friend?.alias
        cell.lbl_last_time.text = friend?.lastName
        let imgURL: NSURL = NSURL(string: friend?.imageURL ?? "")!
        let request:NSURLRequest =  NSURLRequest(url: imgURL as URL)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest,    completionHandler: {(data, response, error) in
            DispatchQueue.main.async(execute: { () -> Void in
                cell.profile_image.image = UIImage(data: data ?? Data("".utf8))
            })
        })
        task.resume()
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Friends List"
        self.showLoader(view: self.view)
        if let split = splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as!
                                            UINavigationController).topViewController
                as? FriendsDetailViewController
        }
        
        //
        
        friendsViewModel.getFriendsList()
        friendsViewModel.friendsResult.observe { (RequestStatus) in
            self.hideLoader(view: self.view)
            if(RequestStatus == .failed){
                print("failed to load list")
            }else if(RequestStatus == .success){
                print("got list")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // performSegue(withIdentifier: "showFriendsDetail", sender: self)
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "friendsDetail") as! FriendsDetailViewController
        detailVC.friend = friendsViewModel.friendsList?[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
