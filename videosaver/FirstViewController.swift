//
//  FirstViewController.swift
//  videosaver
//
//  Created by Kamronbek on 1/24/19.
//  Copyright © 2019 Kamronbek. All rights reserved.
//

import UIKit
import Foundation
import Photos


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


class FirstViewController: UIViewController {
    
    @IBOutlet weak var setlink: UITextField!
    @IBOutlet weak var DownloadAction: UILabel!
    
    
    // tap to hide keyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    @IBAction func button(_ sender: Any) {
        if setlink.text == "" {
            self.DownloadAction.text = "Вставьте ссылку для скачивания"
        } else {
            self.DownloadAction.text = "Скачивание началось"
            
            guard
                setlink.text?.range(of: "^(http|https|)(://|)(www.|)instagram.com", options: .regularExpression) != nil else {
                print("String is invalid")
                return
            }
            print("String is valid")
            
            var requests = URLRequest(url: URL(string: setlink.text!)!)
            requests.httpMethod = "GET"
            
            guard let myURL = NSURL(string: setlink.text!) else {
                print("error")
                return
            }

            do {
                let myHTMLString = try String(contentsOf: myURL as URL)

                let matched = matches(for: "video_url\":\"(.*mp4).*\",\"video_view_count", in: myHTMLString)
                
                let matched_1_replace = matched[0].replacingOccurrences(of: "video_url\":\"", with: "")
                
                let matched_2_replace = matched_1_replace.replacingOccurrences(of: "\",\"video_view_count", with: "")
                
                
                DispatchQueue.global(qos: .userInteractive).async {
                    if let url = URL(string: matched_2_replace),
                        let urlData = NSData(contentsOf: url) {
                            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                            let filePath="\(documentsPath)/tempFile.mp4"
                            DispatchQueue.main.async {
                                urlData.write(toFile: filePath, atomically: true)
                                PHPhotoLibrary.shared().performChanges({
                                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                                }) { completed, error in
                                    if completed {
                                        print("video saved!!")
                                        let notification = Notification(name: Notification.Name("Скачано"))
                                        NotificationQueue.default.enqueue(notification, postingStyle: .whenIdle, coalesceMask: .none, forModes: nil)
                                    }
                                }
                            }
                        self.DownloadAction.text = "Видео скачано"
                    }
                }
                
            } catch let error {
                print("Error: \(error)")
            }
        }
    }

}

