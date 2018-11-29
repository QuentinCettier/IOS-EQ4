//
//  HomeController.swift
//  IOS-EQ04
//
//  Created by Quentin on 10/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import CoreCharts


class HomeController: UIViewController, UITabBarDelegate, CoreChartViewDataSource {
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var feedBarItem: UITabBarItem!
    @IBOutlet weak var partyBarItem: UITabBarItem!
    @IBOutlet weak var profileBarItem: UITabBarItem!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barCharts: VCoreBarChart!
//    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let segmentedControl: UISegmentedControl = {
        let items = ["Alcohol", "Expenses", "Drinks"]
        let sControl = UISegmentedControl(items: items)
        sControl.frame = CGRect(x:0, y:0, width: 0, height:0)
        
        sControl.selectedSegmentIndex = 0
        sControl.layer.cornerRadius = 5
        sControl.backgroundColor = .white
        sControl.tintColor = UIColor(hex:"F89934")
        sControl.layer.borderWidth = 1
        sControl.layer.borderColor = UIColor(hex:"FFFFFF").cgColor
        
        sControl.addTarget(self, action: #selector(changeColor), for: .valueChanged)

        return sControl
    }()

    var parties: [Party] = []
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var count: Int = 0
        let db = Firestore.firestore()
        db.collection("users").whereField("email", isEqualTo: Auth.auth().currentUser?.email )
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        db.collection("users").document(document.documentID).collection("drinks").getDocuments(completion: { (query, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for doc in query!.documents {
                                    let usersDrinks = db.collection("users").document(document.documentID).collection("drinks")
                                    usersDrinks
                                    count += 1
                                    
                                }
                            }

                        })
                    
                    }
                }
        }

        
        
        
        self.view.addSubview(segmentedControl)

        setupSC()
        tabBar.delegate = self
        
        parties = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        
        barCharts.dataSource = self
        
        barCharts.displayConfig.barWidth = 30
        barCharts.displayConfig.barSpace = 12
        barCharts.displayConfig.titleFontSize = 16
        barCharts.displayConfig.valueFontSize = 16
    }
    
    @objc func changeColor(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            print("Green")
        case 2:
            print("Blue")
        case 3:
            print("Blue")
        default:
            print("Purple")
        }
       
    }
    
    func loadCoreChartData() -> [CoreChartEntry] {
        var allData = [CoreChartEntry]()
        
        let days = ["M","T","W","T", "F", "S", "S"]
        
        let statistics = [1, 1, 3, 10, 2, 1, 5]
        
        for index in 0..<days.count {
            
            let newEntry = CoreChartEntry(id: "\(statistics[index])",
                barTitle: days[index],
                barHeight: Double(statistics[index]),
                barColor: UIColor.white.withAlphaComponent(0.5))
            
            
            allData.append(newEntry)
            
        }
        return allData
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == feedBarItem {
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let HomeViewController = myStoryboard.instantiateViewController(withIdentifier: "HomeController")
            self.present(HomeViewController, animated: false, completion: nil)
            
        } else if item == partyBarItem {
            
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let PartyViewController = myStoryboard.instantiateViewController(withIdentifier: "PartyViewController")
            self.present(PartyViewController, animated: false, completion: nil)
            
        } else if item == profileBarItem {
            
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let PartyViewController = myStoryboard.instantiateViewController(withIdentifier: "PartyViewController")
            self.present(PartyViewController, animated: false, completion: nil)
            
        }
    }
    
    private func setupSC() {
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        barCharts.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.topAnchor.constraint(equalTo: barCharts.topAnchor, constant: -50).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
    }
    
}


// Configuration for the parties table
extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func createArray() -> [Party] {
        
        var tempData: [Party] = []
        
        let party1 = Party(litres: 4.5, date: "12 Nov. 2018")
        let party2 = Party(litres: 3.0, date: "10 Nov. 2018")
        
        tempData.append(party1)
        tempData.append(party2)
        
        return tempData
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let party = parties[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell") as! PartyTableViewCell
        
        cell.setParty(party: party)
        
        return cell
    }
    
}
