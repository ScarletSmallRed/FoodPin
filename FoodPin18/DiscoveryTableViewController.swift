//
//  DiscoveryTableViewController.swift
//  FoodPin18
//
//  Created by 沈韶泓 on 2016/11/14.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import UIKit

class DiscoveryTableViewController: UITableViewController {
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    var restaurants: [AVObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRecordFromCloud()
        
        spinner.hidesWhenStopped = true
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        
        
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.white
        refreshControl?.tintColor = UIColor.gray
        refreshControl?.addTarget(self, action: #selector(DiscoveryTableViewController.getNewData), for: .valueChanged)
        

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
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoveryCell", for: indexPath)

        // Configure the cell...
        
        let restaurant = restaurants[indexPath.row]
        
        cell.imageView?.image = UIImage(named: "photoalbum")
        
        if let image = restaurant["image"] as? AVFile {
            
            image.getDataInBackground({ (data, error) in
                
                guard error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                
                OperationQueue.main.addOperation({ 
                    
                    cell.imageView?.image = UIImage(data: data!)
                })
            })
        }
        
        
        cell.textLabel?.text = restaurant["name"] as! String?
        
        

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getRecordFromCloud(needNew: Bool = false) {
        
        let query = AVQuery(className: "Restaurant")
        
        if needNew {
            query.cachePolicy = .ignoreCache
        } else {
            query.cachePolicy = .cacheElseNetwork
            query.maxCacheAge = 60 * 2
        }
        
        query.order(byDescending: "createdAt")
        
        if query.hasCachedResult() {
            print("Results from cache!!!")
        }
    
        query.findObjectsInBackground { (objects, error) in
            
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            if let objects = objects as? [AVObject] {
                self.restaurants = objects
                OperationQueue.main.addOperation({ 
                    
                    self.tableView.reloadData()
                    self.spinner.stopAnimating()
                    self.refreshControl?.endRefreshing()
                })
            }
        }
    }
    
    func getNewData() {
        getRecordFromCloud(needNew: true)
    }

}
