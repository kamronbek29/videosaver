//
//  FirstViewController.swift
//  videosaver
//
//  Created by Kamronbek on 1/24/19.
//  Copyright © 2019 Kamronbek. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: UIViewController {
    
    @IBOutlet weak var setlink: UITextField!
    @IBOutlet weak var DownloadAction: UILabel!
    
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
//                let matched = matches(for: "video_url\":\"(.*mp4)\"", in: myHTMLString)

                let matched = matches(for: "video_url\":\"(.*mp4).*fna.fbcdn.net\",\"video_view_count", in: myHTMLString)
                print(matched)
                let new_string = matched[0].replacingOccurrences(of: "video_url\":\"", with: "")
                
                let string_new = new_string.replacingOccurrences(of: "\",\"video_view_count", with: "")
                print(string_new)
                
            } catch let error {
                print("Error: \(error)")
            }
        }
    }

}

