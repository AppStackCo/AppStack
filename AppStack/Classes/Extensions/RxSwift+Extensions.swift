//
//  RxSwift+Extensions.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 21/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxSwift

extension Observable {
    public static func createFromCompletable(_ completable: @escaping (() -> Completable)) -> Observable<Void> {
        Observable<Void>.create { observable in
            let disposable = completable()
                .subscribe(onCompleted: {
                    observable.onNext(())
                    observable.onCompleted()
                }, onError: { error in
                    observable.onError(error)
                })
            
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
