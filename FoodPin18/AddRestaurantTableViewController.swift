//
//  AddRestaurantTableViewController.swift
//  FoodPin18
//
//  Created by 沈韶泓 on 2016/11/3.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var restaurant: Restaurant!
    var isVisited = false
    
    
    @IBOutlet weak var addRestaurantimageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var isVisitedLabel: UILabel!
    
    
    @IBAction func isVisitedButtonTapped(_ sender: UIButton) {
        if sender.tag == 8001 {
            isVisited = true
            isVisitedLabel.text = NSLocalizedString("I have already come", comment: "I have already come")
        } else {
            isVisited = false
            isVisitedLabel.text = NSLocalizedString("I have not already come", comment: "I have not come yet")
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        let buffer = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
        
        restaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: buffer!) as! Restaurant
        
        restaurant.name = nameTextField.text!
        restaurant.type = typeTextField.text!
        restaurant.location = locationTextField.text!
        
        if let image = addRestaurantimageView.image {
            let salFac = image.size.width > 375 ? 375 / image.size.width : 1
            restaurant.image = UIImageJPEGRepresentation(image, salFac) as NSData?
        }
        
        restaurant.isVisited = isVisited
        
        do {
            try buffer?.save()
        } catch {
            print(error)
            return
        }
        
        saveRecordToCloud(restaurant: restaurant)
        
        performSegue(withIdentifier: "unwindToRestaurant", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let alertController = UIAlertController(title: "Choose", message: "The option followed is allowed:", preferredStyle: .actionSheet)
            
            let libraryAlertAction = UIAlertAction(title: "PhotoLibrary", style: .default, handler: { (_) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            let cameraAlertAction = UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(libraryAlertAction)
            alertController.addAction(cameraAlertAction)
            alertController.addAction(cancelAlertAction)
            
            present(alertController, animated: true, completion: nil)
            
            
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        addRestaurantimageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        addRestaurantimageView.contentMode = .scaleAspectFill
        addRestaurantimageView.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
        
        let leftCons = NSLayoutConstraint(item: addRestaurantimageView, attribute: .leading, relatedBy: .equal, toItem: addRestaurantimageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        
        let rightCons = NSLayoutConstraint(item: addRestaurantimageView, attribute: .trailing, relatedBy: .equal, toItem: addRestaurantimageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        
        let topCons = NSLayoutConstraint(item: addRestaurantimageView, attribute: .top, relatedBy: .equal, toItem: addRestaurantimageView.superview, attribute: .top, multiplier: 1, constant: 0)
        
        let bottomCons = NSLayoutConstraint(item: addRestaurantimageView, attribute: .bottom, relatedBy: .equal, toItem: addRestaurantimageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        
        leftCons.isActive = true
        rightCons.isActive = true
        topCons.isActive = true
        bottomCons.isActive = true
    }
    
    func saveRecordToCloud(restaurant: Restaurant!) {
        
        
        //准备一条需保存的数据记录
        let record = AVObject(className: "Restaurant")
        record["name"] = restaurant.name
        record["type"] = restaurant.type
        record["location"] = restaurant.location
        
        
        //图像尺寸重新调整
        let originImg = UIImage(data: restaurant.image! as Data)!
        let scalingFac = (originImg.size.width > 1024) ? 1024 / originImg.size.width : 1.0
//        let scaledImg = UIImage(data: restaurant.image! as Data, scale: scalingFac)! 
        
        //把图像文件转换为jpg格式，并用LeanCloud的File类型保存
        let imgFile = AVFile(name: "\(restaurant.name).jpg", data: UIImageJPEGRepresentation(originImg, scalingFac)!)
//        imgFile.saveInBackground()
        
        
        
        
        //关联图像文件
        record["image"] = imgFile
        
        
        
        
        
        record.saveInBackground { (_, e) -> Void in
            if let e = e {
                print(e.localizedDescription)
            } else {
                print("保存成功！")
            }
        }
    }
}
