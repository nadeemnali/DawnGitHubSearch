//
//  GitHub.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/22/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Foundation
import Alamofire

enum GitHubSearchEndPoints {
    case searchGitHub(name:String)
}

class GitHubSearchRouter:BaseRouter{
    var endPoint:GitHubSearchEndPoints
    init(endPoint:GitHubSearchEndPoints) {
        self.endPoint = endPoint
    }
    
    override var method: HTTPMethod
    {
        switch endPoint {
            
        case .searchGitHub:
            return .get
            
        }
    }
    override var parameters: APIParams
    {
        switch endPoint {
        case .searchGitHub(let name):
             return ["q": name as AnyObject]
        }
       
    }
   
    
    override var path: String{
        
        switch endPoint {
        case .searchGitHub(let name):
            return "/search/repositories"
        }
    }
    override var encoding: ParameterEncoding?{
        
        switch method {
        case .get:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }
    
    
    override var baseURLString: String {
           return EnviromentManager.shared.endPoint
       }
    override var requestHeaders: [String : Any]{
        //        switch endpoint {
        //        default:
        return ["Content-Type" : "application/json", "Accept" : "application/json"]
        //        }
    }
    
}
