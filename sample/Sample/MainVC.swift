//
//  MainVC.swift
//  sample
//
//  Created by Magic on 9/5/2016.
//  Copyright © 2016 Magic. All rights reserved.
//

import UIKit
import ZstdSwift

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "sample"

        let content = "testGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGotestGo"
        guard
            let origin = content.data(using: .utf8),
            let encrypted = try? origin.compressZstd(),
            let new_origin = try? encrypted.decompressZstd()
        else {
            print("some error1")
            return
        }
        

        if origin == new_origin {
            print("success origin:\(origin.count)  encrypted:\(encrypted.count)")
        } else {
            print("failed some error2")
        }
        
    }
}
