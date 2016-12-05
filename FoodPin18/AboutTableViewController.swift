//
//  AboutTableViewController.swift
//  FoodPin18
//
//  Created by 沈韶泓 on 2016/11/12.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    var sectionTitle = [NSLocalizedString("Scoring and feedback", comment: "Scoring and feedback"),NSLocalizedString("Follow us", comment: "Follow us")]
    var sectionContent = [[NSLocalizedString("Give us a score on App Store", comment: "Give us a score on App Store"), NSLocalizedString("Feedback", comment: "Feedback")],[NSLocalizedString("Web", comment: "Web"), NSLocalizedString("WeChat", comment: "WeChat"), NSLocalizedString("HuaChuan College", comment: "HuaChuan College")]]
    var links = ["http://xiaoboswift.com","http://www.xiaoboswift.com/wp-content/uploads/2015/09/qrcode_for_gh_40e7ae09a227_430.jpg","http://hcxy.me"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)

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
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 2 : 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: "http://apple.com/itunes/charts/paid-apps/") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                } else if indexPath.row == 1 {
                    performSegue(withIdentifier: "showWebView", sender: self)
                }
            
        case 1:
            if let url = NSURL(string: links[indexPath.row]) {
                let sfVC = SFSafariViewController(url: url as URL, entersReaderIfAvailable: true)
                present(sfVC, animated: true, completion: nil)
            }
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
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

}
