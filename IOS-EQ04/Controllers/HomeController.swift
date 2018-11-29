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

let db = Firestore.firestore()


class HomeController: UIViewController, UITabBarDelegate, CoreChartViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barCharts: VCoreBarChart!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var addDrinkItem: UITabBarItem!

    var parties: [Party] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let userEmail = Auth.auth().currentUser?.email
        
        let db = Firestore.firestore()
        var drinks = [String]()
        var sizeDrinks = [String]()
        db.collection("users").whereField("email", isEqualTo: "qcettier@gmail.com" )
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
                                    if let dateDrink = doc.data()["date"] as? String {
                                        drinks.insert(dateDrink, at: 0)
                                    }
                                    if let sizeDrink = doc.data()["drinkSize"] as? String {
                                        sizeDrinks.insert(sizeDrink, at: 0)
                                    }
                                }
                                self.calculateDrinksPerDay(drinks)
                                self.calculateDrinksPerMonth(drinks, sizeDrinks)
                            }
                            
                        })
                        
                    }
                }
        }
        
        
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
    
    private func calculateDrinksPerMonth( _ drinks: Array<String>, _ sizeDrinks: Array<String>) {
        let currentDate = Date()
        
        let daysToAdd = -30
        var dateComponent = DateComponents()
        dateComponent.day = daysToAdd
        
        var shots = 0
        var verres = 0
        var pintes = 0
        var index = 0
        for el in drinks {
            let dateString = el
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let date = dateFormatter.date(from: dateString)!
            
            let oneMonthAgo = Calendar.current.date(byAdding: dateComponent, to: currentDate)
            
            if date > oneMonthAgo! {
                if sizeDrinks[index] == "shot" {
                    shots += 1
                } else if sizeDrinks[index] == "verre" {
                    verres += 1
                } else if sizeDrinks[index] == "pinte" {
                    pintes = 0
                }
            }
            index += 1
        }
        
        var result = (Double(shots) * 0.04) + (Double(verres) * 0.25) + (Double(pintes) * 0.5)
        print(Double(round(1000*result)/1000))
        
    }
    
    private func calculateDrinksPerDay(_ drinks: Array<String>) {
        // get the date of a week ago
        let daysToAdd = -7
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = daysToAdd
        
        
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var days = [Int]()
        for i in 1 ... 7 {
            let day = cal.component(.day, from: date)
            days.append(day)
            date = cal.date(byAdding: .day, value: -1, to: date)!
        }
        
        var day1 = 0
        var day2 = 0
        var day3 = 0
        var day4 = 0
        var day5 = 0
        var day6 = 0
        var day7 = 0
        
        for el in drinks {
            let dateString = el
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let date = dateFormatter.date(from: dateString)!
            
            let oneWeekAgo = Calendar.current.date(byAdding: dateComponent, to: currentDate)
            
            if date > oneWeekAgo! {
                let cal = Calendar.current
                let dateDay = cal.dateComponents([ .day ], from: date)
                
                switch dateDay.day {
                case days[6]:
                    day1 += 1
                case days[5]:
                    day2 += 1
                case days[4]:
                    day3 += 1
                case days[3]:
                    day4 += 1
                case days[2]:
                    day5 += 1
                case days[1]:
                    day6 += 1
                case days[0]:
                    day7 += 1
                default:
                    print("default")
                }
            }
        }
        let drinksofTheWeek = [day1, day2, day3, day4, day5, day6, day7]
        print(drinksofTheWeek)
    }
    
    func loadCoreChartData() -> [CoreChartEntry] {
        var allData = [CoreChartEntry]()
        
        let days = ["M","T","W","T", "F", "S", "S"]
        
        let statistics = [1, 1, 3, 1, 2, 1, 5]
        
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
        if item == addDrinkItem {
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let AddDrinkController = myStoryboard.instantiateViewController(withIdentifier: "AddDrinkController")
            self.present(AddDrinkController, animated: false, completion: nil)
        }
        
        
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
