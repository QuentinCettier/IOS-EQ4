//
//  WarningViewController.swift
//  IOS-EQ04
//
//  Created by Quentin on 13/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit

class WarningViewController: UIViewController {

    
    
    let titlelabel: UILabel = {
        var lbl = UILabel()
        lbl.frame = (CGRect(x: 0, y: 0, width: 150, height: 50))
        lbl.text = "Moderation"
        lbl.font = UIFont(name: "Poppins-Medium", size: 23.0)
        lbl.textColor = UIColor(hex: "F89934")
        
        return lbl
    }()
    
    let warninglabel: UILabel = {
        var lbl = UILabel()
        
        lbl.frame = (CGRect(x: 0, y: 0, width: 162, height: 38))
        lbl.text = "Warning".uppercased()
        lbl.font = UIFont(name: "Poppins-Medium", size: 32.0)
        lbl.textColor = UIColor(hex: "F89934")

        return lbl
    }()
    
    let textlabel: UILabel = {
        var lbl = UILabel()
        
        lbl.frame = (CGRect(x: 0, y: 0, width: 115, height: 38))
        lbl.text = "The abuse of alcool is dangerous for your health, please drink with moderation."
        lbl.font = UIFont(name: "SF-Pro-Text-Regular", size: 16.0)
        lbl.textColor = UIColor(hex: "000000")
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    
    
    let imageView : UIImageView = {
        var img = UIImageView()
        img = UIImageView(frame:CGRect(x:10, y:50, width:189, height:180));
        img.image = UIImage(named:"warning.png")
        
        return img
    }()
    
    let getStartedButton: UIButton = {
        var btn = UIButton()

        btn.frame = (CGRect(x: 0, y: 0, width: 100, height: 0))
        btn.setTitle("Get Started !", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SF-Pro-Text-Medium", size: 19.0)
        btn.backgroundColor = UIColor(hex: "F89934")
        btn.layer.cornerRadius = 15

        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.2

        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titlelabel)
        view.addSubview(imageView)
        view.addSubview(getStartedButton)
        view.addSubview(warninglabel)
        view.addSubview(textlabel)
        
        setupTitleLabel()
        setupImage()
        setupButton()
        setupWarningLabel()
        setupTextLabel()
        
        // Do any additional setup after loading the view.
    }
    

    @objc func buttonAction(sender: UIButton!) {
        let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SliderHomeController = myStoryboard.instantiateViewController(withIdentifier: "SliderHomeController")
        self.present(SliderHomeController, animated: true, completion: nil)
    }
    
    private func setupTitleLabel() {
        
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Centre le label dans l'ecran et on donne 100*100
        titlelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titlelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        
    }
    
    private func setupImage() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 35).isActive = true
    }
    
    private func setupButton() {
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
        getStartedButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        getStartedButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        getStartedButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupWarningLabel() {
        warninglabel.translatesAutoresizingMaskIntoConstraints = false
        warninglabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        warninglabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
    }
    
    private func setupTextLabel() {
        textlabel.translatesAutoresizingMaskIntoConstraints = false
        textlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textlabel.topAnchor.constraint(equalTo: warninglabel.bottomAnchor, constant: 40).isActive = true
        textlabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textlabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
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
