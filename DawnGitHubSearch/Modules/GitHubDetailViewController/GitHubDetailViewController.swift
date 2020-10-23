//
//  GitHubDetailViewController.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/23/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class GitHubDetailViewController : BaseViewController
{
    @IBOutlet var gitHubImage : UIImageView!
    @IBOutlet var lblGitHubName : UILabel!
    @IBOutlet var lblGitHubLanguage : UILabel!
    @IBOutlet var tableView : UITableView!
    var objItem : Item!
    
    
    
    static func instantiateFromStoryboard() -> GitHubDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "GitHubDetailViewController") as! GitHubDetailViewController
    }
    
    override func viewDidLoad() {
        self.configureUI()
        self.bindUI()
    }
    func configureUI()
    {
         tableView.register(UINib.init(nibName:GitHubDetailCell.cellIdentifier , bundle: nil), forCellReuseIdentifier: GitHubDetailCell.cellIdentifier)
        tableView.layer.cornerRadius = 2.0
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.5
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    func bindUI()
    {
        self.gitHubImage.sd_setImage(with:URL(string: objItem.owner.avatarURL), completed: nil)
        self.lblGitHubName.text = objItem.fullName
        self.lblGitHubLanguage.text = objItem.language
    }
}
extension GitHubDetailViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: GitHubDetailCell.cellIdentifier, for:     indexPath) as! GitHubDetailCell
        
        switch indexPath.row {
        case 0:
            cell.lblTitle.text = "Forks"
            cell.lblDetailinfo.text = String(objItem.forksCount)
            break;
         
        case 1:
            cell.lblTitle.text = "Issues"
            cell.lblDetailinfo.text = String(objItem.openIssuesCount)
            break;
        case 2:
            cell.lblTitle.text = "Starred by"
            cell.lblDetailinfo.text = String(objItem.stargazersCount)
            break;
        case 3:
            cell.lblTitle.text = "Last Release Version"
            cell.lblDetailinfo.text = String(objItem.score)
            break;
        
        default: break
            
        }
       
        
        return cell
    }
   
   
    
}

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
