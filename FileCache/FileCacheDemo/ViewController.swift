//
//  ViewController.swift
//  FileCacheDemo
//
//  Created by Muhammad Dawood on 5/24/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit
import FileCache

//MARK: the constants
let CellReuseIdentifier = "Cell"
let footerReuseIdentifier = "myFooterView"

let kMaxCacheSizeinMBs = 100
let kMaxCacheFileNumbers = 100

let kMaxNumberOfCellsLoadingAtaTime:Double = 2



/// the main view controller which used to show the photos
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,WebServicesManagerDelegates{
    
    //MARK : the properties and Outlets
    
    //initilize file manager with instance
    var cacheManager:CacheFileManager = CacheFileManager()
    
    //the main array used to display the contents on collection view
    var pinterestIemsBackUpArray:[CustomPinterestObjectModel]? = []
    
    var painterestItemsArray:NSMutableArray? = []
    
    @IBOutlet weak var JSONLoadingIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var refreshControl: UIRefreshControl!

    //MARK : the main view controller Methods 
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register the cell
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier)
        
        //geister the footer
        self.collectionView!.register(CollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerReuseIdentifier)
        
        //set the max item loaded in one go
        self.painterestItemsArray?.maximimNumberForNewFilesLoading = kMaxNumberOfCellsLoadingAtaTime;
        
        //apply cusotm cofiguration on cache manager
        
        let configuration  = CacheConfiguration(customeConfigurationWithMaximumMemoryCapacityInMBs: Double(kMaxCacheSizeinMBs), withMaximumNumberOfFiles: Int32(kMaxCacheFileNumbers), with: .Memory)
        
        self.cacheManager.applyCacheCustomConfiguration(configuration)
        
        //start downloading the API data
        self.JSONLoadingIndicator.startAnimating()
        WebServicesManager.sharedInstance.delegate = self
        WebServicesManager.sharedInstance.downloadTheJSONDataUsingUrl(dataURL: WebServicesURLFactory.URLForMainPageAPI!)
        
        //pull to refresh work
        self .addRefreshControllToCollectionView()
    }
    
    // MARK: UIViewCollectionViewDataSource and Delegates
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.painterestItemsArray!.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2.5, height: self.view.frame.height/2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let CellIdentifier = "Cell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! CollectionViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMMddHHmmssSSS"
        cell.timeStamp = dateFormatter.string(from: NSDate() as Date) as NSString
        
        //extract the model from the array
        let pinterestModel = self.painterestItemsArray?[(indexPath as NSIndexPath).row] as? CustomPinterestObjectModel
        //get the small image size to display in the collectionview
        let urlString = pinterestModel?.urls?.regular
        
        let url = URL(string:urlString!)!
        //the main process for downloading and cacheing the object to momory
        let operationTimeStamp = cacheManager.getDataFrom(url as URL!) { (file:FileInfo?, error:Error?) in
            if (error == nil) && (file != nil) {
                if (file?.isFileValid(for: url))!{
                    cell.imageView.image = UIImage(data: (file?.getFileData())!)
                }
            }
        }
       
        
        
        //MARK: canceling request code
        //this code will be used to cancel the on going operation with specific times stamp
        //        self.cacheManager.cancelDownloadOperation(withTimeStamp: operationTimeStamp);
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //lets do some animation
        let customCell = cell as? CollectionViewCell
        customCell?.addAnimationTOView()
        
        //load more data if the collection reach to the end and there are still data in backup array
        if indexPath.item == ((self.painterestItemsArray?.count)!-1) && ((self.pinterestIemsBackUpArray?.count)! > 0) {
            //load the new data
            self.perform(#selector(loadMoreData), with: self, afterDelay: 0.01)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerReuseIdentifier, for: indexPath) as? CollectionViewFooter
        if (self.pinterestIemsBackUpArray?.count)! > 0 {
            view?.loadingIndicator?.startAnimating()
        }
        else{
            view?.loadingIndicator?.stopAnimating()
        }
        
        
        // configure footer view
        return view!
    }
    
    //MARK: Web-Service Delegates
    
    func didFinishGetingDataFromPinterestTestService(fetchedObjectsArray: [CustomPinterestObjectModel]?) {
        //assign the downloaded objects to local array
        self.pinterestIemsBackUpArray = fetchedObjectsArray
        self .loadMoreData()
        //stop reloading indicator at top of collection view
        refreshControl.endRefreshing()
        self.JSONLoadingIndicator.stopAnimating()
    }
    
    func didFailedGetingDataFromPinterestTestService(error: Error?) {
        let alert = UIAlertController(title: "Downloading Failed", message:String("Downloading of Data Failed with Error: \(String(describing: error?.localizedDescription))"), preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default) { (UIAlertAction) in}
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        //stop reloading indicator at top of collection view
        refreshControl.endRefreshing()
    }
    
    // MARK: Helpers
    
    /// used to load more data to current view from backup array
    func loadMoreData() {
        let lastIndexOfCollection = self.lastIndexPath()
        
        self.painterestItemsArray?.addLatestObjectsFromArray(backUpArray: self.pinterestIemsBackUpArray!)
        
        if (lastIndexOfCollection?.row)! < (painterestItemsArray?.count)!-1 {
            self.collectionView.insertItems(at: self.createIndexPathsForNewItems(lastIndex: lastIndexOfCollection!))
        }
        
        self.removeInsertedObjectFromBackup()
    }
    
  
    
    /// this will renove the alreading inserted object from backup array
    func removeInsertedObjectFromBackup() {
        
        for object in (self.painterestItemsArray)!{
            //now remove that same object from the source array
            if let index = self.pinterestIemsBackUpArray?.index(of: object as! CustomPinterestObjectModel) {
                self.pinterestIemsBackUpArray?.remove(at: index)
            }
            
        }
    }
    
    /// get the last index path of collection whcich is user to add the new item underneath
    ///
    /// - Returns: the last index pf collectionview
    func lastIndexPath() -> IndexPath? {
        
        return IndexPath.init(item: (self.painterestItemsArray?.count)!, section: 0)
    }
    
    func createIndexPathsForNewItems(lastIndex:IndexPath) -> [IndexPath] {
        var indexPathArray:[IndexPath] = []
        for index in lastIndex.row...((self.painterestItemsArray?.count)!-1){
            indexPathArray.append(IndexPath.init(item: index, section: 0))
        }
        return indexPathArray
    }
    
    //MARK: Pull to refresh
    
    /// add refresh view at top of collection view
    func addRefreshControllToCollectionView() {
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
    }
    /// refresh action for Pull to refresh
    func refresh(sender:AnyObject) {
        print("refresh calls")
        //fist of all remove the downloaded JSON data (this is just to test the method otherwise this will be able to do by remove all method)
        self.cacheManager.removeFileFromCache(using: WebServicesURLFactory.URLForMainPageAPI)
        //remove all content from Contents form cache
        self.cacheManager.removeAllObjectFromCache()
        
        self.pinterestIemsBackUpArray?.removeAll()
        self.painterestItemsArray?.removeAllObjects()
        
        self.collectionView.reloadData()
        //now redownload the data
        
        WebServicesManager.sharedInstance.downloadTheJSONDataUsingUrl(dataURL: WebServicesURLFactory.URLForMainPageAPI!)
    }
    
}


