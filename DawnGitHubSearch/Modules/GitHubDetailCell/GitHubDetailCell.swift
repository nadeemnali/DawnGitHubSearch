//
//  GitHubDetailCell.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/23/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Foundation
import UIKit
class GitHubDetailCell : UITableViewCell

{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetailinfo: UILabel!
    
    static var cellIdentifier: String {
           return "GitHubDetailCell"
       }
}
