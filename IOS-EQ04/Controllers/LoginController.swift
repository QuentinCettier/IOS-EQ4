//
//  LoginController.swift
//  IOS-EQ04
//
//  Created by Quentin on 14/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginController: UIViewController {
    
    
    let navigationBar: UINavigationBar = {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let bar = UINavigationBar(frame: CGRect(x:0, y:20, width:screenSize.width, height: 44))
        bar.barTintColor = UIColor(hex: "F89934")
        bar.isTranslucent = false
        let navItem = UINavigationItem(title: "Login")
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "FFFFFF")]
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(handledismiss))
        navItem.leftBarButtonItem = backButton
        backButton.tintColor = UIColor(hex: "FFFFFF")
        
        bar.setItems([navItem], animated: false)
        
        return bar

    }()
    
    
    let loginImage : UIImageView = {
        var img = UIImageView()
        img = UIImageView(frame:CGRect(x:10, y:50, width:189, height:180));
        img.image = UIImage(named:"space.png")
        
        return img
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.frame = (CGRect(x: 0, y: 0, width: 150, height: 44))
        label.text = "Email"
        label.font = UIFont(name: "SF Pro Text-Medium", size: 10.0)
        label.textColor = UIColor(hex: "000000")
        
        return label
    }()
    
    let emailInput: UITextField = {
        let input = UITextField()
        input.frame = (CGRect(x: 0, y: 0, width: 0, height: 0))
        input.placeholder = "exemple@gmail.com"
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.keyboardType = UIKeyboardType.emailAddress
        input.autocorrectionType = UITextAutocorrectionType.no
        input.autocapitalizationType = .none

        return input
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.frame = (CGRect(x: 0, y: 0, width: 150, height: 44))
        label.text = "Password"
        label.font = UIFont(name: "SF-Pro-Text-Medium", size: 17.0)
        label.textColor = UIColor(hex: "000000")
        
        return label
    }()
    
    let passwordInput: UITextField = {
        let input = UITextField()
        input.frame = (CGRect(x: 0, y: 0, width: 0, height: 0))
        input.placeholder = "password1234"
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.isSecureTextEntry = true
        
        return input
    }()
    
    let LoginButton: UIButton = {
        var btn = UIButton()
        
        btn.frame = (CGRect(x: 0, y: 0, width: 100, height: 0))
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SF-Pro-Text-Medium", size: 19.0)
        btn.backgroundColor = UIColor(hex: "F89934")
        btn.layer.cornerRadius = 15
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.2
        
        btn.addTarget(self, action: #selector(handleLoginAction), for: .touchUpInside)
        
        return btn
    }()
    
    let returnButton: UIButton = {
        var btn = UIButton()
        
        btn.frame = (CGRect(x: 0, y: 0, width: 100, height: 0))
        btn.setTitle("Back", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SF-Pro-Text-Medium", size: 19.0)
        btn.backgroundColor = UIColor(hex: "F89934")
        btn.layer.cornerRadius = 15
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.2
        
//        btn.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
        
        return btn
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        

        view.addSubview(LoginButton)
        view.addSubview(emailLabel)
        view.addSubview(emailInput)
        view.addSubview(passwordLabel)
        view.addSubview(passwordInput)
        view.addSubview(loginImage)
        view.addSubview(navigationBar)
        
        setupLoginButton()
        setupEmailLabel()
        setupEmailInput()
        setupPasswordLabel()
        setupPasswordInput()
        setupImageLogin()
//        setupNavBar()
    }
    
    
    @objc func BackAction(sender:UIBarButtonItem!) {
        print("mdr")
    }
    
    @objc func handledismiss(sender:UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLoginAction(sender: UIButton!) {
//        self.dismiss(animated: true, completion: nil)
//        var email: String = "quentin.cettier@hetic.net"
//        var password: String = "password"
//        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
//            // ...
//            guard let user = authResult?.user else { return }
//        }
        print("handle login")
        guard let email = emailInput.text else { return }
        guard let password = passwordInput.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password ) { user, error in
            if error == nil && user != nil {
                
                print("succeed")
                let userEmail = user?.user.email
                
                let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let SliderHomeController = myStoryboard.instantiateViewController(withIdentifier: "SliderHomeController")
                self.present(SliderHomeController, animated: false, completion: nil)
                
            } else {
                print("errorrr")
            }
        }
        
    }
    
    private func setupLoginButton() {
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        LoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        LoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        LoginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        LoginButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupEmailLabel() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailLabel.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 30).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    }
    
    private func setupEmailInput() {
        emailInput.translatesAutoresizingMaskIntoConstraints = false

        emailInput.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        emailInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
    private func setupPasswordLabel() {
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        passwordLabel.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 20).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
    }
    
    private func setupPasswordInput() {
        
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        
        passwordInput.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passwordInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        passwordInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        passwordInput.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupImageLogin() {
        
        loginImage.translatesAutoresizingMaskIntoConstraints = false

        loginImage.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.height * 0.15).isActive = true
        loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
}


