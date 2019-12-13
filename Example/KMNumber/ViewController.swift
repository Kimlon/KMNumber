//
//  ViewController.swift
//  KMNumber
//
//  Created by Kimlon on 12/12/2019.
//  Copyright (c) 2019 Kimlon. All rights reserved.
//

import UIKit
import KMNumber

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let _ = KMNumber("0.1212213444567890122221112121232323343454656575745")
//        let _ = KMNumber("哈哈")
//        let _ = KMNumber("1.哈哈")
//        let _ = KMNumber("哈哈.12")
//        let _ = KMNumber("哈哈100.12")
//        let _ = KMNumber("12.34op56")
        
        let n1 = KMNumber("天啊")
        let n2 = KMNumber("3.1")
        
        print(n1.calculate(operator: .add, aNumber: n2, roundingMode: .down, decimal: 2))
        print(n1.calculate(operator: .subtract, aNumber: n2, roundingMode: .down, decimal: 3))
        print(n1.calculate(operator: .multiply, aNumber: n2, roundingMode: .up, decimal: 4))
        print(n1.calculate(operator: .divide, aNumber: n2, roundingMode: .plain, decimal: 5))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

