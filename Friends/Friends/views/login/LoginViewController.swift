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
        uiSetup()
        loginViewModel.loginResult.observe(listener: { (LoginStatus) in
            self.hideLoader(view: self.view)
            if(LoginStatus == .failed){
                self.showAlert(message: self.loginViewModel.errorMsg.localizedDescription,tittle: "Login")
            }else if(LoginStatus == .success){
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowFriends", sender: self)
                }
            }
        })
    }
    func uiSetup(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background-image.jpg")!)
//        txt_username.layer.borderWidth = 2
//        txt_username.layer.borderColor = UIColor.white.cgColor
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x:0,y: txt_username.bounds.height,width: txt_username.bounds.width,height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        txt_username.borderStyle = UITextField.BorderStyle.none
        txt_username.layer.addSublayer(bottomLine)
        let color = UIColor.lightText
        let usernamePlaceholder = txt_username.placeholder ?? "Username" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        txt_username.attributedPlaceholder = NSAttributedString(string: " "+usernamePlaceholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x:0,y: txt_password.bounds.height,width: txt_password.bounds.width,height: 1)
        bottomLine2.backgroundColor = UIColor.white.cgColor
        txt_password.borderStyle = UITextField.BorderStyle.none
        txt_password.layer.addSublayer(bottomLine2)
        let passwordPlaceholder = txt_password.placeholder ?? "Password" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        txt_password.attributedPlaceholder = NSAttributedString(string: " "+passwordPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        btn_login.layer.borderColor =  UIColor.white.cgColor
        btn_login.layer.borderWidth = 2
    }
    
    @IBAction func clickedLogin(_ sender: Any) {
        let usernameString = self.txt_username.text ?? ""
        let passwordString = self.txt_password.text ?? ""
        self.loginViewModel.doLogin(usernameString: usernameString,passwordString: passwordString)
        self.showLoader(view: self.view)
        
    }
    

    
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
}
let overlay = UIView()
let indicator = UIActivityIndicatorView()
extension UIViewController{
    func showAlert(message: String , tittle : String){
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Close", style: .destructive) { (action:UIAlertAction) in
            print("cancel");
        }
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func showLoader(view : UIView){
        overlay.frame = view.bounds
        overlay.backgroundColor = UIColor(white: 0, alpha: 0.5)
        indicator.center = CGPoint(x: (view.bounds.width)/2, y: (view.bounds.height)/2)
        indicator.startAnimating()
        view.addSubview(indicator)
        view.addSubview(overlay)
        
    }
    func hideLoader(view : UIView){
        DispatchQueue.main.async {
            overlay.removeFromSuperview()
           // overlay = nil
            indicator.removeFromSuperview()
            //indicator = nil
            }
    }
    
}
