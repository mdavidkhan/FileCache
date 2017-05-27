//
//  WebServicesManager.swift
//  FileCache
//
//  Created by Muhammad  Dawood on 25/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit
import FileCache


/// the main class for this app to manage the webservices calls and responses , this also able to cache the data form any webservice
class WebServicesManager: NSObject {
    
    var delegate:WebServicesManagerDelegates?
    
    // MARK: - Shared Instance
    static let sharedInstance: WebServicesManager = {
        let instance = WebServicesManager()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    override init() {
        super.init()
    }

    
    //initilize file manager with instance
    var cacheManager:CacheFileManager = CacheFileManager()
    
    
    /// this method is used to download the list of all items to display in home screen , or it is using to download and cache the Provided API data
    ///
    /// - Parameter dataURL: the URL for API
    func downloadTheJSONDataUsingUrl(dataURL:URL) {
        //download and cache the complete JSON
        cacheManager.getDataFrom(dataURL) { (file:FileInfo?, error:Error?) in
            if (error == nil) && (file != nil) {
                var pinterestModelsArray:[CustomPinterestObjectModel]? = []
                
                //if data is availble then parse the JSON and create the readymate objects from JSON
                do {
                    let object = try JSONSerialization.jsonObject(with: (file?.getFileData())!, options: .allowFragments)
                    //parese to array because the webservice have main object as an array
                    if let pinterestJSONObjectsArray = object as? NSArray{
                        //init a model  for adding the data in proper way
                        var pinterestObjectModel:CustomPinterestObjectModel?
                        
                        for singleObject in pinterestJSONObjectsArray {
                            if let dictionary = singleObject as? [String: AnyObject] {
                                pinterestObjectModel = CustomPinterestObjectModel(dictionary)
                                pinterestModelsArray?.append(pinterestObjectModel!)
                            }
                        }
                    }
                    
                    guard let successMethod = self.delegate?.didFinishGetingDataFromPinterestTestService else {
                        //ignore if delegate is not set
                        return
                    }
                    //call delegate after successfull download of objects
                    successMethod(pinterestModelsArray)
                    
                } catch {
                    //Handle Error
                    guard let failedMethod = self.delegate?.didFailedGetingDataFromPinterestTestService else {
                        //ignore if delegate is not set
                        return
                    }
                    
                    failedMethod(error)
                }
            }
            else{
                guard let failedMethod = self.delegate?.didFailedGetingDataFromPinterestTestService else {
                    //ignore if delegate is not set
                    return
                }
                
                failedMethod(error)
            }
        }
    }
}

/// the main webservices manager delegates this will deal with every ingoing and outgoing data and errors
protocol WebServicesManagerDelegates {
    /// This will call after successfully downloading of Pinterest test WebService data
    ///
    /// - Parameter fetchedObjectsArray:array having all downloaded objects which are ready for display
    func didFinishGetingDataFromPinterestTestService(fetchedObjectsArray:[CustomPinterestObjectModel]?)
    
     /// this method will call if there are any issue occured in downloading the data from Pinterest test webservice
     ///
     /// - Parameter error: the generatedError
     func didFailedGetingDataFromPinterestTestService(error:Error?)
    
}

/// the URL Factory structure this will used to save any URLs for downloading and uploading data relates to this app 
struct WebServicesURLFactory {
    static var URLForMainPageAPI = URL(string:"http://pastebin.com/raw/wgkJgazE")
}
