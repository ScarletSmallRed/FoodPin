//
//  GuideContentViewController.swift
//  FoodPin18
//
//  Created by 沈韶泓 on 2016/11/9.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import UIKit

class GuideContentViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var doneButton: UIButton!
    
    var index = 0
    var headingText = ""
    var footerText = ""
    var imageName = ""

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "pageShowed4")
        
        if traitCollection.forceTouchCapability == .available {
            let bundleID = Bundle.main.bundleIdentifier
            
            let item1Icon = UIApplicationShortcutIcon(templateImageName: "favorite")
            let item1 = UIApplicationShortcutItem(type: "\(bundleID).openFavorite", localizedTitle: NSLocalizedString("Favorite", comment: "3D item1 title"), localizedSubtitle: nil, icon: item1Icon, userInfo: nil)
            
            let item2Icon = UIApplicationShortcutIcon(templateImageName: "discover")
            let item2 = UIApplicationShortcutItem(type: "\(bundleID).openDiscovery", localizedTitle: NSLocalizedString("Discovery", comment: "3D item2 title"), localizedSubtitle: nil, icon: item2Icon, userInfo: nil)
            
            let item3Icon = UIApplicationShortcutIcon(templateImageName: "about")
            let item3 = UIApplicationShortcutItem(type: "\(bundleID).openAbout", localizedTitle: NSLocalizedString("About", comment: "3D item3 title"), localizedSubtitle: nil, icon: item3Icon, userInfo: nil)
            
            let item4Icon = UIApplicationShortcutIcon(type: .add)
            let item4 = UIApplicationShortcutItem(type: "\(bundleID).openAddNew", localizedTitle: NSLocalizedString("New restaurant", comment: "3D item3 title"), localizedSubtitle: nil, icon: item4Icon, userInfo: nil)
            
            
            
            UIApplication.shared.shortcutItems = [item1, item2, item3, item4]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = headingText
        footerLabel.text = footerText
        imageView.image = UIImage(named: imageName)
        
        pageController.currentPage = index
        
        
        if index == 2 {
            doneButton.backgroundColor = UIColor(red: 242 / 255, green: 116 / 255, blue: 119 / 255, alpha: 1)
            doneButton.isHidden = false
        } else {
            doneButton.isHidden = true
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
