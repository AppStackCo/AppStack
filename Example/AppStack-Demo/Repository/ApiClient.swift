//
//  ApiClient.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Moya

enum RickMortyApi {
    case characters
}

extension RickMortyApi: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        URL(string: "https://rickandmortyapi.com/api/")!
    }
    
    var path: String {
        switch self {
        case .characters: return "character"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .characters:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .characters:
            return .requestPlain
        }
    }
        
    var sampleData: Data {
        switch self {
        case .characters: return data(from: "characters")
        }
    }
}

extension RickMortyApi {
    
    private func data(from jsonFile: String) -> Data {
        guard let path = Bundle.main.path(forResource: jsonFile, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { fatalError() }
        
        return data
    }
}
