//
//  RestaurantTableViewController.swift
//  FoodPin18
//
//  Created by 沈韶泓 on 2016/11/3.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating, UIViewControllerPreviewingDelegate {
    
    var restaurants: [Restaurant] = []
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    var searchController: UISearchController!
    var searchResults: [Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.separatorInset = UIEdgeInsetsMake(0, 80, 0, 10);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let buffer = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: buffer!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            restaurants = fetchedResultsController.fetchedObjects as! [Restaurant]
        } catch {
            print(error)
            return
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.tintColor = UIColor.white
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "pageShowed4") {
            return
        }
        
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "GuidePageViewController") as? GuidePageViewController {
            present(pageViewController, animated: true, completion: nil)
        }
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
        return searchController.isActive ? searchResults.count : restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantTableViewCell
        
        // Configure the cell...
        
        let restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        let restaurantImage1 = cell.restaurantImage!
        restaurantImage1.image = UIImage(data: restaurant.image as! Data)
        restaurantImage1.layer.cornerRadius = restaurantImage1.frame.size.width / 2
        restaurantImage1.clipsToBounds = true
        
        cell.restaurantName.text = restaurant.name
        
        cell.restaurantLocation.text = restaurant.location
        
        cell.restaurantType.text = restaurant.type
        
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !searchController.isActive
    }


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
        
        if segue.identifier == "showDetail" {
            let destViewController = segue.destination as! DetailTableViewController
            
            destViewController.restaurant = searchController.isActive ? searchResults[tableView.indexPathForSelectedRow!.row] : restaurants[tableView.indexPathForSelectedRow!.row]
            searchController.dismiss(animated: true, completion: nil)
        }
    }

    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareRowAction = UITableViewRowAction(style: .default, title: NSLocalizedString("Share", comment: "Title of Share Button")) { (_, _) in
            
            let shareAlertController = UIAlertController(title: NSLocalizedString("Share to: ", comment: "Share menu title"), message: NSLocalizedString("Please choose an social application", comment: "Share menu subtitle"), preferredStyle: .actionSheet)
            
            let cancelAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel action title"), style: .cancel, handler: nil)
            let microblogAlertAction = UIAlertAction(title: NSLocalizedString("Microblog", comment: "Short name of Micro-blog Sina"), style: .default, handler: nil)
            let wechatAlertAction = UIAlertAction(title: NSLocalizedString("WeChat" , comment: "Short name of WeChat Tecent"), style: .default, handler: nil)
            let QQAlertAction = UIAlertAction(title: "QQ", style: .default, handler: nil)
            
            shareAlertController.addAction(cancelAlertAction)
            shareAlertController.addAction(microblogAlertAction)
            shareAlertController.addAction(wechatAlertAction)
            shareAlertController.addAction(QQAlertAction)
            
            self.present(shareAlertController, animated: true, completion: nil)
        }
        
        shareRowAction.backgroundColor = UIColor(red: 0, green: 225 / 255, blue: 0, alpha: 1)
        
        let deleteRowAction = UITableViewRowAction(style: .default, title: NSLocalizedString("Delete", comment: "Title of Delete Button")) { (_, _) in
            
            let buffer = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
            
            let restaurantToDelete = self.fetchedResultsController.object(at: indexPath) as! Restaurant
            
            
            buffer?.delete(restaurantToDelete)
            
            do {
                try buffer?.save()
            } catch {
                print(error)
            }
        }
        
        return [shareRowAction, deleteRowAction]
    }
    
    
    @IBAction func unwindToRestaurant(segue: UIStoryboardSegue) {
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRows(at: [_newIndexPath], with: .automatic)
            }
        case .delete:
            if let _indexPath = indexPath {
                tableView.deleteRows(at: [_indexPath], with: .automatic)
            }
        case .update:
            if let _indexPath = indexPath {
                tableView.reloadRows(at: [_indexPath], with: .automatic)
            }
        default:
            tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func searchFilter(textToSearch: String) {
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            return restaurant.name.contains(textToSearch)
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if var textToSearch = searchController.searchBar.text {
            textToSearch = textToSearch.trimmingCharacters(in: NSCharacterSet.whitespaces)
            searchFilter(textToSearch: textToSearch)
            tableView.reloadData()
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let detailTableViewController = storyboard.instantiateViewController(withIdentifier: "DetailTableViewController") as? DetailTableViewController else {
            return nil
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            previewingContext.sourceRect = cell.frame
        }
        
        let selectedRestaurant = restaurants[indexPath.row]
        detailTableViewController.restaurant = selectedRestaurant
        
        return detailTableViewController
    }
}
