//
//  AppDelegate.swift
//  MarveleduardofulgencioApi
//
//  Created by Eduardo Fulgencio on 25/4/17.
//  Copyright © 2017 Eduardo Fulgencio. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var appCoordinator: AppCoordinador!
    var listCoordinator: Listado!
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        
        window = UIWindow()
        listCoordinator = Listado(window: window!)
        listCoordinator.inicializar()
        window?.makeKeyAndVisible()
        
        return true
    }
}

