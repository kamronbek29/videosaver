//
//  FirstViewController.swift
//  videosaver
//
//  Created by Kamronbek on 1/24/19.
//  Copyright © 2019 Kamronbek. All rights reserved.
//

import UIKit
import Foundation

//class FirstViewController: UIViewController {
//    @IBOutlet weak var setlinkTextField: UITextField!
//    @IBOutlet weak var DownloadAction: UILabel!
//    @IBAction func DownloadUIButton(_ sender: UIButton) {
//        DownloadAction.text = "Скачивание началось"

//        var request = URLRequest(url: URL(string: "http://127.0.0.1:8000")!)
//        request.httpMethod = "POST"
//        var postStringtext = self.DownloadAction
//        var string = self.setlinkTextField.addTarget(self, action: #selector(_) , for: <#T##UIControl.Event#>)
//
//
//        request.httpBody = postStrin.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error = \(String(describing: String(describing: error)))")
//                return
//            }
//
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(String(describing: response))")
//            }
//
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(String(describing: responseString))")
//        }
//
//        task.resume()
//
//        func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//}
//}


//class FirstViewController: UIViewController {
//    let button = UIButton()
//    let Switch = UISwitch()
//    let textField = UITextField()
//
//    @IBOutlet weak var text: UITextField!
//    @IBOutlet weak var downloadButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        ///////////////////////////////////////////////////
//        ///////////////////////////////////////////////////
//        ///////////////////////////////////////////////////
//
//        // button
//        // set position
//        self.button.frame = CGRect(x: 100, y: 200, width: 200, height: 100)
//
//        // set color
//        self.button.backgroundColor = UIColor.red
//
//        // set title
//        self.button.setTitle("Кнопка", for: .normal)
//        self.button.setTitle("Кнопка нажата", for: .highlighted)
//
//        // set button to view
//        self.view.addSubview(self.button)
//
//
//        //// Switch Controller
//
//        // position
//        self.Switch.frame = CGRect.zero
//        self.Switch.center = self.view.center
//
//
//        // set switch to view
//        self.view.addSubview(self.Switch)
//
//        //on
//        if self.Switch.isOn {
//            print("Switch on")
//        } else {
//            print("Switch off")
//        }
//
//        self.Switch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
//
//        self.textField.backgroundColor = UIColor.red
//        self.textField.frame = CGRect.zero
//        self.textField.center = view.center
//        self.view.addSubview(self.textField)
//
//        self.text.addTarget(self, action: #selector(TextFieldChange(paramTargetText:)), for: .valueChanged)
//        print(self.text)
//
//        ///////////////////////////////////////////////////
//        ///////////////////////////////////////////////////
//        ///////////////////////////////////////////////////
//
//        self.downloadButton.setTitle("Скачать", for: .focused)
//        self.view.addSubview(downloadButton)
//
//
//
//
//    }
//
//
//
//
//
//    @IBAction func TextFieldChange(paramTargetText: UITextField) {
//        if paramTargetText.isTextDragActive {
//            print(paramTargetText)
//        } else {
//            print(paramTargetText)
//        }
//    }
//
//    @IBAction func switchChange(paramTarget: UISwitch) {
//        if paramTarget.isOn {
//            self.view.backgroundColor = UIColor.white
//            print("Switch on")
//        } else {
//            self.view.backgroundColor = UIColor.black
//            print("Switch off")
//        }
//    }
//
//    @IBAction func switchChange(parametrTarget: UISwitch) {
//        if parametrTarget.isOn {
//            self.button.isUserInteractionEnabled = false
//            print("Switch on")
//        } else {
//            self.button.isUserInteractionEnabled = true
//            print("Switch off")
//        }
//    }
//}



class FirstViewController: UIViewController {
    
    @IBOutlet weak var setlink: UITextField!
    @IBOutlet weak var DownloadAction: UILabel!
    @IBAction func button(_ sender: Any) {
        if setlink.text == "" {
            self.DownloadAction.text = "Вставьте ссылку для скачивания"
        } else {
            self.DownloadAction.text = setlink.text
            var request = URLRequest(url: URL(string: "https://en6sdvdk7wcf3.x.pipedream.net/")!)
            request.httpMethod = "POST"
            
            let paramString: String = setlink.text!
            request.httpBody = paramString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error = \(String(describing: String(describing: error)))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        }
    }
    

}
