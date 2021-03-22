//
//  SignInService.swift
//  SwiftTestQuest
//
//  Created by Kit on 3/22/21.
//

import Foundation
import Moya

enum SignInService {
    case signIn(_ credentials: Credentials)
}

extension SignInService: TargetType {
    
    var baseURL: URL {
        URL(string: "https://google.com")!
    }
    
    var path: String {
        switch self {
        case .signIn(_): return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var validationType: ValidationType {
        .successCodes
    }
}
