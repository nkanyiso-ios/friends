//
//  ViewController.swift
//  Friends
//
//  Created by Nkanyiso Hlela on 2021/03/05.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiSetup()
        loginViewModel.loginResult.observe(listener: { (LoginStatus) in
            if(LoginStatus == .failed){
                self.showAlert(message: self.loginViewModel.errorMsg.localizedDescription)
            }else if(LoginStatus == .success){
//                self.showAlert(message: "login success")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowFriends", sender: self)
                }
            }
        })
    }
    func uiSetup(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        txt_username.layer.borderWidth = 2
        txt_username.layer.borderColor = UIColor.white.cgColor
        let color = UIColor.lightText
        let usernamePlaceholder = txt_username.placeholder ?? "Username" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        txt_username.attributedPlaceholder = NSAttributedString(string: " "+usernamePlaceholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        
        txt_password.layer.borderWidth = 2
        txt_password.layer.borderColor = UIColor.white.cgColor
        let passwordPlaceholder = txt_password.placeholder ?? "Password" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        txt_password.attributedPlaceholder = NSAttributedString(string: " "+passwordPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        btn_login.layer.borderColor =  UIColor.white.cgColor
        btn_login.layer.borderWidth = 2
    }
    
    @IBAction func clickedLogin(_ sender: Any) {
        let usernameString = self.txt_username.text ?? ""
        let passwordString = self.txt_password.text ?? ""
        self.loginViewModel.doLogin(usernameString: usernameString,passwordString: passwordString)
        
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Login", message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Close", style: .destructive) { (action:UIAlertAction) in
            print("cancel");
        }
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
}

