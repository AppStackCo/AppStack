//
//  CharacterListInteractorSpec.swift
//  AppStack_Tests
//
//  Created by Marius Gutoi on 22/2/22.
//  Copyright © 2022 AppStack. All rights reserved.
//

import RxSwift
import RxBlocking
import RxTest
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
        
        var interactor: PagingInteractor<Int>!
        
        var scheduler: TestScheduler!
        var disposeBag: DisposeBag!
        
        describe("interactor") {
                        
            context("no data arriving") {
                
                afterEach {
                    interactor = nil
                }
                
                beforeEach {
                    
                    let pageProvider = PageProvider<Int> { page in
                        .never()
                    }
                    
                    interactor = PagingInteractor(pageProvider: pageProvider)
                }
                                
                it("should not receive anything in 2 seconds") {
                
                    guard let _ = try? interactor.allElementsObservable.toBlocking(timeout: 2).first() else {
                        return
                    }
                    
                    fail("elements should not be returned")
                }
                
            }
            
        }
        
        describe("success") {
                        
            context("first page") {
                
                afterEach {
                    interactor = nil
                }
                
                beforeEach {
                    interactor =
                        PagingInteractor(pageProvider: PageProvider<Int> { page in
                            .just(([1, 2], false))
                            .delay(.seconds(1), scheduler: MainScheduler.instance)
                    })
                }
                                
                it("should receive first page") {

                    interactor.getFirstPage()
                    
                    guard let allElements = try? interactor.allElementsObservable.toBlocking(timeout: 2).first() else {

                        fail("first page should be returned")
                        return
                    }
                    
                    expect(allElements).to(equal([1, 2]))
                }
            }
            
        }

        describe("initial interactor") {
                 
            afterEach {
                print("GIVEN: after")
            }
            
            beforeEach {
                print("GIVEN: before")
            }
            
            context("get first page twice in a second") {
                
                afterEach {
                    scheduler = nil
                    disposeBag = nil
                    
                    interactor = nil
                }
                
                beforeEach {
                    
                    scheduler = TestScheduler(initialClock: 0)
                    disposeBag = DisposeBag()
                    
                    interactor =
                        PagingInteractor(pageProvider: PageProvider<Int> { page in
                            .just(([1, 2], false))
                            .delay(.seconds(1), scheduler: MainScheduler.instance)
                    })
                }
                
                it("should ignore second request") {

                    // create observer
                    let allElementsObserver = scheduler.createObserver([Int].self)

                    // bind observer
                    interactor.allElementsObservable
                        .bind(to: allElementsObserver)
                        .disposed(by: disposeBag)
                    
                    // schedule two consecutive actions
                    scheduler.scheduleAt(2) {
                        interactor.getFirstPage()
                        interactor.getFirstPage()
                    }
                    
                    scheduler.start()
                    
                    expect(allElementsObserver.events).to(equal([.next(2, [1, 2])]))
                }
            }
        }
        
    }
    
}



