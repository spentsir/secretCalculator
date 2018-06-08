//
//  AppDelegate.swift
//  secretCalculator
//
//  Created by Spencer Cawley on 6/7/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func sendToViewController(_ VCString: String){
        // code to send user to particular View Controller
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let exampleViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: VCString)
        self.window?.rootViewController = exampleViewController
        self.window?.makeKeyAndVisible()
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // APP LAUNCH
        // if passcode not set, send to intro page
        if(savedData.string(forKey: "Passcode") == nil){
            sendToViewController("PasscodeSetter")
        } else {
            sendToViewController("Calculator")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // APP RESIGNATION
        // if passcode not set, send to intro page
        if(savedData.string(forKey: "Passcode") == nil){
            sendToViewController("PasscodeSetter")
        } else {
            sendToViewController("Calculator")
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // APP RESIGNATION
        // if passcode not set, send to intro page
        if(savedData.string(forKey: "Passcode") == nil){
            sendToViewController("PasscodeSetter")
        } else {
            sendToViewController("Calculator")
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // APP INACTIVE RESUME
        // if passcode not set, send to intro page
        if(savedData.string(forKey: "Passcode") == nil){
            sendToViewController("PasscodeSetter")
        } else {
            sendToViewController("Calculator")
        }
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Calculator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

