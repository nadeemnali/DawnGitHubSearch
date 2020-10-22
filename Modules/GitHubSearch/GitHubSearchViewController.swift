//
//  GitHubSearchViewController.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/22/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Foundation
import UIKit


class GitHubSearchViewController: BaseViewController {
    
       private let gitHubSearchManager = SearchGitHubManager()
  
    
    static func instantiateFromStoryboard() -> GitHubSearchViewController {
        let storyboard = UIStoryboard(name: "GitHubSearchViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "GitHubSearchViewController") as! GitHubSearchViewController
    }
    
    override func viewDidLoad() {
        
        self.searchGitHub(name: "star")
    }
    
    func searchGitHub(name : String)
    {
        gitHubSearchManager.searchGitHub(with: name,
                   onSuccess:
                   { (accessInfo) in
                 
                 // print (accessInfo)
                     //  self.profileObj = accessInfo
                      // self.bindUI()
                     
                       
               
               }) { (apiError) in
                   self.hideLoading()
                  
                 //  self.showError()
               }
    }
    
}
