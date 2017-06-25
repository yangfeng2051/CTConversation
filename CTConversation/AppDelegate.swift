//
//  AppDelegate.swift
//  CTConversation
//
//  Created by 杨锋 on 2017/1/19.
//  Copyright © 2017年 杨锋. All rights reserved.
//

import UIKit
import XMPPFramework
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,XMPPStreamDelegate {

    var window: UIWindow?
    
    
    
    var xmppStream :XMPPStream?
    
    func setUpXMPPStream() {
        xmppStream = XMPPStream()
        xmppStream!.addDelegate(self, delegateQueue:DispatchQueue.global())
    }
    
    func connectToHost(){
        
        self.setUpXMPPStream()
        if let stream = xmppStream {
            let myJID = XMPPJID(user:"y000001",domain:"192.168.31.54",resource:"ipnone")
            stream.myJID = myJID
            stream.hostName = "192.168.31.54"
            stream.hostPort = 5222
            
            do {
                try stream.connect(withTimeout: XMPPStreamTimeoutNone)
            } catch let error as NSError {
                print(error)
            }
        } else {
            self.setUpXMPPStream()
        }
        


    }
    func sendPassWordToHost() {
        do {
            try xmppStream!.authenticate(withPassword: "123456")
        } catch let error as NSError {
            print(error)
        }
    }
    func sendOnlineToHost() {
        xmppStream!.send(XMPPPresence())
        print(XMPPPresence())
    }
    
    
    // MARK: XMPPStreamDelegate
    func xmppStreamDidConnect(_ sender: XMPPStream!) {
        print("链接成功")
        self.sendPassWordToHost()
    }
    func xmppStreamDidDisconnect(_ sender: XMPPStream!, withError error: Error!) {
        print("链接断开失败\(error)")
    }
    
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        print("登录成功")
        self.sendOnlineToHost()
    }
    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        print(error);
    }
    func logout() {
        xmppStream!.send(XMPPPresence(name: "unavailable"))
        print(XMPPPresence(name: "unavailable"))
        xmppStream!.disconnect()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.connectToHost()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

