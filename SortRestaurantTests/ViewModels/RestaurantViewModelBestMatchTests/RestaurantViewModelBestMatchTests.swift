//
//  RestaurantViewModelBestMatchTests.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import XCTest
@testable import SortRestaurant

class RestaurantViewModelBestMatchTests: XCTestCase {

    typealias FilterHandler = (Restaurant,Restaurant) -> Bool
    
    var viewModelFactory: MockRestaurantViewModel!
    var filter: FilterHandler!
    
    override func setUp() {
        viewModelFactory = MockRestaurantViewModel(filterType: .bestMatch)
        filter = { $0.sort.bestMatch >= $1.sort.bestMatch }
    }
    
    func testGroupedByOpenOrderCloseAndSorted() {
        
        let viewModel = viewModelFactory.viewModel(file: .sample1)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) {[unowned self] error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .open)
            XCTAssertTrue(viewModel[1].status == .open)
            XCTAssertTrue(self.filter(viewModel[0], viewModel[1]))
            
            XCTAssertTrue(viewModel[2].status == .order)
            XCTAssertTrue(viewModel[3].status == .order)
            XCTAssertTrue(self.filter(viewModel[2], viewModel[3]))
            
            XCTAssertTrue(viewModel[4].status == .close)
            XCTAssertTrue(viewModel[5].status == .close)
            XCTAssertTrue(self.filter(viewModel[4], viewModel[5]))
            
        }
    }
    
    func testGroupedByOrderCloseAndSorted() {
        
        let viewModel = viewModelFactory.viewModel(file: .sample2)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) {[unowned self] error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .order)
            XCTAssertTrue(viewModel[1].status == .order)
            XCTAssertTrue(self.filter(viewModel[0], viewModel[1]))
            
            XCTAssertTrue(viewModel[2].status == .close)
            XCTAssertTrue(viewModel[3].status == .close)
            XCTAssertTrue(self.filter(viewModel[2], viewModel[3]))
            
        }
    }
    
    func testGroupedByOpenCloseAndSorted() {
        
        let viewModel = viewModelFactory.viewModel(file: .sample3)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) {[unowned self] error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .open)
            XCTAssertTrue(viewModel[1].status == .open)
            XCTAssertTrue(self.filter(viewModel[0], viewModel[1]))
            
            XCTAssertTrue(viewModel[2].status == .close)
            XCTAssertTrue(viewModel[3].status == .close)
            XCTAssertTrue(self.filter(viewModel[2], viewModel[3]))
            
        }
    }
    
    func testGroupedByOpenOrderAndSorted() {
        
        let viewModel = viewModelFactory.viewModel(file: .sample4)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) {[unowned self] error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .open)
            XCTAssertTrue(viewModel[1].status == .open)
            XCTAssertTrue(self.filter(viewModel[0], viewModel[1]))
            
            XCTAssertTrue(viewModel[2].status == .order)
            XCTAssertTrue(viewModel[3].status == .order)
            XCTAssertTrue(self.filter(viewModel[2], viewModel[3]))
            
        }
    }
    
    func testGroupedByFavouritesAndOpenOrderCloseAndSorted() {
        
        let viewModel = viewModelFactory.viewModel(file: .sample1, favourite: .favourite)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) {[unowned self] error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .order && viewModel[0].isFavourite)
            XCTAssertTrue(viewModel[1].status == .close && viewModel[1].isFavourite)
            
            XCTAssertTrue(viewModel[2].status == .open && viewModel[2].isFavourite == false)
            XCTAssertTrue(viewModel[3].status == .open && viewModel[3].isFavourite == false)
            XCTAssertTrue(self.filter(viewModel[2], viewModel[3]))
            
            XCTAssertTrue(viewModel[4].status == .order && viewModel[4].isFavourite == false)
            XCTAssertTrue(viewModel[5].status == .close && viewModel[5].isFavourite == false)
            
        }
    }
}
