//
//  SignupController.swift
//  IOS-EQ04
//
//  Created by Quentin on 17/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignupController: UIViewController {

    
    let navigationBar: UINavigationBar = {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let bar = UINavigationBar(frame: CGRect(x:0, y:20, width:screenSize.width, height: 44))
        bar.barTintColor = UIColor(hex: "F89934")
        bar.tintColor = UIColor(hex: "FFFFFF")
        bar.isTranslucent = false
        let navItem = UINavigationItem(title: "Signup")
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "FFFFFF")]
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(handledismiss))
        navItem.leftBarButtonItem = backButton
        bar.setItems([navItem], animated: false)
        
        return bar
        
    }()
    
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.frame = (CGRect(x: 0, y: 0, width: 150, height: 44))
        label.text = "Prénom"
        label.font = UIFont(name: "SF-Pro-Text-Medium", size: 17.0)
        label.textColor = UIColor(hex: "000000")
        
        return label
    }()
    
    let firstNameInput: UITextField = {
        let input = UITextField()
        input.frame = (CGRect(x: 0, y: 0, width: 0, height: 0))
        input.placeholder = "prénom"
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.autocorrectionType = UITextAutocorrectionType.no
        input.autocapitalizationType = .none
        
        return input
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.frame = (CGRect(x: 0, y: 0, width: 150, height: 44))
        label.text = "Nom"
        label.font = UIFont(name: "SF-Pro-Text-Medium", size: 17.0)
        label.textColor = UIColor(hex: "000000")
        
        return label
    }()
    
    let lastNameInput: UITextField = {
        let input = UITextField()
        input.frame = (CGRect(x: 0, y: 0, width: 0, height: 0))
        input.placeholder = "nom"
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.autocorrectionType = UITextAutocorrectionType.no
        input.autocapitalizationType = .none
        
        return input
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.frame = (CGRect(x: 0, y: 0, width: 150, height: 44))
        label.text = "Email"
        label.font = UIFont(name: "SF-Pro-Text-Medium", size: 17.0)
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
        btn.setTitle("Create Account", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SF-Pro-Text-Medium", size: 19.0)
        btn.backgroundColor = UIColor(hex: "F89934")
        btn.layer.cornerRadius = 15
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.2
        
        btn.addTarget(self, action: #selector(handleSignupAction), for: .touchUpInside)
//
        return btn
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.frame = (CGRect(x: 0, y: 0, width: 0, height: 44))
        label.text = "By choosing Create Account, I agree to the Terms of Service and Privacy Policy"
        label.font = UIFont(name: "SFProText-Regular", size: 13.0)
        label.textColor = UIColor(hex: "000000")
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

        view.addSubview(navigationBar)
        
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameInput)
        view.addSubview(lastNameLabel)
        view.addSubview(lastNameInput)
        view.addSubview(emailLabel)
        view.addSubview(emailInput)
        view.addSubview(passwordLabel)
        view.addSubview(passwordInput)
        view.addSubview(textLabel)
        view.addSubview(LoginButton)
        
        setupEmail()
        setupPassword()
        setupBtn()
        setupName()
        setupTextLabel()
    }
    
    @objc func handledismiss(sender:UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSignupAction(sender:UIBarButtonItem!) {
        
        let db = Firestore.firestore()
        
        guard let email = emailInput.text else { return }
        guard let password = passwordInput.text else { return }
        guard let firsName = firstNameInput.text else { return }
        guard let lastName = lastNameInput.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            
            if error == nil && user != nil {
                print("created")
                db.collection("users").addDocument(data: [
                    "firstName": firsName,
                    "lastName": lastName,
                    "email": email
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("add")
                    }
                }
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = firsName
                changeRequest?.commitChanges{ error in
                    if error == nil {
                        print("User name updated")
                        self.dismiss(animated: false, completion: nil)
                    }
                }
            } else {
                print("ERROR")
            }
        }
        
    }
   
    private func setupName() {
        
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameInput.translatesAutoresizingMaskIntoConstraints = false
        lastNameInput.translatesAutoresizingMaskIntoConstraints = false
        
        
        let diff = view.frame.size.width - ( 60 + view.frame.size.width * 0.8)

        firstNameLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30).isActive = true
        firstNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        firstNameInput.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 10).isActive = true
        firstNameInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        firstNameInput.heightAnchor.constraint(equalToConstant: 35).isActive = true
        firstNameInput.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.4).isActive = true

        lastNameInput.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 10).isActive = true
        lastNameInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        lastNameInput.heightAnchor.constraint(equalToConstant: 35).isActive = true
        lastNameInput.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.4).isActive = true

        lastNameLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30).isActive = true
        lastNameLabel.leftAnchor.constraint(equalTo: firstNameInput.rightAnchor, constant: diff).isActive = true
        
        
        
    }
    private func setupEmail() {
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        
        //Label
        emailLabel.topAnchor.constraint(equalTo: firstNameInput.bottomAnchor, constant: 30).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        //Input
        emailInput.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        emailInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 35).isActive = true
            
        
    }
    
    private func setupPassword() {
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        passwordLabel.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 20).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        
        passwordInput.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passwordInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        passwordInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        passwordInput.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupBtn() {
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        LoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        LoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        LoginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        LoginButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private func setupTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 30).isActive = true
        textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
