//
//  ReviewViewController.swift
//  FoodPin18
//
//  Created by 沈韶泓 on 2016/11/3.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    
    var restaurant: Restaurant!
    var rating: String?

    
    @IBAction func ratingButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 100: rating = "dislike"
        case 200: rating = "good"
        case 300: rating = "great"
        default: break
        }
        
        performSegue(withIdentifier: "unwindToDetail", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewImage.image = UIImage(data: restaurant.image as! Data)
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffectView.frame = view.frame
        reviewImage.addSubview(blurEffectView)
        
        let scale = CGAffineTransform(scaleX: 0, y: 0)
        let translateAndScale = scale.concatenating(CGAffineTransform(translationX: 0, y: 500))
        
        ratingStackView.transform = translateAndScale


        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {
            self.ratingStackView.transform = CGAffineTransform.identity
        }
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
