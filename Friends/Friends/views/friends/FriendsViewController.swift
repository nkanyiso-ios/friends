//
//  FriendsViewController.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/07.
//

import UIKit

class FriendsViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell") as! FriendCell
        cell.lbl_alias_name.text = "First cell"
        
        return cell
    }
    
    var friendsViewModel =  FriendsViewModel()
    var detailViewController: FriendsDetailViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
//
        if let split = splitViewController {
               let controllers = split.viewControllers
               self.detailViewController = (controllers[controllers.count-1] as!
                   UINavigationController).topViewController
                       as? FriendsDetailViewController
           }
//
        
        friendsViewModel.getFriendsList()
        friendsViewModel.friendsListRequest.observe { (RequestStatus) in
            if(RequestStatus == .failed){
                print("failed to load list")
            }else if(RequestStatus == .success){
                print("got list")
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let vc = storyboard.instantiateViewController(identifier: "friendsDetail") as! FriendsDetailViewController
         // vc.text = dataArr[indexPath.row] + " Data"
        splitViewController?.showDetailViewController(detailViewController!, sender: self)
        //splitViewController?.show(detailViewController!, sender: self)
        
      }
}
