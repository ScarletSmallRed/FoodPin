//
//  FoodPin18Tests.swift
//  FoodPin18Tests
//
//  Created by 沈韶泓 on 2016/11/20.
//  Copyright © 2016年 shenshaohong-institute. All rights reserved.
//

import XCTest
@testable import FoodPin18

class FoodPin18Tests: XCTestCase {
    
    var restaurantTableViewController: RestaurantTableViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        restaurantTableViewController = storyboard.instantiateViewController(withIdentifier: "restaurantTableViewController") as! RestaurantTableViewController
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testSearchFilter() {
        restaurantTableViewController.viewDidLoad()
        restaurantTableViewController.searchFilter(textToSearch: "咖啡")
        
        print("Search results: ", restaurantTableViewController.searchResults.count, "Restaurant: ", restaurantTableViewController.restaurants.count)
        
        XCTAssert(restaurantTableViewController.searchResults.count == 4)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case. 咖啡
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
