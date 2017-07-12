//
//  ViewController.swift
//  tracker
//
//  Created by Raman Kazimirchyk on 5/13/17.
//  Copyright © 2017 Raman Kazimirchyk. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

extension String {
    
    func encodeURIComponent() -> String? {
        let characterSet = NSMutableCharacterSet.urlQueryAllowed
        
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)
    }
    
}

class ViewController: UIViewController {
    
    var titleLabel = UILabel()
    var counter = 0

    func login(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            counter += 1
            titleLabel.text = "CLICKED: \(counter)"
            
            let parameters: Parameters = [
                "email": "123@gmail.com",
                "password": "123456"
            ]
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/x-www-form-urlencoded",
                
            ]
            
            debugPrint("===================================================")
            
            Alamofire.request("https://stage.golance.com/app/auth/local", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                debugPrint(response)
                print("RESULT: \(response.result)")
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let superView = self.view
        superView?.backgroundColor = UIColor(red:0.09, green:0.50, blue:0.67, alpha:1.0)
        
        let loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40 ))
        loginButton.backgroundColor = UIColor.black
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.tag = 1
        
        

        let loginInput = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        loginInput.placeholder = "login"
        loginInput.borderStyle = UITextBorderStyle.roundedRect
        
        let passwordInput = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        passwordInput.placeholder = "password"
        passwordInput.borderStyle = UITextBorderStyle.roundedRect
        
        
        superView?.addSubview(loginInput)
        superView?.addSubview(passwordInput)
        superView?.addSubview(loginButton)
        superView?.addSubview(titleLabel)
        
        titleLabel.text = "Dumb label"
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(loginInput.snp.top).offset(-60)
            make.centerX.equalToSuperview()
        }
        
        loginInput.snp.makeConstraints { (make) in
            make.center.equalTo((superView?.snp.center)!)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        passwordInput.snp.makeConstraints { (make) in
            make.center.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordInput.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

