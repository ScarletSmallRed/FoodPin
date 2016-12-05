//
//  GuidePageViewController.swift
//  FoodPin18
//
//  Created by 沈韶泓 on 2016/11/9.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import UIKit

class GuidePageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var headings = ["Personal Customization", "Locating Restaurants", "Discover food"]
    var images = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var footers = ["Good shop at any time to add", "Find a restaurant right now.", "Find other people's collections"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let startingViewController = viewControllerAtIndex(index: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
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
    
    func viewControllerAtIndex(index: Int) -> GuideContentViewController? {
        
        if case 0 ..< headings.count = index {
            
            if let guideContentViewController = storyboard?.instantiateViewController(withIdentifier: "GuideContentViewController") as? GuideContentViewController {
                
                guideContentViewController.imageName = images[index]
                guideContentViewController.headingText = headings[index]
                guideContentViewController.footerText = footers[index]
                guideContentViewController.index = index
                
                return guideContentViewController
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! GuideContentViewController).index
        
        index += 1
        
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! GuideContentViewController).index
        
        index -= 1
        
        return viewControllerAtIndex(index: index)
    }
}
