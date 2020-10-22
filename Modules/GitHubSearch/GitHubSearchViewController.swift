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
    }
    
    func searchGitHub(name : String)
    {
        gitHubSearchManager.searchGitHub(with: name,
                   onSuccess:
                   { (result) in
                 
                 // print (accessInfo)
                     //  self.profileObj = accessInfo
                      // self.bindUI()
                    self.objGitHubResults = result
                    self.updateTableView()
                       
               
               }) { (apiError) in
                   self.hideLoading()
                  
                 //  self.showError()
               }
    }
    
    func updateTableView()
    {
        self.tableView.reloadData()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let objItem : Item = self.objGitHubResults.items[indexPath.row]
        cell?.textLabel?.text = objItem.fullName
        cell?.detailTextLabel?.text = objItem.itemDescription
        cell?.imageView?.sd_setImage(with:URL(string: objItem.owner.avatarURL), completed: nil)
        
        return cell!
    }
    
   
    
}
