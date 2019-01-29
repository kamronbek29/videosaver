//
//  FirstViewController.swift
//  videosaver
//
//  Created by Kamronbek on 1/24/19.
//  Copyright © 2019 Kamronbek. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var setlinkTextField: UITextField!
    @IBOutlet weak var DownloadAction: UILabel!
    @IBAction func DownloadUIButton(_ sender: UIButton) {
        DownloadAction.text = "Скачивание началось"
//        UIApplication.shared.keyWindow!.endEditing(true)
        
//        let urlString = "http://jsonplaceholder.typicode.com/users/1"
//        guard let requestUrl = URL(string:urlString) else { return }
//        let request = URLRequest(url:requestUrl)
//        let _ = URLSession.shared.dataTask(with: request) {
//            (data, response, error) in
//            self.DownloadAction.text = "Скачивание 1111"
//            if error == nil,let usableData = data {
//                print(usableData) //JSONSerialization
//            }
//        }

        
        let urlString = URL(string: "https://jsonplaceholder.typicode.com/users/1")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    self.DownloadAction.text = "error"
                } else {
                    self.DownloadAction.text = "done"
                    if let data = data {
                        if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                            self.DownloadAction.text = stringData
                        }
                    }
                }
            }
            task.resume()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}
