//
//  ViewController.swift
//  NewNotifications
//
//  Created by John Peppe on 7/6/17.
//  Copyright © 2017 John Peppe. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification: Access Granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
    }

    @IBAction func notifyBtnTapped(sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Notification Successful")
            } else {
                print("Error with notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
        completion(false)
        return
        }
        
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "This is Awesome!"
        notif.body = "Don't you just love the new notification functionalities in iOS 10?"
        
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error as Any)
                completion(false)
            } else {
                completion(true)
            }
        })
    }
}

