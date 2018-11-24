//
//  SliderHomeController.swift
//  IOS-EQ04
//
//  Created by Quentin on 12/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit
import FirebaseAuth

class SliderHomeController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    let titlelabel: UILabel = {
        var lbl = UILabel()
        lbl.frame = (CGRect(x: 0, y: 0, width: 150, height: 50))
        lbl.text = "Moderation"
        lbl.font = UIFont(name: "Poppins-Medium", size: 23.0)
        lbl.textColor = UIColor(hex: "F89934")
        
        return lbl
    }()
    
    let loginButton: UIButton = {
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
        
        btn.addTarget(self, action: #selector(LoginAction), for: .touchUpInside)
        
        return btn
    }()
    
    let signupButton: UIButton = {
        var btn = UIButton()
        
        btn.frame = (CGRect(x: 0, y: 0, width: 100, height: 0))
        btn.setTitle("Signup", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SF-Pro-Text-Medium", size: 19.0)
        btn.backgroundColor = UIColor(hex: "FFFFFF")
        btn.layer.cornerRadius = 15
        btn.setTitleColor(UIColor(hex: "F89934"), for: .normal)
        btn.addTarget(self, action: #selector(SignupAction), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titlelabel)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        setupTitleLabel()
        setupPageControl()
        setupLoginButton()
        setupsignupButton()
        
        if let user =  Auth.auth().currentUser {
            print(user)
        }
        
        struct Slide {
            var img: String
            var title: String
            var text: String
        }
        let slide0 = Slide(img: "beer", title: "Never fear", text: "Thanks to our party mode, follow your alcohol level in real time and receive tips to better manage it")
        
        let slide1 = Slide(img: "grow", title: "Follow your drinks", text: "Use our calendar and statistics to track your alcohol consumption and start reducing it")
        
        let slide2 = Slide(img: "security", title: "Stay Safe", text: "Thanks to our emergency page, go home, block your credit card or call urgency numbers easily")
        
        var slides: [Slide] = [slide0,slide1,slide2]
        
        var frame = CGRect(x:0, y:0, width: scrollView.frame.size.width * 0.6, height:180)
        
        var titleFrame = CGRect(x:0, y:0, width: scrollView.frame.size.width * 0.6, height:180)
        var textFrame = CGRect(x:0, y:0, width: scrollView.frame.size.width * 0.8, height:180)

        pageControl.numberOfPages = slides.count
        
        for index in 0..<slides.count {
            
            frame.origin.x = scrollView.frame.size.width * (CGFloat(index) + 0.20)
            frame.origin.y = 50
            
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: slides[index].img)
            
            titleFrame.origin.x = scrollView.frame.size.width * (CGFloat(index) + 0.20)
            titleFrame.origin.y = imgView.frame.size.height + 15
            
            textFrame.origin.x = scrollView.frame.size.width * (CGFloat(index) + 0.10)
            textFrame.origin.y = imgView.frame.size.height + 75
            
            let label: UILabel = {
                let lbl = UILabel()
                lbl.frame = titleFrame
                lbl.font = UIFont(name: "Poppins-Medium", size: 23.0)
                lbl.text = slides[index].title
                lbl.textColor = UIColor(hex: "F89934")
                lbl.textAlignment = .center
                lbl.numberOfLines = 0
                return lbl
            }()
            
            let textlabel: UILabel = {
                let lbl = UILabel()
                lbl.frame = textFrame
                lbl.font = UIFont(name: "SF-Pro-Text-Regular", size: 16.0)
                lbl.text = slides[index].text
                lbl.textColor = UIColor(hex: "000000")
                lbl.textAlignment = .center
                lbl.numberOfLines = 0
                return lbl
            }()
            
            scrollView.addSubview(imgView)
            scrollView.addSubview(label)
            scrollView.addSubview(textlabel)
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(slides.count)), height: (scrollView.frame.size.height))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let HomeController = myStoryboard.instantiateViewController(withIdentifier: "HomeController")
            self.present(HomeController, animated: false, completion: nil)
        }
    }
    
    func setupPageControl() {
        pageControl.pageIndicatorTintColor = UIColor(hex: "D5D5D5")
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "FF9200")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    private func setupTitleLabel() {

        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        //Centre le label dans l'ecran et on donne 100*100
        titlelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titlelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        
    }
    
    private func setupsignupButton() {
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        signupButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        signupButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -15).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    //Action
    @objc func LoginAction(sender: UIButton!) {
        let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginController = myStoryboard.instantiateViewController(withIdentifier: "LoginController")
        self.present(LoginController, animated: true, completion: nil)
    }
    
    @objc func SignupAction(sender: UIButton!) {
        let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SignupController = myStoryboard.instantiateViewController(withIdentifier: "SignupController")
        self.present(SignupController, animated: true, completion: nil)
    }
    
    
}
