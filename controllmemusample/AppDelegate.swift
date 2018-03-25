//
//  AppDelegate.swift
//  controllmemusample
//
//  Created by tatsumi kentaro on 2018/02/23.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase
import DKImagePickerController
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    var productArray = [Product]()
    var cellOfNum:Int!
    var opposerid: String!
    var productid: String!
    var photoCount: Int!
    var sectionID: Int!
    var posX: CGFloat!
    var posY: CGFloat!
    var width: CGFloat!
    var height: CGFloat!
    var posArray = [CGFloat]()
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            print("通っているよ1")
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)

        }
    
        application.registerForRemoteNotifications()
        
        // アプリ起動時にFCMのトークンを取得し、表示する
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
        
        UINavigationBar.appearance().barTintColor = UIColor.white
        var viewControllers: [UIViewController] = []
        
        
        // 1ページ目になるViewController
        let firstSB = UIStoryboard(name: "A", bundle: nil)
        let firstVC = firstSB.instantiateInitialViewController()! as UIViewController
        firstVC.tabBarItem = UITabBarItem(title: "取引", image: UIImage(named:"trade.png"), tag: 1)
        viewControllers.append(firstVC)
        
        // 2ページ目になるViewController
        let secondSB = UIStoryboard(name: "C", bundle: nil)
        let secondVC = secondSB.instantiateInitialViewController()! as UIViewController
        secondVC.tabBarItem = UITabBarItem(title: "チャット", image: UIImage(named:"chat.png"), tag: 2)
        viewControllers.append(secondVC)
        
        // 3ページ目になるViewController
        let thirdSB = UIStoryboard(name: "D", bundle: nil)
        let thirdVC = thirdSB.instantiateInitialViewController()! as UIViewController
        thirdVC.tabBarItem = UITabBarItem(title: "イベント", image: UIImage(named:"event.png"), tag: 3)
        viewControllers.append(thirdVC)
        
        // 4ページ目になるViewController
        let fourthSB = UIStoryboard(name: "E", bundle: nil)
        let fourthVC = fourthSB.instantiateInitialViewController()! as UIViewController
        fourthVC.tabBarItem = UITabBarItem(title: "授業評価", image: UIImage(named:"curriculum.png"), tag: 4)
        viewControllers.append(fourthVC)
        
        // 5ページ目になるViewController
        let fifthSB = UIStoryboard(name: "B", bundle: nil)
        let fifthVC = fifthSB.instantiateInitialViewController()! as UIViewController
        fifthVC.tabBarItem = UITabBarItem(title: "その他", image: UIImage(named:"option.png"), tag: 5)
        viewControllers.append(fifthVC)
        
        
        // ViewControllerをセット
        let tabBarController = UITabBarController()
        posX = tabBarController.tabBar.frame.origin.x
        posY = tabBarController.tabBar.frame.origin.y
        width = tabBarController.tabBar.frame.width
        height = tabBarController.tabBar.frame.height
        posArray = [posX,posY,width,height]
        
        tabBarController.tabBar.unselectedItemTintColor = UIColor.orange
        tabBarController.tabBar.tintColor = UIColor.red
        //        tabBarController.tabBar.backgroundColor = UIColor.black
        tabBarController.setViewControllers(viewControllers, animated: false)
        
        // rootViewControllerをUITabBarControllerにする
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        return true
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        let deviceTokenString: String = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        print("デバイストークン \(deviceTokenString)")
        
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        
    }
    
    
}


// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("通っているよ2")
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("通っているよ3")
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
    
}

// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        print("通っているよ4")
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("通っているよ5")
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
}




