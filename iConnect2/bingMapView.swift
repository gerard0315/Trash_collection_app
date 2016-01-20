//
//  bingMapView.swift
//  iConnect2
//
//  Created by Darth Vader on 11/12/2015.
//  Copyright © 2015 Darth Vader. All rights reserved.
//

import UIKit

class bingMapView: UIViewController {
    
    var URL = ""

    @IBOutlet weak var bingMap: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSBundle.mainBundle().URLForResource(URL , withExtension:"html")
        let request = NSURLRequest(URL: url!)
        bingMap.loadRequest(request)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
