//
//  DetailTableViewController.swift
//  FoodPin18
//
//  Created by 沈韶泓 on 2016/11/3.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var ratingButton: UIButton!
    
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = UIImage(data: restaurant.image as! Data)
        
        title = restaurant.name
        
        tableView.estimatedRowHeight = 36
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        let defaults = UserDefaults.standard
        if let rating = defaults.object(forKey: restaurant.name + "rating") {
            ratingButton.setImage(UIImage(named: rating as! String), for: .normal)
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        
        // Configure the cell...
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = NSLocalizedString("Name", comment: "Restaurant name")
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = NSLocalizedString("Type", comment: "Restaurant Type")
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = NSLocalizedString("Location", comment: "Restaurant Location")
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = NSLocalizedString("Have come?", comment: "Restaurant come?")
            cell.valueLabel.text = (restaurant.isVisited) ? NSLocalizedString("I have already come", comment: "I have already come") : NSLocalizedString("I have not come yet", comment: "I have not come yet")
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showReview" {
            
            let destViewController = segue.destination as! ReviewViewController
            
            destViewController.restaurant = self.restaurant
            
        } else if segue.identifier == "showMap" {
            
            let destViewController = segue.destination as! MapViewController
            
            destViewController.restaurant = self.restaurant
        }
    }

    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
        if let reviewViewController = segue.source as? ReviewViewController {
            if let rating = reviewViewController.rating {
                self.restaurant.rating = rating
                self.ratingButton.setImage(UIImage(named: rating), for: .normal)
                
                let defaults = UserDefaults.standard
                defaults.set(rating, forKey: restaurant.name + "rating")
            }
        }
    }
}
