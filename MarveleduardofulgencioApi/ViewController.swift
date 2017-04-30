//
//  ViewController.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 25/4/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     var apiCorp : ApiCorp = ApiCorp()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        ApiService.hardProcessingWithString(input: "commands") {
            (result: String) in
            print("got back: \(result)")
            // imprime esto: got back: we finished!
        }
        
        ApiService.hardProcessingWithModelBase() {
            (result: ModelBase) in
            print("un objeto: \(result.idSn)")
            // imprime esto: got back: we finished!
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

