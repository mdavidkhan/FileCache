//
//  ViewController.swift
//  FileCacheDemo
//
//  Created by Muhammad Dawood on 5/24/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit
import FileCache

class ViewController: UIViewController {
    //initilize file manager with instance
    var cacheManager:CacheFileManager = CacheFileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    @IBAction func test(_ sender: Any) {
        let urlString = "http://imgs.xkcd.com/comics/i_am_not_good_with_boomerangs.png"
        let url = NSURL(string: urlString)
        let data = cacheManager.getDataFrom(url as URL!) { (data:Data?, error:Error?) in
            print(data)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

