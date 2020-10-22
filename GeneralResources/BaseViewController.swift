//
//  BaseViewController.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/22/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController{
     var isLoading: Bool = true  //for empty state use
}

extension BaseViewController {
    
    func showLoading() {
        DispatchQueue.main.async {
           // MALoadingIndicator.shared.showLoading()
            self.isLoading = true
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
           // MALoadingIndicator.shared.hideLoading()
            self.isLoading = false
        }
    }
    
}
