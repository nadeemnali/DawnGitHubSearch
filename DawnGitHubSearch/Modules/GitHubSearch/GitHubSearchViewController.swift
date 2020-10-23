//
//  GitHubSearchViewController.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/22/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class GitHubSearchViewController: BaseViewController {
    
    private let gitHubSearchManager = SearchGitHubManager()
    
    @IBOutlet var tableView : UITableView!
    var objGitHubResults : GitHubSearchModel!
    
    static func instantiateFromStoryboard() -> GitHubSearchViewController {
        let storyboard = UIStoryboard(name: "GitHubSearchViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "GitHubSearchViewController") as! GitHubSearchViewController
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = "Repository library" 
        //  self.searchGitHub(name: "star")
        configureUI()
    }
    func configureUI()
    {
        tableView.register(UINib.init(nibName:GitHubSearchCell.cellIdentifier , bundle: nil), forCellReuseIdentifier: GitHubSearchCell.cellIdentifier)
        tableView.layer.cornerRadius = 2.0
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.5
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    func searchGitHub(name : String)
    {
        gitHubSearchManager.searchGitHub(with: name,
                                         onSuccess:
            { (result) in
                
                self.objGitHubResults = result
                self.updateTableView()
                
                
        }) { (apiError) in
            self.hideLoading()
        }
    }
    
    func updateTableView()
    {
        self.tableView.reloadData()
    }
    
    func hanldeSelectionForIndex(index: Int) {
        let detailsViewController = GitHubDetailViewController.instantiateFromStoryboard()
        detailsViewController.objItem = self.objGitHubResults.items[index]
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
extension GitHubSearchViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text!.count > 3)
        {
            self.searchGitHub(name: searchBar.text!)
        }
    }
}

extension GitHubSearchViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.objGitHubResults == nil ? 0 :  self.objGitHubResults.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GitHubSearchCell.cellIdentifier, for:     indexPath) as! GitHubSearchCell
        
        let objItem : Item = self.objGitHubResults.items[indexPath.row]
        cell.lblTitle.text = objItem.fullName
        cell.lblDetailinfo.text = objItem.itemDescription
        cell.gitImageView.sd_setImage(with:URL(string: objItem.owner.avatarURL), completed: nil)
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  self.objGitHubResults == nil ? "Searching..." :  String(self.objGitHubResults.totalCount) + " results"
    }
    
    
    
}
extension GitHubSearchViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hanldeSelectionForIndex(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
