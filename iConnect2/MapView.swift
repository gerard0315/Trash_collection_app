//
//  MapView.swift
//  iConnect2
//
//  Created by Darth Vader on 01/12/2015.
//  Copyright © 2015 Darth Vader. All rights reserved.
//

import UIKit
import WebKit

class MapView: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    
    //var urlWeb = ""
    var urlTest = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //var urlWeb = "www.google.com"
        var requestURL = NSURL(string: urlTest);
        //print(urlWeb)
        
        var request = NSURLRequest(URL: requestURL!)
        myWebView!.loadRequest(request)

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
