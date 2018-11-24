//
//  AddDrinkController.swift
//  IOS-EQ04
//
//  Created by Quentin on 20/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AddDrinkController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var addDrinkItem: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    
    let imgSize: [String] = ["shots", "verre", "pinte"]
    let imgSize_white: [String] = ["shots_white", "verre", "pinte"]
    
    
    var arr: [String] = []
    var img_icon: [String] = []
    
    var img_choosed: String = ""
    var drink_choosed: String = ""
    var price_choose: Int = 0
    
    let pageControl: UIPageControl = {
       var pControl =  UIPageControl(frame: .zero)
        pControl.numberOfPages = 3
        pControl.pageIndicatorTintColor = UIColor(hex: "D5D5D5")
        pControl.currentPageIndicatorTintColor = UIColor(hex: "FF9200")
        
        return pControl
    }()
//
    let navigationBar: UINavigationBar = {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let bar = UINavigationBar(frame: CGRect(x:0, y:20, width:screenSize.width, height: 44))
        bar.barTintColor = UIColor(hex: "F89934")
        bar.tintColor = UIColor(hex: "FFFFFF")
        bar.isTranslucent = false
        let navItem = UINavigationItem(title: "Your party")
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "FFFFFF")]
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(handledismiss))
        navItem.leftBarButtonItem = backButton
        bar.setItems([navItem], animated: false)
        
        return bar
        
    }()
    
    let ModalLabel: UILabel = {
        let label = UILabel()
        label.frame = (CGRect(x: 0, y: 0, width: 300, height: 60))
        label.text = "Choose the size of your drink"
        label.font = UIFont(name: "SFProText-Regular", size: 23.0)
        label.textColor = UIColor(hex: "000000")
        label.numberOfLines = 0
        
        return label
    }()
    
    let modalView: UIView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let modal = UIView()
        modal.frame = CGRect(x:0, y:0, width: 0, height: 0)
        modal.backgroundColor = .white
        modal.layer.cornerRadius = 12
        modal.alpha = 0
        
        return modal
    }()
    
    let scrollView: UIScrollView = {
        
        let sview = UIScrollView()
        sview.isPagingEnabled = true
        return sview
    }()
    
    let modalblurView: UIView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let modal = UIView()
        modal.frame = CGRect(x:0, y:0, width: screenSize.width, height: screenSize.height)
        modal.backgroundColor = UIColor(hex: "1B1B1B")
        modal.alpha = 0
        

        return modal
    }()
    
    let AddDrinkButton: UIButton = {
        var btn = UIButton()
        
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 0)
        btn.setTitle("Add a drink", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SF-Pro-Text-Medium", size: 19.0)
        btn.backgroundColor = UIColor(hex: "F89934")
        btn.layer.cornerRadius = 15
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.2
        
        btn.addTarget(self, action: #selector(handleaddDrinkAction), for: .touchUpInside)
        
        return btn
    }()
    
    let priceCollectionView: UICollectionView = {
        let pricelayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        pricelayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        pricelayout.itemSize = CGSize(width: 75, height: 75)
        pricelayout.minimumInteritemSpacing = 0
        pricelayout.minimumLineSpacing = 0
        
        let cView = UICollectionView(frame: CGRect(x:0,y:0,width:0, height:0), collectionViewLayout: pricelayout)
        
        cView.backgroundColor = .white
        cView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyPrice")
        
        return cView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(AddDrinkButton)
        view.addSubview(modalView)
        view.addSubview(modalblurView)
        view.addSubview(navigationBar)
        view.bringSubviewToFront(modalView)
        view.bringSubviewToFront(tabBar)
        modalView.addSubview(scrollView)
        modalView.addSubview(pageControl)
        
        scrollView.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addd))
        modalblurView.addGestureRecognizer(gesture)
        setupScrollView()
        setupdrinkButton()
        setupModal()
        setupPageControl()
        
        
         let db = Firestore.firestore()
        
//        db.collection("drinks").getDocument { document, error in
//            if let drink = document.flatMap({
//                $0.data().flatMap({ (data) in
//                    return Drink(dictionary: data)
//                })
//            }) {
//                print("City: \(drink)")
//            } else {
//                print("Document does not exist")
//            }
//
//        }
        
        db.collection("drinks").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let drink = Drink(dictionary: document.data())
                        
                        self.arr.append((drink?.name)!)
                        self.img_icon.append((drink?.image)!)
                    }
                }
        }
    
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @objc func handleaddDrinkAction(sender: UIButton!) {
        UIView.animate(withDuration: 0.3, animations: {
            self.modalblurView.alpha = 0.13
            self.modalView.alpha = 1
        })
        
        struct Slide {
            var img: String
            var title: String
            var text: String
        }
        struct ChooseSizeSlide {
            var title: String
            var size: String
            var img: String
        }
        struct ChooseDrinkSlide {
            var size: String
            var img: String
        }
        
//        let choosedrink = ChooseSizeSlide(title: "Choose the size of your drink", size: "petit", img:"petit")
        let slide0 = Slide(img: "beer", title: "Never fear", text: "Thanks to our party mode, follow your alcohol level in real time and receive tips to better manage it")
        
        let slide1 = Slide(img: "grow", title: "Follow your drinks", text: "Use our calendar and statistics to track your alcohol consumption and start reducing it")
        
        let slide2 = Slide(img: "security", title: "Stay Safe", text: "Thanks to our emergency page, go home, block your credit card or call urgency numbers easily")
        
        var slides: [Slide] = [slide0,slide1,slide2]
        
        var frame = CGRect(x:0, y:0, width: scrollView.frame.size.width * 0.6, height:180)
        
        var titleFrame = CGRect(x:0, y:-20, width: scrollView.frame.size.width * 0.8, height:180)
        var collFrame = CGRect(x:0, y:scrollView.frame.size.height * 0.5, width: scrollView.frame.size.width, height:75)
        var tableFrame = CGRect(x:0, y:scrollView.frame.size.height * 0.30, width: scrollView.frame.size.width, height:270)
        
        for index in 0..<slides.count {
            frame.origin.x = scrollView.frame.size.width * (CGFloat(index) + 0.20)
            frame.origin.y = 10
            
            if(index == 0) {
                let label: UILabel = {
                    let lbl = UILabel()
                    lbl.frame = titleFrame
                    lbl.font = UIFont(name: "Poppins-Medium", size: 23.0)
                    lbl.text = "Choose the size of your drink"
                    lbl.textColor = UIColor(hex: "000000")
                    lbl.textAlignment = .left
                    lbl.numberOfLines = 0
                    
                    return lbl
                }()
                
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
                layout.itemSize = CGSize(width: 75, height: 75)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
                
                let collectionView: UICollectionView = {
                    let cView = UICollectionView(frame: collFrame, collectionViewLayout: layout)
                    cView.dataSource = self
                    cView.delegate = self
                    cView.backgroundColor = .white
                    cView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
                    
                    return cView
                }()
                
                scrollView.addSubview(label)
                scrollView.addSubview(collectionView)
            } else if index == 1 {
                
                titleFrame.origin.x = scrollView.frame.size.width * CGFloat(index)
                tableFrame.origin.x = scrollView.frame.size.width * CGFloat(index)
                let Drinklabel: UILabel = {
                    let lbl = UILabel()
                    lbl.frame = titleFrame
                    lbl.font = UIFont(name: "Poppins-Medium", size: 23.0)
                    lbl.text = "Choose the your drink"
                    lbl.textColor = UIColor(hex: "000000")
                    lbl.textAlignment = .left
                    lbl.numberOfLines = 0
                    
                    return lbl
                }()
                
                let tableView: UITableView = {
                    let tView = UITableView()
                    tView.frame = tableFrame
                    tView.delegate = self
                    tView.dataSource = self
                    tView.showsVerticalScrollIndicator = false
                    
                    return tView
                }()
                tableView.register(DrinkTableViewCell.self, forCellReuseIdentifier: "DrinkCell")
                scrollView.addSubview(Drinklabel)
                scrollView.addSubview(tableView)
                
            } else if index == 2 {
                titleFrame.origin.x = scrollView.frame.size.width * CGFloat(index)
                tableFrame.origin.x = scrollView.frame.size.width * CGFloat(index)
                let priceLabel: UILabel = {
                    let lbl = UILabel()
                    lbl.frame = titleFrame
                    lbl.font = UIFont(name: "Poppins-Medium", size: 23.0)
                    lbl.text = "How much did you pay ?"
                    lbl.textColor = UIColor(hex: "000000")
                    lbl.textAlignment = .left
                    lbl.numberOfLines = 0
                    
                    return lbl
                }()
                
                
                
                
                
                priceCollectionView.dataSource = self
                priceCollectionView.delegate = self
                
                scrollView.addSubview(priceLabel)
                scrollView.addSubview(priceCollectionView)
                
                
                
                scrollView.addSubview(priceLabel)
                
            }
//
//
//            let imgView = UIImageView(frame: frame)
//            imgView.image = UIImage(named: slides[index].img)
//
//            titleFrame.origin.x = scrollView.frame.size.width * (CGFloat(index) + 0.20)
//            titleFrame.origin.y = imgView.frame.size.height + 15
//
//            textFrame.origin.x = scrollView.frame.size.width * (CGFloat(index) + 0.10)
//            textFrame.origin.y = imgView.frame.size.height + 75
//
//            let label: UILabel = {
//                let lbl = UILabel()
//                lbl.frame = titleFrame
//                lbl.font = UIFont(name: "Poppins-Medium", size: 23.0)
//                lbl.text = slides[index].title
//                lbl.textColor = UIColor(hex: "F89934")
//                lbl.textAlignment = .center
//                lbl.numberOfLines = 0
//                return lbl
//            }()
//
//            let textlabel: UILabel = {
//                let lbl = UILabel()
//                lbl.frame = textFrame
//                lbl.font = UIFont(name: "SF-Pro-Text-Regular", size: 16.0)
//                lbl.text = slides[index].text
//                lbl.textColor = UIColor(hex: "000000")
//                lbl.textAlignment = .center
//                lbl.numberOfLines = 0
//                return lbl
//            }()
//
//            scrollView.addSubview(imgView)
//            scrollView.addSubview(label)
//            scrollView.addSubview(textlabel)
        }
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * 3), height: (scrollView.frame.size.height))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
       
    }
    
    
    
    @objc func addd(sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.modalblurView.alpha = 0
            self.modalView.alpha = 0
        })
        
    }
    
    @objc func handledismiss(sender:UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
//
    func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)

    }
//
    private func setupModal() {
        
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        modalView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        modalView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
//        modalView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.65).isActive = true
        modalView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20).isActive = true
        modalView.bottomAnchor.constraint(equalTo: AddDrinkButton.topAnchor, constant: -20).isActive = true
    }
    
    private func setupdrinkButton() {
        AddDrinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        AddDrinkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        AddDrinkButton.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -15).isActive = true
        AddDrinkButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        AddDrinkButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        AddDrinkButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    private func setupScrollView() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 30).isActive = true
        scrollView.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -30).isActive = true
        scrollView.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -50).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == priceCollectionView) {
            print("mrdr")
            return 4
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)
        var imgFrame: CGRect = CGRect()
        var imgView: UIImageView = UIImageView()
        
        var imgFrameWhite: CGRect = CGRect()
        var imgViewWhite: UIImageView = UIImageView()
        
        if indexPath.row == 0 {
            imgFrame = CGRect(x:myCell.frame.size.width * 0.20, y:myCell.frame.size.height * 0.3, width:45, height:35)
            imgView = UIImageView(frame: imgFrame)
            
            imgFrameWhite = CGRect(x:myCell.frame.size.width * 0.20, y:myCell.frame.size.height * 0.3, width:45, height:35)
            imgViewWhite = UIImageView(frame: imgFrame)
        } else if indexPath.row == 1 {
            imgFrame = CGRect(x:myCell.frame.size.width * 0.33, y:myCell.frame.size.height * 0.2, width:25, height:45)
            imgView = UIImageView(frame: imgFrame)
            
            imgFrameWhite = CGRect(x:myCell.frame.size.width * 0.33, y:myCell.frame.size.height * 0.2, width:25, height:45)
            imgViewWhite = UIImageView(frame: imgFrame)
            
        } else if indexPath.row == 2 {
            imgFrame = CGRect(x:myCell.frame.size.width * 0.33, y:myCell.frame.size.height * 0.2, width:25, height:45)
            imgView = UIImageView(frame: imgFrame)
            
            imgFrameWhite = CGRect(x:myCell.frame.size.width * 0.33, y:myCell.frame.size.height * 0.2, width:25, height:45)
            imgViewWhite = UIImageView(frame: imgFrame)
        }
        
        myCell.layer.borderColor = UIColor(hex: "F89934").cgColor
        myCell.layer.borderWidth = 2
        myCell.layer.cornerRadius = 35
        imgView.image = UIImage(named: imgSize[indexPath.row])
        imgViewWhite.image = UIImage(named: imgSize_white[indexPath.row])
        imgViewWhite.alpha = 0
        myCell.addSubview(imgView)
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = UIColor(hex: "F89934")
            UIView.animate(withDuration: 0.4) {
                self.scrollView.contentOffset = CGPoint(x: 255,y:0)
                
            }
            self.pageControl.currentPage = 1
            if indexPath.row == 0 {
                img_choosed = "shot"
            } else if indexPath.row == 1 {
                img_choosed = "verre"
            } else if indexPath.row == 2 {
                img_choosed = "pinte"
            }
            
            print(img_choosed)
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DrinkTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath) as! DrinkTableViewCell
        
        cell.titleLabel.text = self.arr[indexPath.row]
        cell.drinkIcon.image = UIImage(named: self.img_icon[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        drink_choosed = self.img_icon[indexPath.row]
        print(drink_choosed)
        UIView.animate(withDuration: 0.4) {
            self.scrollView.contentOffset = CGPoint(x:510,y:0)
        }
        
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
