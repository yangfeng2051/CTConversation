//
//  ViewController.swift
//  CTConversation
//
//  Created by 杨锋 on 2017/1/19.
//  Copyright © 2017年 杨锋. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        (UIApplication.shared.delegate as! AppDelegate).logout()
    }


}

