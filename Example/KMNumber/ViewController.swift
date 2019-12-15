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
        
        // normal calculate
        normalCalculate()
        
        // adnormal calculate
        adnormalCalculate()
        
        compare()
        
        decimalTest()
    }

    func normalCalculate() -> Void {
        print("normal calculate \n")
        
        let n1 = KMNumber("100000")
        let n11 = KMNumber("101")
        let result1 = n1 + n11
        let result11 = n1.calculate(operator: .add, aNumber: n11)
        let result111 = n1.calculate(operator: .add, aNumber: n11, roundingMode: .down, decimal: 0)
        print("+", result1, result11, result111)
        /*
         100101
         100101
         100101
         */
        
        
        let n2 = KMNumber("100")
        let n22 = KMNumber("1.2356784901")
        let result2 = n2 - n22
        let result22 = n2.calculate(operator: .subtract, aNumber: n22)
        let result222 = n2.calculate(operator: .subtract, aNumber: n22, roundingMode: .up, decimal: 4)
        print("-", result2, result22, result222)
        /*
         98.7643215099
         98.7643215099
         98.7644
         */
        
        let n3 = KMNumber("100.00100100100")
        let n33 = KMNumber("1.1101101101")
        let result3 = n3 * n33
        let result33 = n3.calculate(operator: .multiply, aNumber: n33)
        let result333 = n3.calculate(operator: .multiply, aNumber: n33, roundingMode: .plain)
        print("*", result3, result33, result333)
        /*
         111.0121222313303202101
         111.0121222313303202101
         111.0121222313303202101
         */
        
        let n4 = KMNumber("100.01")
        let n44 = KMNumber("3.3")
        let result4 = n4 / n44
        let result44 = n4.calculate(operator: .divide, aNumber: n44)
        let result444 = n4.calculate(operator: .divide, aNumber: n44, roundingMode: .bankers, decimal: 10)
        print("/", result4, result44, result444)
        /*
         30.3060606060606060606060606060606060606
         30.3060606060606060606060606060606060606
         30.3060606061
         */
    }
    
    func adnormalCalculate() -> Void {
        print("adnormal calculate \n")
        
        let n1 = KMNumber("12.3 4 50 6")
        let n11 = KMNumber("100")
        print(n1 + n11)
        // 112.34506
        
        
        let n2 = KMNumber("12.3 4 50 6hello")
        let n22 = KMNumber("100")
        print(n2 + n22)
        // 112.34506
        
        
        let n3 = KMNumber("error100")
        let n33 = KMNumber("1.1234")
        print(n3 * n33)
        // 0
        
        
        let n4 = KMNumber("zero")
        let n44 = KMNumber("0")
        print(n4 / n44)
        /*
         "calculate error - NaN"
         0
         */
        
    }
    
    func compare() {
        let tempArr: [(KMNumber, KMNumber)] = [
            (KMNumber("100"), KMNumber("100.00")),
            (KMNumber("100"), KMNumber("1.1101")),
            (KMNumber("100"), KMNumber("101.01"))
        ]

        tempArr.forEach { numbers in

            let n1 = numbers.0
            let n11 = numbers.1

            let r1 = n1 > n11
            let r11 = n1 == n11
            let r111 = n1 < n11
            let r1111 = n1 != n11
            print(r1, r11, r111, r1111)
        }
    }
    
    func decimalTest() -> Void {
        
        let arr: [KMNumber] = [KMNumber("100"), KMNumber("100.12"), KMNumber("100.125"), KMNumber("100.100000012345312")]
        
        arr.forEach { (number) in
            var temp = number
            temp.decimalFormatter(2, mode: .plain)
            print(temp)
        }
    }
}

