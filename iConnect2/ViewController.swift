//
//  ViewController.swift
//  iConnect2
//
//  Created by Darth Vader on 30/11/2015.
//  Copyright © 2015 Darth Vader. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation


class ViewController: UIViewController,CLLocationManagerDelegate{
    
    var thread1:NSThread?
    var client:TCPClient?
    var startLocation: CLLocation!
    var urlOrigin = ""
    let locationManager = CLLocationManager()
    var currentLocationString = ""
    var route = ""
    var str = ""
    var urlDict: Dictionary<Int, String> = [0: "www.google.com", 1: "text"]
    @IBOutlet weak var actiIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var buttonMap: UIButton!
    
    @IBOutlet weak var getIP: UITextField!
    
    @IBAction func buttonConnect(sender: AnyObject) {
        connectServer()
        //SwiftLoading().showLoading()
        //thread1?.start()
    }
    @IBAction func buttonGetLocation(sender: AnyObject) {
        locationManager.startUpdatingLocation()
            }
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var msgGet: UILabel!
    
    @IBOutlet weak var Label1: UILabel!
    
    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var Label3: UILabel!
    
    @IBOutlet weak var s1Label: UILabel!
    @IBOutlet weak var s2Label: UILabel!
    @IBOutlet weak var s3Label: UILabel!
    
    
    func coordinateConstruct(Sitenumber:Int)->String
    {
        let myFileURL = NSBundle.mainBundle().URLForResource("location", withExtension: "txt")!
        let data = try! String(contentsOfURL: myFileURL, encoding:NSUTF8StringEncoding)
        let content = data
        var myStrings = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        var locSet = myStrings[Sitenumber - 1].componentsSeparatedByString(" ")
        
        var location = locSet[1].componentsSeparatedByString(",")
        let geoLocation = CLLocation(latitude: (location[0] as NSString).doubleValue, longitude: (location[1] as NSString).doubleValue)
        
        let latit = String(format: "%.7f",
            geoLocation.coordinate.latitude)
        let longi = String(format: "%.7f",
            geoLocation.coordinate.longitude)
        let thisLocationString = String(stringInterpolation: latit, ",", longi)
        
        return thisLocationString
    }
    
    
    func connectServer(){
        //actiIndicatorView.startAnimating()
        //SwiftLoading().hideLoading()
        print("started")
        let sockURL = String(getIP.text!)
        self.client = TCPClient(addr: sockURL, port:8080)
        let (success,errmsg)=client!.connect(timeout: 5)
        //SwiftLoading().showLoading()
        
        if success{
            
            let data=client!.read(1024*10)
            let str = NSString(bytes:data!, length:data!.count, encoding: NSUTF8StringEncoding)
            print("done here")
            urlConstruct(str!)
            //print(urlOrigin)
            //return str!
            SwiftLoading().hideLoading()
            
            
        }else{
            print(errmsg)
            SwiftLoading().hideLoading()
        }
        //return str
        
    }
    /*
    func routeConstruct(Sitedict:Dictionary<Int, String>)->String
    {
        var locPre = Sitedict[0]?.componentsSeparatedByString(",")
        var locDouble = locPre[0]

        return route
    }
*/
    
    func urlConstruct(str: NSString)->Dictionary<Int, String>{
        
        if str == ""{
            msgGet?.text = String("Data not fetched")
            urlOrigin = "http://www.bing.com"
            urlDict = [0: urlOrigin, 1: "test"]
            return urlDict
        }
        
        if str == "99999999"{
            msgGet?.text = String("Server Error")
            urlOrigin = "http://www.google.com"
            urlDict = [0: urlOrigin, 1: "test"]
            return urlDict
            
        }
        if str == "00000000"{
            msgGet?.text = String("Data Feteched")
            s1Label?.text = String("Normal")
            s2Label?.text = String("Normal")
            s3Label?.text = String("Normal")
            urlOrigin = "http://www.google.com/maps"
            urlDict = [0: urlOrigin, 1: "test"]
            return urlDict
        }
        if str == "00000001"{
            msgGet?.text = String("Data Feteched")
            s1Label?.text = String("Alert")
            s2Label?.text = String("Normal")
            s3Label?.text = String("Normal")
            let route = String(currentLocationString+"/"+coordinateConstruct(1) + "/" + currentLocationString)
            urlOrigin = "https://www.google.com/maps/dir/"+route+"/@"+currentLocationString+",17z"
            urlDict = [0: urlOrigin, 1: "test1"]
            return urlDict
        }
        if str == "00000002"{
            msgGet?.text = String("Data Feteched")
            s1Label?.text = String("Normal")
            s2Label?.text = String("Alert")
            s3Label?.text = String("Normal")
            let route = String(currentLocationString+"/"+coordinateConstruct(2) + "/" + currentLocationString)
            urlOrigin = "https://www.google.com/maps/dir/"+route+"/@"+currentLocationString+",17z"
            urlDict = [0: urlOrigin, 1: "test2"]
            return urlDict
        }
        if str == "00000003"{
            msgGet?.text = String("Data Feteched")
            s1Label?.text = String("Normal")
            s2Label?.text = String("Normal")
            s3Label?.text = String("Alert")
            let route = String(currentLocationString+"/"+coordinateConstruct(3) + "/" + currentLocationString)
            urlOrigin = "https://www.google.com/maps/dir/"+route+"/@"+currentLocationString+",17z"
            urlDict = [0: urlOrigin, 1: "test3"]
            return urlDict
        }
        if str == "00000012"{
            msgGet?.text = String("Data Feteched")
            s1Label?.text = String("Alert")
            s2Label?.text = String("Alert")
            s3Label?.text = String("Normal")
            let route = String(currentLocationString+"/"+coordinateConstruct(1)+"/"+coordinateConstruct(2) + "/" + currentLocationString)
            urlOrigin = "https://www.google.com/maps/dir/"+route+"/@"+currentLocationString+",17z"
            urlDict = [0: urlOrigin, 1: "test12"]
            return urlDict
        }
        if str == "00000013"{
            msgGet?.text = String("Data Feteched")
            s1Label?.text = String("Alert")
            s2Label?.text = String("Normal")
            s3Label?.text = String("Alert")
            let route = String(currentLocationString+"/"+coordinateConstruct(1)+"/"+coordinateConstruct(3) + "/" + currentLocationString)
            urlOrigin = "https://www.google.com/maps/dir/"+route+"/@"+currentLocationString+",17z"
            urlDict = [0: urlOrigin, 1: "test13"]
            return urlDict
            
        }
        if str == "00000023"{
            msgGet?.text = String("Data Feteched")
            s1Label?.text = String("Normal")
            s2Label?.text = String("Alert")
            s3Label?.text = String("Alert")
            //let Sitedict :Dictionary<Int,String> = [0:currentLocationString, 2: coordinateConstruct(2), 3:coordinateConstruct(3)]
            //print(Sitedict["0"])
            //routeConstruct(Sitedict)
            let route = String(currentLocationString+"/"+coordinateConstruct(2)+"/"+coordinateConstruct(3) + "/" + currentLocationString)
            urlOrigin = "https://www.google.com/maps/dir/"+route+"/@"+currentLocationString+",17z"
            urlDict = [0: urlOrigin, 1: "test23"]
            return urlDict
        }
        if str == "00000123"{
            msgGet?.text = String("Data Feteched")
            s1Label?.text = String("Alert")
            s2Label?.text = String("Alert")
            s3Label?.text = String("Alert")
            let route = String(currentLocationString+"/"+coordinateConstruct(3)+"/"+coordinateConstruct(2)+"/"+coordinateConstruct(1)+"/" + currentLocationString)
            urlOrigin = "https://www.google.com/maps/dir/"+route+"/@"+currentLocationString+",17z"
            urlDict = [0: urlOrigin, 1: "test123"]
            return urlDict
        }
        return urlDict

    }
    
    
    func locationManager(manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation])
    {
        let latestLocation: AnyObject = locations[locations.count - 1]
        
        let latitude = String(format: "%.7f",
            latestLocation.coordinate.latitude)
        let longitude = String(format: "%.7f",
            latestLocation.coordinate.longitude)
        
        locationManager.stopUpdatingLocation()
        currentLocationString = String(stringInterpolation: latitude, ",", longitude)
        locationLabel.text = currentLocationString
        
        if startLocation == nil {
            startLocation = latestLocation as! CLLocation
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        startLocation = nil
        s1Label?.text = String("unknown")
        s2Label?.text = String("unknown")
        s3Label?.text = String("unknown")
        msgGet?.text = String(" ")
        locationLabel?.text = String(" ")
        thread1 = NSThread(target: self, selector: "connectServer", object: nil)
        //buttonMap.enabled = false
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMapView"{
            let DestVewController: MapView = segue.destinationViewController as! MapView
            DestVewController.urlTest = urlDict[0]!
        }
        if segue.identifier == "showbingMap"{
            let DestVewController: bingMapView = segue.destinationViewController as! bingMapView
            DestVewController.URL = urlDict[1]!
        }
    }

    
}


