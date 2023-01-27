//
//  ViewExpensesViewController.swift
//  Expense Tracker
//
//  Created by Javier Ocón Barreiro on 20/12/22.
//

import UIKit
import Charts

class ViewExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChart: JPieChart!
    @IBOutlet weak var totalSpentTXT: UILabel!
    
    //List of possible categories
    var CategoryList = ["Groceries", "Travel", "Clothes", "Restaurant", "Services", "Others"]
    //List of colours associated to each category
    var CategoryColours = [UIColor.purpleishBlueThree, UIColor.darkishPink, UIColor.red, UIColor.brown, UIColor.cyan, UIColor.greenyBlue]
    
    //Functions for Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create the 'cell'
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategoriesTableViewCell
        //Get percentage of category
        var percentage = calculatePercentage(categoryToFind: CategoryList[indexPath.row])*100
        //Customize each individual component of the cell
        cell.colourImage?.backgroundColor = CategoryColours[indexPath.row]
        cell.categoryTXT?.text = CategoryList[indexPath.row]
        cell.percentageTXT?.text = "\(Int(percentage))%"
        cell.totalCategoryTXT?.text = "\(Int(calculateTotalIndividual(categoryToFind: CategoryList[indexPath.row])))€"
        //Return the customized cell
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Display PieChart
        pieChart.addChartData(data: [
            JPieChartDataSet(percent: calculatePercentage(categoryToFind: "Groceries"), colors: [UIColor.purpleishBlueThree,UIColor.brightLilac]),
            JPieChartDataSet(percent: calculatePercentage(categoryToFind: "Travel"), colors: [UIColor.darkishPink,UIColor.lightSalmon]),
            JPieChartDataSet(percent: calculatePercentage(categoryToFind: "Clothes"), colors: [UIColor.red,UIColor.red]),
            JPieChartDataSet(percent: calculatePercentage(categoryToFind: "Restaurant"), colors: [UIColor.brown,UIColor.brown]),
            JPieChartDataSet(percent: calculatePercentage(categoryToFind: "Services"), colors: [UIColor.cyan,UIColor.cyan]),
            JPieChartDataSet(percent: calculatePercentage(categoryToFind: "Other"), colors: [UIColor.greenyBlue,UIColor.hospitalGreen])
         ])
         pieChart.lineWidth = 0.85
        
        //Display Total Spent amount
        totalSpentTXT.text = "\(String((UserDefaults.standard.object(forKey: "TotalSpent") as? Double)!))€"
        //Reload data on list
        tableView.reloadData()
    }
    
    func calculatePercentage(categoryToFind: String) -> Double {
        var total = UserDefaults.standard.object(forKey: "TotalSpent") as? Double   //Total amount of spent
        var categorySum = 0.0   //Total sum(cost) of a category
        var i = 0      //Index
        
        var listOfAmounts = UserDefaults.standard.object(forKey: "Amounts") as! [Double]
        var listOfCategories = UserDefaults.standard.object(forKey: "Categories") as! [String]
        
        //Get total spent on category = 'categoryToFind'
        for category in listOfCategories {
            if category == categoryToFind {
                //Add to category
                categorySum += listOfAmounts[i]
            } else {
                //Pass
            }
            //Increment index
            i += 1
        }
        
        //Return % of spent in category against total spent
        return categorySum/total!
    }
    
    func calculateTotalIndividual(categoryToFind: String) -> Double {
        var categorySum = 0.0   //Total sum(cost) of a category
        var i = 0      //Index
        
        var listOfAmounts = UserDefaults.standard.object(forKey: "Amounts") as! [Double]
        var listOfCategories = UserDefaults.standard.object(forKey: "Categories") as! [String]
        
        //Get total spent on category = 'categoryToFind'
        for category in listOfCategories {
            if category == categoryToFind {
                //Add to category
                categorySum += listOfAmounts[i]
            } else {
                //Pass
            }
            //Increment index
            i += 1
        }
        
        //Return % of spent in category against total spent
        return categorySum
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
