//
//  HomeViewController.swift
//  Expense Tracker
//
//  Created by Javier Ocón Barreiro on 20/12/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var TotalSpentLBL: UILabel!
    
    //We have list of all expenses
    var listOfTitles: Array<String> = UserDefaults.standard.object(forKey: "Titles") as! [String]
    var listOfAmounts: Array<Double> = UserDefaults.standard.object(forKey: "Amounts") as! [Double]
    var listOfCategories: Array<String> = UserDefaults.standard.object(forKey: "Categories") as! [String]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTitles.count
//        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        
        //Createing of cell to be prompted in list
        //cell.textLabel?.text = "\(listOfTitles[indexPath.row]) | \(listOfAmounts[indexPath.row])€"
        
        cell.TitleTXT?.text = listOfTitles[indexPath.row]
        cell.AmmountTXT?.text = "\(listOfAmounts[indexPath.row])€"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // Perform some action when the detail accessory is tapped
        DetailAlert(self, index: Int(indexPath.row))
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize an expense
        //initializeData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Get Updated Data          MAKE THEM GLOBAL
        listOfTitles = UserDefaults.standard.object(forKey: "Titles") as! [String]
        listOfAmounts = UserDefaults.standard.object(forKey: "Amounts") as! [Double]
        listOfCategories = UserDefaults.standard.object(forKey: "Categories") as! [String]
        
        //Calculate And Show Total Amount Spent
        var ListExpenses = UserDefaults.standard.object(forKey: "Amounts") as! [Double]
        var TotalSpent = 0.0
        for i in ListExpenses {
          TotalSpent += i
        }
        //Display total spent in €
        TotalSpentLBL.text = "\(TotalSpent)€"
        //Store Total Spent amount in UserDfaults
        UserDefaults.standard.set(TotalSpent, forKey: "TotalSpent")
        
        //Reload the TableView
        tableview.reloadData()
    }
    
    //Function to initialize data at begining for testing
    func initializeData() {
        let titles = ["Algo"]
        let amounts = [20.0]
        let categories = ["Comida"]
                
        UserDefaults.standard.set(titles, forKey: "Titles")   //'titles' stored in UserDefaults
        UserDefaults.standard.set(amounts, forKey: "Amounts")   //'amounts' stored in UserDefaults
        UserDefaults.standard.set(categories, forKey: "Categories")   //'categories' stored in UserDefaults
    }
    
    //Function to delete a selected expense
    @IBAction func deleteExpense(_ sender: Any) {
        //Gets index of selected expense in TableView
        var indexNumber = tableview.indexPathForSelectedRow?.row
        //Nothing has been selected
        if indexNumber == nil {
            //Show alert
            showDeleteAlert(self)
            //Exit function
            return
        }
        
        //Deletes selected expense                          HANDLE EXCEPTION
        listOfTitles.remove(at: indexNumber!)
        listOfAmounts.remove(at: indexNumber!)
        listOfCategories.remove(at: indexNumber!)
        
        //Updates the expenses
        UserDefaults.standard.set(listOfTitles, forKey: "Titles")   //'titles' stored in UserDefaults
        UserDefaults.standard.set(listOfAmounts, forKey: "Amounts")   //'amounts' stored in UserDefaults
        UserDefaults.standard.set(listOfCategories, forKey: "Categories")   //'categories' stored in UserDefaults
        
        //Updates ViewController`s Data
        viewDidAppear(true)
    }
    
    
    func showDeleteAlert(_ sender: Any) {
            let alert = UIAlertController(title: "Alert", message: "Must select an expense in order to delete one of them", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    
    func DetailAlert(_ sender: Any, index: Int) {
            let alert = UIAlertController(title: "Expense Details", message: "Title: \(listOfTitles[index])\nCategory: \(listOfCategories[index])\nAmmount: \(listOfAmounts[index])€", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
