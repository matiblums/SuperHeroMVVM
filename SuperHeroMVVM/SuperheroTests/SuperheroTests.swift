//
//  SuperheroTests.swift
//  SuperheroTests
//
//  Created by Mblum on 15/05/2021.
//

import XCTest
@testable import SuperHeroMVVM

class SuperheroTests: XCTestCase {
    
    var vc: HomeView!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCargaDatos(){
        vc.title = "hola"
    }
    
}
