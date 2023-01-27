//
//  AddExpenseViewController.swift
//  Expense Tracker
//
//  Created by Javier Ocón Barreiro on 20/12/22.
//

import UIKit

class AddExpenseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var TitleTXT: UITextField!
    @IBOutlet weak var AmountTXT: UITextField!
    @IBOutlet weak var CategoryMenu: UIPickerView!
    
    //List of existing categroies -> Used for Picker Menu
    var CategoryList = ["Groceries", "Travel", "Clothes", "Restaurant", "Services", "Others"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CategoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CategoryList[row]
    }
    
    @IBAction func AddExpenseBTN(_ sender: Any) {
        //Selected item from menu(number)
        let selectedIndex = CategoryMenu.selectedRow(inComponent: 0)
        
        //Check if all fields are filled in
        if (TitleTXT.text?.count == 0 || AmountTXT.text?.count == 0) {
            //Show alert
            showAddAlert(self)
            //Clear 'Add Expense' page
            TitleTXT.text = ""
            AmountTXT.text = ""
            CategoryMenu.selectRow(0, inComponent: 0, animated: true)
            //Exit function
            return
        }
        
        //We have list of all expenses(Updates on each click)
        var listOfTitles = UserDefaults.standard.object(forKey: "Titles") as! [String]
        var listOfAmounts = UserDefaults.standard.object(forKey: "Amounts") as! [Double]
        var listOfCategories = UserDefaults.standard.object(forKey: "Categories") as! [String]
        
        var amount: Double = Double(AmountTXT.text!) ?? 0.0
        if amount == 0.0 {
            //Wrong input OR 0.0 can not be cost of an expense
            //Clear 'Add Expense' page
            TitleTXT.text = ""
            AmountTXT.text = ""
            CategoryMenu.selectRow(0, inComponent: 0, animated: true)
            //Show wrong data alert
            showWrongDataAlert(self)
            
            return
        } else {
            //All correct, adds expense elements to list
            listOfAmounts.append(amount)
        }
        //Add all components of an expense to each individual list
        listOfTitles.append(TitleTXT.text!)
        //listOfAmounts.append(Double(AmountTXT.text!)!)
        listOfCategories.append(CategoryList[selectedIndex])
        
        //Update UserDefaults with new expense
        UserDefaults.standard.set(listOfTitles, forKey: "Titles")   //'titles' stored in UserDefaults
        UserDefaults.standard.set(listOfAmounts, forKey: "Amounts")   //'amounts' stored in UserDefaults
        UserDefaults.standard.set(listOfCategories, forKey: "Categories")   //'categories' stored in UserDefaults
        
        //Calculate And Show Total Amount Spent
        var TotalSpent = 0.0
        for i in listOfAmounts {
          TotalSpent += i
        }
        //Store Total Spent amount in UserDfaults
        UserDefaults.standard.set(TotalSpent, forKey: "TotalSpent")
        
        //Clear 'Add Expense' page
        TitleTXT.text = ""
        AmountTXT.text = ""
        CategoryMenu.selectRow(0, inComponent: 0, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //AÑADIR LOS OBJETOS

        // Do any additional setup after loading the view.
    }
    
    func showAddAlert(_ sender: Any) {
            let alert = UIAlertController(title: "Alert", message: "Must fill in all fields in order to create a new expense", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    
    func showWrongDataAlert(_ sender: Any) {
            let alert = UIAlertController(title: "Alert", message: "Amount value must be a number and not 0.0", preferredStyle: .alert)
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
