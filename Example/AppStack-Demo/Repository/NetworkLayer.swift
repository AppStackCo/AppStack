//
//  NetworkLayer.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 AppStack. All rights reserved.
//

import Moya
import RxSwift

final class NetworkLayer {
    
    lazy var provider: MoyaProvider<RickMortyApi> = {
                
        let loggerConfiguration =
//            NetworkLoggerPlugin.Configuration(logOptions: .verbose)
            NetworkLoggerPlugin.Configuration()
        
        let provider = MoyaProvider<RickMortyApi>(
//            stubClosure: MoyaProvider<SenukaiApi>.immediatelyStub,
//            plugins: [NetworkLoggerPlugin(configuration: loggerConfiguration)]
        )
        
        return provider
    }()
    
//    func getCharacters() -> Single<[CharacterEntity]> {
//
//        return provider.rx
//            .request(.characters)
//            .map(CharacterList.self)
//            .map { $0.results }
//            .catch { [weak self] error in
//                self?.handleError(error)
//                return .error(error)
//            }
//    }
    
    func getCharacters(page: Int?) -> Single<([CharacterEntity], Bool)> {
        
        return provider.rx
            .request(.characters(page))
            .map(CharacterList.self)
            .map { ($0.results, $0.info.nextPageUrl != nil) }
            .catch { [weak self] error in
                self?.handleError(error)
                return .error(error)
            }
    }
}

extension NetworkLayer {
    
    func handleError(_ error: Error) {
        
        if let moyaError = error as? MoyaError {
            switch moyaError {
            case let .objectMapping(error, response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data, options: []) else { fatalError() }
                print(error)
                print(json)
                assert(false)
            default:
                break
            }
        }
        
        print("Error: \(error.localizedDescription)")
    }
}

