//
//  FriendsDetailViewController.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/09.
//

import UIKit

class FriendsDetailViewController : UIViewController{
    var friend : FriendModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Friends Detail"
       
        if let choosenFriend = friend {
            
            
            
            name.text = choosenFriend.firstName  + " " + choosenFriend.lastName
            alias.text = friend?.alias
            data_of_birth.text = friend?.dateOfBirth
            status.text =  friend?.status
            
            let imgURL: NSURL = NSURL(string: friend?.imageURL ?? "")!
            let request:NSURLRequest =  NSURLRequest(url: imgURL as URL)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request as URLRequest,    completionHandler: {(data, response, error) in
                DispatchQueue.main.async(execute: { () -> Void in
                    self.profile_image.image = UIImage(data: data ?? Data("".utf8))
                })
            })
            task.resume()
        }
    }
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var alias: UILabel!
    @IBOutlet weak var data_of_birth: UILabel!
    @IBOutlet weak var status: UILabel!
}
