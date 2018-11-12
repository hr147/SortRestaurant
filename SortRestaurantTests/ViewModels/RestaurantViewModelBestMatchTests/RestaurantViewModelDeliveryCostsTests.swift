//
//  RestaurantViewModelDeliveryCostsTests.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import XCTest

@testable import SortRestaurant
class RestaurantViewModelDeliveryCostsTests: XCTestCase {

    let defaultSort = RestaurantSort("Delivery Costs",DeliveryCostsSort())
    var sorts:[RestaurantSort]!
    var testBundle:Bundle!
    let favouriteDataStore = StubFavouriteRestaurantDataStore()
    let wireFrame = StubMessageWireframe()
    
    override func setUp() {
        testBundle = Bundle(for: type(of: self))
        sorts = [defaultSort]
    }
    
    func testDeliveryCost_GroupedByOpenOrderCloseAndSorted() {
        
        let dataStore = StubRestaurantDataStore(
            bundle:testBundle,
            fileName:"BestMatchSample1",
            translate:JSONTranslation())
        
        
        let viewModel = RestaurantViewModel(
            restaurantDataStore: dataStore,
            restaurantFavouriteDataStore: favouriteDataStore,
            messageWireFrame: wireFrame,
            currentSort: defaultSort,
            restaurantSorts: sorts)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .open)
            XCTAssertTrue(viewModel[1].status == .open)
            XCTAssertTrue(viewModel[0].sort.deliveryCosts >= viewModel[1].sort.deliveryCosts)
            
            XCTAssertTrue(viewModel[2].status == .order)
            XCTAssertTrue(viewModel[3].status == .order)
            XCTAssertTrue(viewModel[2].sort.deliveryCosts >= viewModel[3].sort.deliveryCosts)
            
            XCTAssertTrue(viewModel[4].status == .close)
            XCTAssertTrue(viewModel[5].status == .close)
            XCTAssertTrue(viewModel[4].sort.deliveryCosts >= viewModel[5].sort.deliveryCosts)
            
        }
    }
    
    func testDeliveryCost_GroupedByOrderCloseAndSorted() {
        
        let dataStore = StubRestaurantDataStore(
            bundle:testBundle,
            fileName:"BestMatchSample2",
            translate:JSONTranslation())
        
        
        let viewModel = RestaurantViewModel(
            restaurantDataStore: dataStore,
            restaurantFavouriteDataStore: favouriteDataStore,
            messageWireFrame: wireFrame,
            currentSort: defaultSort,
            restaurantSorts: sorts)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .order)
            XCTAssertTrue(viewModel[1].status == .order)
            XCTAssertTrue(viewModel[0].sort.deliveryCosts >= viewModel[1].sort.deliveryCosts)
            
            XCTAssertTrue(viewModel[2].status == .close)
            XCTAssertTrue(viewModel[3].status == .close)
            XCTAssertTrue(viewModel[2].sort.deliveryCosts >= viewModel[3].sort.deliveryCosts)
            
        }
    }
    
    func testDeliveryCost_GroupedByOpenCloseAndSorted() {
        
        let dataStore = StubRestaurantDataStore(
            bundle:testBundle,
            fileName:"BestMatchSample3",
            translate:JSONTranslation())
        
        
        let viewModel = RestaurantViewModel(
            restaurantDataStore: dataStore,
            restaurantFavouriteDataStore: favouriteDataStore,
            messageWireFrame: wireFrame,
            currentSort: defaultSort,
            restaurantSorts: sorts)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .open)
            XCTAssertTrue(viewModel[1].status == .open)
            XCTAssertTrue(viewModel[0].sort.deliveryCosts >= viewModel[1].sort.deliveryCosts)
            
            XCTAssertTrue(viewModel[2].status == .close)
            XCTAssertTrue(viewModel[3].status == .close)
            XCTAssertTrue(viewModel[2].sort.deliveryCosts >= viewModel[3].sort.deliveryCosts)
            
        }
    }
    
    func testDeliveryCost_GroupedByOpenOrderAndSorted() {
        
        let dataStore = StubRestaurantDataStore(
            bundle:testBundle,
            fileName:"BestMatchSample4",
            translate:JSONTranslation())
        
        
        let viewModel = RestaurantViewModel(
            restaurantDataStore: dataStore,
            restaurantFavouriteDataStore: favouriteDataStore,
            messageWireFrame: wireFrame,
            currentSort: defaultSort,
            restaurantSorts: sorts)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .open)
            XCTAssertTrue(viewModel[1].status == .open)
            XCTAssertTrue(viewModel[0].sort.deliveryCosts >= viewModel[1].sort.deliveryCosts)
            
            XCTAssertTrue(viewModel[2].status == .order)
            XCTAssertTrue(viewModel[3].status == .order)
            XCTAssertTrue(viewModel[2].sort.deliveryCosts >= viewModel[3].sort.deliveryCosts)
            
        }
    }
    
    func testDeliveryCost_GroupedByFavouritesAndOpenOrderCloseAndSorted() {
        
        let dataStore = StubRestaurantDataStore(
            bundle:testBundle,
            fileName:"BestMatchSample1",
            translate:JSONTranslation())
        
        
        let viewModel = RestaurantViewModel(
            restaurantDataStore: dataStore,
            restaurantFavouriteDataStore: StubBestMatchFavouriteRestaurantDataStore(),
            messageWireFrame: wireFrame,
            currentSort: defaultSort,
            restaurantSorts: sorts)
        
        // 1. Define an expectation
        
        let expect = expectation(description: "Result successfully fetectched")
        
        
        viewModel.refresh.subscribe = { _ in
            expect.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertTrue(viewModel[0].status == .order && viewModel[0].isFavourite)
            XCTAssertTrue(viewModel[1].status == .close && viewModel[1].isFavourite)
            
            XCTAssertTrue(viewModel[2].status == .open && viewModel[2].isFavourite == false)
            XCTAssertTrue(viewModel[3].status == .open && viewModel[3].isFavourite == false)
            XCTAssertTrue(viewModel[2].sort.deliveryCosts >= viewModel[3].sort.deliveryCosts)
            
            XCTAssertTrue(viewModel[4].status == .order && viewModel[4].isFavourite == false)
            XCTAssertTrue(viewModel[5].status == .close && viewModel[5].isFavourite == false)
            
        }
    }
}
