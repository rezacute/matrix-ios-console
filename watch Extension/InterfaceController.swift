//
//  InterfaceController.swift
//  watch Extension
//
//  Created by syahRiza on 2/14/16.
//  Copyright © 2016 matrix.org. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    
    var stat : Bool = true
    
    let urlstr = "http://www.roomtech.io:8008/_matrix/client/api/v1/rooms/%21NJZrdRyAEqljNSQkTL%3Alocalhost/send/m.room.message?access_token=MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjJjaWQgdXNlcl9pZCA9IEByaXphOmxvY2FsaG9zdAowMDE2Y2lkIHR5cGUgPSBhY2Nlc3MKMDAxZGNpZCB0aW1lIDwgMTQ1NDc3NjA2OTczNAowMDJmc2lnbmF0dXJlIF5TWbxwDikyXTyIqAQsG2wyvEXOZVQPEPOODKe11MoBCg"
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    @IBAction func didPressDanceButton() {
        let url = NSURL(string: urlstr)
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        let params:[String: AnyObject] = ["msgtype":"m.text", "body":"!ev3 dance"]
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("response was not 200: \(response)")
                    return
                }
            }
            if (error != nil) {
                print("error submitting request: \(error)")
                return
            }
            
            
        }
        task.resume()
    }
    
    @IBAction func didPressBlinkButton() {
        let base = "!smarthome"
        let status = stat ? "on" : "off"
        let url = NSURL(string: urlstr)
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        let params:[String: AnyObject] = ["msgtype":"m.text", "body":"\(base) remote light \(status) "]
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("response was not 200: \(response)")
                    return
                }
            }
            if (error != nil) {
                print("error submitting request: \(error)")
                return
            }
            
            self.stat = !self.stat
        }
        task.resume()
    }


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
