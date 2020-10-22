//
//  SearchGitHubManager.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/22/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Alamofire

class SearchGitHubManager : BaseNetworkManager{
    
    func searchGitHub(with name:String , onSuccess: @escaping (GitHubSearchModel) -> Void, onFailure: @escaping (APIError) -> Void)
    {
        let router = GitHubSearchRouter(endPoint: .searchGitHub(name: name))
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach{
                if $0.originalRequest?.url?.path == router.path{
                    $0.cancel()
                }
            }
        }
        super.performNetworkRequest(forRouter: router, showLoading: false, onSuccess: { (responseObject) in
            
            guard responseObject is Data else {
                onFailure(APIError())
                return
            }
            
            let decoder = JSONDecoder()
            let gitHubSearchModel = try! decoder.decode(GitHubSearchModel.self, from: responseObject as! Data)
          
            
            
            onSuccess(gitHubSearchModel)
            
        }) { (error) in
            print(error.description)
            onFailure(APIError())
        }
    }
    
   
}
