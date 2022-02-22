//
//  CharacterListInteractorSpec.swift
//  AppStack_Tests
//
//  Created by Marius Gutoi on 22/2/22.
//  Copyright © 2022 AppStack. All rights reserved.
//

import RxSwift
import RxBlocking
import Quick
import Nimble

//@testable import AppStack_Demo

class CharacterListInteractorSpec: QuickSpec {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    override func spec() {
        
        var interactor: CharacterListInteractor!
        
        describe("interactor") {
                        
            context("no data arriving") {
                
                afterEach {
                    interactor = nil
                }
                
                beforeEach {
                    
                    let charactersProvider: CharactersProvider = { page in
                        .never()
                    }
                    
                    interactor = CharacterListInteractor(charactersProvider: charactersProvider)
                }
                                
                it("should not receive anything in 2 seconds") {
                
                    guard let _ = try? interactor.charactersObservable.toBlocking(timeout: 2).first() else {
                        return
                    }
                    
                    fail("characters should not return")
                }
                
            }
            
        }
        
        describe("success") {
                        
            context("first page") {
                
                afterEach {
                    interactor = nil
                }
                
                beforeEach {
                    
                    let charactersProvider: CharactersProvider = { page in
                            .just(([CharacterEntity(name: "Name 1", image: URL(string: "")!)], false))
                            .delay(.seconds(1), scheduler: MainScheduler.instance)
                    }
                    
                    interactor = CharacterListInteractor(charactersProvider: charactersProvider)
                }
                                
                it("should not receive anything in 2 seconds") {
                
                    guard let _ = try? interactor.charactersObservable.toBlocking(timeout: 2).first() else {
                        return
                    }
                    
                    fail("characters should not return")
                }
                
            }
            
        }

        
    }
    
}



