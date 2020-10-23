//
//  BaseNetworkManager.swift
//  DawnGitHubSearch
//
//  Created by Nadeem Ali on 10/22/20.
//  Copyright © 2020 Nadeem Ali. All rights reserved.
//

import Foundation
import Alamofire


class BaseNetworkManager : NSObject
{
    typealias SuccessCompletion = (Any) -> Void
    
    typealias FailureCompletion = (APIError) -> Void

     func certificates(in bundle: Bundle = Bundle.main) -> [SecCertificate] {
        var certificates: [SecCertificate] = []

        let paths = Set([".cer", ".CER", ".crt", ".CRT", ".der", ".DER"].map { fileExtension in
            bundle.paths(forResourcesOfType: fileExtension, inDirectory: nil)
            }.joined())

        for path in paths {
            if
                let certificateData = try? Data(contentsOf: URL(fileURLWithPath: path)) as CFData,
                let certificate = SecCertificateCreateWithData(nil, certificateData)
            {
                certificates.append(certificate)
            }
        }

        return certificates
    }
    func performNetworkRequest(forRouter router: BaseRouter ,showLoading : Bool, onSuccess: @escaping SuccessCompletion , onFailure: @escaping FailureCompletion)
    {
        if showLoading{
            //MALoadingIndicator.shared.showLoading()
        }
       // let serverTrustPolicies: [String: ServerTrustPolicy] = [

     //   ]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 120
        let sessionManager = Alamofire.SessionManager(
            configuration: configuration
         )
        
//        do {
//            if let data = try router.asURLRequest().httpBody, let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String:Any]
//            {
//                print(json) // use the json here
//                if let theJSONData = try? JSONSerialization.data(
//                    withJSONObject: json,
//                    options: []) {
//                    let theJSONText = String(data: theJSONData,
//                                             encoding: .ascii)
//                    print("Parameters = \(theJSONText!)")
//                }
//            } else {
//                print("bad json")
//            }
//        } catch let error as NSError {
//            print(error)
//        }
        print("Parameters = ", (router.parameters) as Any)
         sessionManager.request(router)
        .validate()
            .responseString(completionHandler: { (response) in
//            print("----- STRING Response ", response.result.value as Any)

            })
        .responseData(completionHandler: { (response) in
            switch response.result
            {
            case .success(_ ):
                return  onSuccess(response.data)
            case .failure(_):
                return onFailure(APIError.init())
            }
            })
        .responseJSON { (response) in
            sessionManager.session.invalidateAndCancel()
            if showLoading{
               // MALoadingIndicator.shared.hideLoading()
//                print("----- JSON Response ", response.result.value as Any)

            }

            switch response.result
            {
            case .success( _):
//                    if let value = response.result.value ,let theJSONData = try? JSONSerialization.data(
//                        withJSONObject: value,
//                        options: []) {
//                       if let theJSONText = String(data: theJSONData,
//                                                   encoding: .ascii){
//                        print("----- Success Response \(theJSONText)")
//
//                        }
//                    }
                print("----- Success Response ", response.result.value as Any)

                return onSuccess(response.result.value)
            case .failure(_):
                print("----- Failure Response ", response.result.value as Any)

                let apiError = APIError()
                
                if response.data != nil
                {
//                    let json = JSON(data: response.data!)
                    apiError.response = response.data!
                }
                
                if let error = response.result.error as? AFError
                {
                    apiError.responseStatusCode = error._code // statusCode private
                    
                    var localizedDescription : String = "an error has occurred please try again"
                    var failureReason : String?
                    switch error
                    {
                        case .invalidURL(let url):
                            
                            localizedDescription = "Invalid URL: \(url) - \(error.localizedDescription)"
                            print("Invalid URL: \(url) - \(error.localizedDescription)")
                        
                        case .parameterEncodingFailed(let reason):
                            
                            localizedDescription = "Parameter encoding failed: \(error.localizedDescription)"
                            failureReason = "Failure Reason: \(reason)"
                            print("Parameter encoding failed: \(error.localizedDescription)")
                            print("Failure Reason: \(reason)")
                        
                        
                        case .multipartEncodingFailed(let reason):
                            localizedDescription = "Multipart encoding failed: \(error.localizedDescription)"
                            failureReason = "Failure Reason: \(reason)"
                            print("Multipart encoding failed: \(error.localizedDescription)")
                            print("Failure Reason: \(reason)")
                        
                        case .responseValidationFailed(let reason):
                            localizedDescription = "Response validation failed: \(error.localizedDescription)"
                            failureReason = "Failure Reason: \(reason)"
                            print("Response validation failed: \(error.localizedDescription)")
                            print("Failure Reason: \(reason)")
                            
                            switch reason
                            {
                                case .dataFileNil, .dataFileReadFailed:
                                    localizedDescription = "Downloaded file could not be read"
                                    print("Downloaded file could not be read")
                                case .missingContentType(let acceptableContentTypes):
                                    localizedDescription = "Content Type Missing: \(acceptableContentTypes)"
                                    print("Content Type Missing: \(acceptableContentTypes)")
                                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                                    localizedDescription = "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)"
                                    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                                case .unacceptableStatusCode(let code):
                                    localizedDescription = "Response status code was unacceptable: \(code)"
                                    print("Response status code was unacceptable: \(code)")
                                    apiError.responseStatusCode = code
                            }
                        case .responseSerializationFailed(let reason):
                            if response.response?.statusCode == 200 && response.result.value == nil{
                                onSuccess(response.result.value as Any)
                            }
                            else{
                                localizedDescription = "Response serialization failed: \(error.localizedDescription)"
                                failureReason = "Failure Reason: \(reason)"
                                print("Response serialization failed: \(error.localizedDescription)")
                                print("Failure Reason: \(reason)")

                            }
                    }
                    
                    apiError.message = localizedDescription
                    apiError.extraDescription = failureReason
                }
                else if let error = response.result.error as? URLError
                {
                    print("URLError occurred: \(error)")
                    apiError.error = error
                }
                else
                {
                    print("Unknown error: \(String(describing: response.result.error))")
                }
                
                return onFailure(apiError)
            }
        }
    }
    
    
   
}
