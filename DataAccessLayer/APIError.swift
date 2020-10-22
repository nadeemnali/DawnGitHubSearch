//
//  APIError.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/22/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//


import Foundation

class APIError: NSObject
{
     init(_ message : String = "an error has occurred please try again") {
        self.message = message
    }
    var message : String = "an error has occurred please try again"
    var extraDescription : String?
    var responseStatusCode : Int?
    var response : Any?
    var error : Error?
    
}
