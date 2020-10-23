//
//  GitHubSearchCell.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/23/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Foundation

import UIKit
class GitHubSearchCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetailinfo: UILabel!
    @IBOutlet weak var gitImageView : UIImageView!
    
    static var cellIdentifier: String {
            return "GitHubSearchCell"
        }
    override func awakeFromNib() {
         self.gitImageView.layer.cornerRadius = 2.0
        self.gitImageView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
}
