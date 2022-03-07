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
        
//        describe("success") {
//                        
//            context("first page") {
//                
//                afterEach {
//                    interactor = nil
//                }
//                
//                beforeEach {
//                    interactor =
//                        PagingInteractor(pageProvider: PageProvider<Int> { page in
//                            .just(([1, 2], false))
//                            .delay(.seconds(1), scheduler: MainScheduler.instance)
//                    })
//                }
//                                
//                it("should receive first page") {
//
//                    interactor.getFirstPage()
//                    
//                    guard let allElements = try? interactor.allElementsObservable.toBlocking(timeout: 2).first() else {
//
//                        fail("first page should be returned")
//                        return
//                    }
//                    
//                    expect(allElements).to(equal([1, 2]))
//                }
//            }
//            
//        }

        describe("initial interactor") {
                 
            afterEach {
                print("GIVEN: after")
            }
            
            beforeEach {
                print("GIVEN: before")
            }
            
            context("get first page twice") {
                
                afterEach {
                    scheduler = nil
                    disposeBag = nil
                    
                    interactor = nil
                }
                
                beforeEach {
                    
                    scheduler = TestScheduler(initialClock: 0, resolution: 1)
                    disposeBag = DisposeBag()
                    
                    interactor =
                        PagingInteractor(pageProvider: PageProvider<Int> { page in
                            .just(([1, 2], false))
                            .delay(.seconds(2), scheduler: scheduler)
                    })
                }
                
                it("should ignore second request if comes in < 2s") {

                    // create observer
                    let allElementsObserver = scheduler.createObserver([Int].self)

                    // bind observer
                    interactor.allElementsObservable
                        .debug()
                        .bind(to: allElementsObserver)
                        .disposed(by: disposeBag)

                    // schedule two consecutive actions
                    scheduler.scheduleAt(2) {
                        NSLog("after 2 sec")
                        interactor.getFirstPage()
                    }

                    scheduler.scheduleAt(3) {
                        NSLog("after 3 sec")
                        interactor.getFirstPage()
                    }

                    NSLog("Start")
                    scheduler.start()

                    expect(allElementsObserver.events).to(equal([.next(4, [1, 2])]))
                }
                
                it("should allow second request if comes in > 2s") {

                    // create observer
                    let allElementsObserver = scheduler.createObserver([Int].self)

                    // bind observer
                    interactor.allElementsObservable
                        .debug()
                        .bind(to: allElementsObserver)
                        .disposed(by: disposeBag)

                    // schedule two consecutive actions
                    scheduler.scheduleAt(2) {
                        interactor.getFirstPage()
                    }

                    scheduler.scheduleAt(5) {
                        interactor.getFirstPage()
                    }

                    NSLog("Start")
                    scheduler.start()

                    expect(allElementsObserver.events).to(equal([
                        .next(4, [1, 2]),
                        .next(7, [1, 2])]))
                }
            }
        }
        
    }
    
}



