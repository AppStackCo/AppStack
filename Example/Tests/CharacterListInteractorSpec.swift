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
import RxRelay

/// PageInteractor
///
/// inputs:
/// - refresh
/// - load next page
///
/// outputs:
/// - is loading
/// - elements
/// - error
///
/// dependency
/// - get page
///
///
/// TESTS:
///
/// GIVEN:
/// no input
///
/// WHEN:
/// --
///
/// THEN:
/// receive first page
///
///
/// GIVEN:
/// no input
///
/// WHEN:
/// --
///
/// THEN:
/// receive first page


class CharacterListInteractorSpec: QuickSpec {

    override func spec() {
        
        var refresh: PublishRelay<Void>!
        var loadNextPage: PublishRelay<Void>!
        
        var interactor: PagingInteractor<Int>!
        
        var scheduler: TestScheduler!
        var disposeBag: DisposeBag!
        
        
        /// GIVEN:
        /// --
        ///
        /// WHEN:
        /// no input
        ///
        /// THEN:
        /// receive first page
        ///
        describe("--") {

            context("no input") {

                afterEach {
                    
                    scheduler = nil
                    disposeBag = nil

                    interactor = nil
                }

                beforeEach {

                    scheduler = TestScheduler(initialClock: 0)
                    disposeBag = DisposeBag()

                    refresh = PublishRelay()
                    loadNextPage = PublishRelay()

                    let paginationInput = PaginationInput(
                        refresh: refresh.asObservable(),
                        loadNextPage: loadNextPage.asObservable())

                    interactor = PagingInteractor(input: paginationInput, pageProvider: pageProvider(scheduler: scheduler))
                }

                it("should receive first page") {

                    // create observer
                    let elementsObserver = scheduler.createObserver([Int].self)

                    // bind observer
                    interactor.elements
                        .debug()
                        .bind(to: elementsObserver)
                        .disposed(by: disposeBag)

                    scheduler.start()
                    
                    expect(elementsObserver.events).to(equal([.next(1, [1, 2])]))
                }

            }
        }
        
        /// GIVEN:
        /// no input
        ///
        /// WHEN:
        /// load next page
        ///
        /// THEN:
        /// receive first two pages
        ///
        describe("no input") {

            context("load next page") {

                afterEach {
                    
                    scheduler = nil
                    disposeBag = nil

                    interactor = nil
                }

                beforeEach {

                    scheduler = TestScheduler(initialClock: 0)
                    disposeBag = DisposeBag()

                    refresh = PublishRelay()
                    loadNextPage = PublishRelay()

                    let paginationInput = PaginationInput(
                        refresh: refresh.asObservable(),
                        loadNextPage: loadNextPage.asObservable())

                    interactor = PagingInteractor(input: paginationInput, pageProvider: pageProvider(scheduler: scheduler))
                }

                it("should receive first two pages") {

                    // create observer
                    let elementsObserver = scheduler.createObserver([Int].self)

                    // bind observer
                    interactor.elements
                        .debug()
                        .bind(to: elementsObserver)
                        .disposed(by: disposeBag)

                    scheduler.scheduleAt(1) {
                        loadNextPage.accept(())
                    }
                    
                    scheduler.start()
                    
                    expect(elementsObserver.events).to(equal(
                        [.next(1, [1, 2]),
                         .next(2, [1, 2, 3, 4])]))
                }
            }
        }
        
        
        /// GIVEN:
        /// refresh
        /// load next page
        ///
        /// WHEN:
        /// refresh
        ///
        /// THEN:
        /// receive first page
        ///
        describe("refresh and load next page") {

            context("refresh") {

                afterEach {
                    
                    scheduler = nil
                    disposeBag = nil

                    interactor = nil
                }

                beforeEach {

                    scheduler = TestScheduler(initialClock: 0)
                    disposeBag = DisposeBag()

                    refresh = PublishRelay()
                    loadNextPage = PublishRelay()

                    let paginationInput = PaginationInput(
                        refresh: refresh.asObservable(),
                        loadNextPage: loadNextPage.asObservable())

                    interactor = PagingInteractor(input: paginationInput, pageProvider: pageProvider(scheduler: scheduler))
                }

                it("should receive first page") {

                    // create observer
                    let elementsObserver = scheduler.createObserver([Int].self)

                    // bind observer
                    interactor.elements
                        .debug()
                        .bind(to: elementsObserver)
                        .disposed(by: disposeBag)

                    // refresh
                    scheduler.scheduleAt(1) { refresh.accept(()) }
                    
                    // load next page
                    scheduler.scheduleAt(2) { loadNextPage.accept(()) }
                    
                    // refresh
                    scheduler.scheduleAt(3) { refresh.accept(()) }

                    scheduler.start()
                    
                    expect(elementsObserver.events).to(equal(
                        [.next(1, [1, 2]), // initial load
                         .next(2, [1, 2]), // refresh
                         .next(3, [1, 2, 3, 4]), // load next page
                         .next(4, [1, 2])])) // refresh
                }
            }
        }
    }
}

func pageProvider(scheduler: SchedulerType) -> PageProvider<Int> {
    
    return PageProvider<Int> { page in
        var results: [Int]
        switch page {
        case 1: results = [1, 2]
        case 2: results = [3, 4]
        default: fatalError()
        }
        
        return .just((results, false)).delay(.seconds(1), scheduler: scheduler)
    }
    
}
