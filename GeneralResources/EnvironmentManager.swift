//
//  EnvironmentManager.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/22/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Foundation

@objc public enum EnviromentType : Int{
    case PostmanTestingEnviroment
    case ClientTestEnviroment
    case ClientProductionEnviroment

}

@objc public enum EnviromentLocale : Int {
    case english
    case arabic
}

class EnviromentManager
{
    var currentEnviroment : EnviromentType = .ClientProductionEnviroment

    private var currentEnviromentLocale : EnviromentLocale = .english
    
    static var shared = EnviromentManager()
    
    var BaseURL : String {
        get{
            switch self.currentEnviroment
            {
            case .ClientProductionEnviroment:
                return ""

            case .PostmanTestingEnviroment:
                return ""
            case .ClientTestEnviroment:
                return ""
            }
        }
    }
    
    var endPoint : String {
        get{
            switch self.currentEnviroment
            {
            case .ClientProductionEnviroment:
                return kAPIBaseURL
            case .PostmanTestingEnviroment:
                return ""
            case .ClientTestEnviroment:
                return ""
            }
    }

    }

    class func intialize(enviroment:EnviromentType){
        shared.currentEnviroment = enviroment
    }
}
