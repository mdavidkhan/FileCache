//
//  ViewController.swift
//  FileCacheDemo
//
//  Created by Muhammad Dawood on 5/24/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit
import FileCache
let CellReuseIdentifier = "Cell"
let kMaxNumberOfCellsLoadingAtaTime:Double = 10
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,WebServicesManagerDelegates{
    //initilize file manager with instance
    var cacheManager:CacheFileManager = CacheFileManager()
    
    //the main array used to display the contents on collection view
    var pinterestIemsBackUpArray:[CustomPinterestObjectModel]?
    
    var painterestItemsArray:NSMutableArray? = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        self.collectionView!.collectionViewLayout = layout
        self.painterestItemsArray?.maximimNumberForNewFilesLoading = kMaxNumberOfCellsLoadingAtaTime;
        
        //apply cusotme cofiguration on cache manager 
        
        let configuration  = CacheConfiguration(customeConfigurationWithMaximumMemoryCapacity: 100, withMaximumNumberOfFiles: 10, with: .Memory)
        self.cacheManager.applyCacheCustomConfiguration(configuration)
        
    }
    
    // MARK: UIViewCollectionViewDataSource
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.painterestItemsArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let CellIdentifier = "Cell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! CollectionViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMMddHHmmssSSS"
        cell.timeStamp = dateFormatter.string(from: NSDate() as Date) as NSString
        let URLString = self.painterestItemsArray?[(indexPath as NSIndexPath).row]
        let url = URL(string:URLString as! String)!
        cacheManager.getDataFrom(url as URL!) { (file:FileInfo?, error:Error?) in
            if (error == nil) && (file != nil) {
                if (file?.isFileValid(for: url))!{
                    cell.imageView.image = UIImage(data: (file?.getFileData())!)
                }
            }
        }
        return cell
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    //MARK: Web-Service Delegates
    
    func didFinishGetingDataFromPinterestTestService(fetchedObjectsArray: [CustomPinterestObjectModel]?) {
        //assign the downloaded objects to local array
        self.pinterestIemsBackUpArray = fetchedObjectsArray
        self.painterestItemsArray?.addLatestObjectsFromArray(backUpArray: self.pinterestIemsBackUpArray!)
    }
    
    func didFailedGetingDataFromPinterestTestService(error: Error?) {
        let alert = UIAlertController(title: "Downloading Failed", message:String("Downloading of Data Failed with Error: \(String(describing: error?.localizedDescription))"), preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default) { (UIAlertAction) in}
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: Helpers
    
}


