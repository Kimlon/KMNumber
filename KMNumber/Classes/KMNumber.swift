//
//  KMNumber.swift
//  FBSnapshotTestCase
//
//  Created by Kimlon on 2019/12/12.
//

import Foundation

public protocol KMNumberDecimalFormatter {
    mutating func decimalFormatter(_ decimal: Int, mode: NSDecimalNumber.RoundingMode) -> Void
    mutating func trimTailZero() -> Void
}

public struct KMNumber {
    /// max decimal
    static public let MaxDecimal: Int = Int(Int16.max)
    /// +-*/
    public enum OperatorType {
        case add, subtract, multiply, divide
    }
    
    public var value: String {
        return _value
    }
    
    private var _value: String
    public init(_ value: String) {
        _value = value.withoutSpacesAndNewLines
    }
}

// MARK: - ################################ calculate ##################################
extension KMNumber {
    static public func +(a: KMNumber, b: KMNumber) -> KMNumber {
        return a.calculate(operator: .add, aNumber: b)
    }
    
    static public func -(a: KMNumber, b: KMNumber) -> KMNumber {
        return a.calculate(operator: .subtract, aNumber: b)
    }
    
    static public func *(a: KMNumber, b: KMNumber) -> KMNumber {
        return a.calculate(operator: .multiply, aNumber: b)
    }
    
    static public func /(a: KMNumber, b: KMNumber) -> KMNumber {
        return a.calculate(operator: .divide, aNumber: b)
    }
}

// MARK: - ################################ compare ##################################
extension KMNumber {
    static public func >(a: KMNumber, b: KMNumber) -> Bool {
        a.value.isGreater(than: b.value)
    }
    
    static public func <(a: KMNumber, b: KMNumber) -> Bool {
        let result = a.value.compare(to: b.value)
        switch result {
        case .orderedAscending:
            return true
        default:
            return false
        }
    }
    
    static public func ==(a: KMNumber, b: KMNumber) -> Bool {
        let result = a.value.compare(to: b.value)
        switch result {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
    
    static public func !=(a: KMNumber, b: KMNumber) -> Bool {
        let result = a.value.compare(to: b.value)
        switch result {
        case .orderedSame:
            return false
        default:
            return true
        }
    }
}

// MARK: - ################################ calculate ##################################
extension KMNumber {
    /// 算数运算
    /// - Parameters:
    ///   - operator: +-*/
    ///   - aNumber: 被+-*/的数字
    ///   - roundingMode: plain-四舍五入；down-向下取整；up-向上取整；bankers-在四舍五入的基础上，加上末尾数为5时，变成偶数的规则（1.25->1.2; 1.35->1.4）；默认.plain
    ///   - decimal: 精度；默认MaxDecimal
    public func calculate(operator: OperatorType, aNumber: KMNumber, roundingMode: NSDecimalNumber.RoundingMode = .plain, decimal: Int = KMNumber.MaxDecimal, decimalFormatter: Bool = false) -> KMNumber {
        
        var newValue = ""
        switch `operator` {
        case .add:
            newValue = value.adding(aNumber.value, withRoundingMode: roundingMode, withDecimal: decimal)
        case .subtract:
            newValue = value.subtracting(aNumber.value, withRoundingMode: roundingMode, withDecimal: decimal)
        case .multiply:
            newValue = value.multiplying(by: aNumber.value, withRoundingMode: roundingMode, withDecimal: decimal)
        case .divide:
            newValue = value.dividing(by: aNumber.value, withRoundingMode: roundingMode, withDecimal: decimal)
        }
        
        var result = KMNumber(newValue)
        result.trimTailZero()
        if decimalFormatter {
            result.decimalFormatter(decimal)
        }
        return result
    }
}

extension KMNumber: CustomStringConvertible {
    public var description: String {
        return _value
    }
}

extension KMNumber: KMNumberDecimalFormatter {
    
    /// 精度格式化，精度不足补0
    mutating public func decimalFormatter(_ decimal: Int, mode: NSDecimalNumber.RoundingMode = .down) {
        var decimal = decimal
        
        if decimal < 0 {
            decimal = 0
        }
        var tempValue = _value
        if tempValue.isEmpty {
            return
        }

        if let dotIndex = tempValue.firstIndex(of: ".") {
            if let startIndex = tempValue.index(dotIndex, offsetBy: 1, limitedBy: tempValue.endIndex) {
                let s = tempValue[startIndex..<tempValue.endIndex]
                let count = decimal - s.count
                if count > 0 {
                    tempValue.append(String(repeating: "0", count: count))
                } else if count < 0 {
                    tempValue = KMNumber(tempValue).calculate(operator: .add, aNumber: KMNumber("0"), roundingMode: mode, decimal: decimal, decimalFormatter: true).value
                }
            }
        } else {
            tempValue.append(".")
            tempValue.append(String(repeating: "0", count: decimal))
        }
        _value = tempValue
    }
    
    /// 去除小数尾部多余的0
    mutating public func trimTailZero() -> Void {
        var tempValue = _value
        if tempValue.isEmpty {
            return
        }
        
        if tempValue.contains(".") {
            if tempValue.hasSuffix("0") || tempValue.hasSuffix(".") {
                if let stopIndex = tempValue.index(tempValue.endIndex, offsetBy: -1, limitedBy: tempValue.startIndex) {
                    tempValue = String(tempValue[tempValue.startIndex..<stopIndex])
                    _value = tempValue
                    if tempValue.hasSuffix("0") {
                        trimTailZero()
                    }
                }
            }
        }
    }
}

// MARK: - #############################################################################
fileprivate extension String {
    
    /// 加
    /// - Parameters:
    /// - mode: plain-四舍五入；down-向下取整；up-向上取整；bankers-在四舍五入的基础上，加上末尾数为5时，变成偶数的规则（1.25->1.2; 1.35->1.4）
    ///   - decimal: 精度
    func adding(_ b: String, withRoundingMode mode: NSDecimalNumber.RoundingMode, withDecimal decimal: Int) -> String {
        let numbers = prepareNumbersAndHandler(self, b, mode, decimal)
        let result = numbers.0.adding(numbers.1, withBehavior: numbers.2)
        return result.stringValue.calculateResultValid()
    }
    
    /// 减
    /// - Parameters:
    /// - mode: plain-四舍五入；down-向下取整；up-向上取整；bankers-在四舍五入的基础上，加上末尾数为5时，变成偶数的规则（1.25->1.2; 1.35->1.4）
    ///   - decimal: 精度
    func subtracting(_ b: String, withRoundingMode mode: NSDecimalNumber.RoundingMode, withDecimal decimal: Int) -> String {
        let numbers = prepareNumbersAndHandler(self, b, mode, decimal)
        let result = numbers.0.subtracting(numbers.1, withBehavior: numbers.2)
        return result.stringValue.calculateResultValid()
    }
    
    /// 乘
    /// - Parameters:
    /// - mode: plain-四舍五入；down-向下取整；up-向上取整；bankers-在四舍五入的基础上，加上末尾数为5时，变成偶数的规则（1.25->1.2; 1.35->1.4）
    ///   - decimal: 精度
    func multiplying(by b: String, withRoundingMode mode: NSDecimalNumber.RoundingMode, withDecimal decimal: Int) -> String {
        let numbers = prepareNumbersAndHandler(self, b, mode, decimal)
        let result = numbers.0.multiplying(by: numbers.1, withBehavior: numbers.2)
        return result.stringValue.calculateResultValid()
    }
    
    /// 除
    /// - Parameters:
    ///   - mode: plain-四舍五入；down-向下取整；up-向上取整；bankers-在四舍五入的基础上，加上末尾数为5时，变成偶数的规则（1.25->1.2; 1.35->1.4）
    ///   - decimal: 精度
    func dividing(by b: String, withRoundingMode mode: NSDecimalNumber.RoundingMode, withDecimal decimal: Int) -> String {
        let numbers = prepareNumbersAndHandler(self, b, mode, decimal)
        let result = numbers.0.dividing(by: numbers.1, withBehavior: numbers.2)
        return result.stringValue.calculateResultValid()
    }
    
    /// 大于
    func isGreater(than b: String) -> Bool {
        let numbers = prepareNumbers(self, b)
        let comparisonResult = numbers.0.compare(numbers.1)
        switch comparisonResult {
        case .orderedDescending:
            return true
        default:
            return false
        }
    }
    
    /// 比较
    func compare(to b: String) -> ComparisonResult {
        let numbers = prepareNumbers(self, b)
        return numbers.0.compare(numbers.1)
    }
    
    /// 准备数据
    /// - Parameters:
    ///   - a: 第一个数字
    ///   - b: 第二个数字
    ///   - mode: 取舍
    ///   - decimal: 精度
    private func prepareNumbersAndHandler(_ a: String, _ b: String, _ mode: NSDecimalNumber.RoundingMode, _ decimal: Int) -> (NSDecimalNumber, NSDecimalNumber, NSDecimalNumberHandler) {
        
        let numbers = prepareNumbers(a, b)
        let _decimal: Int16 = decimal.validateDecimal
        
        let handler = NSDecimalNumberHandler(roundingMode: mode, scale: _decimal, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        
        return (numbers.0, numbers.1, handler)
    }
    
    /// 准备数据
    /// - Parameters:
    ///   - a: 第一个数字
    ///   - b: 第二个数字
    private func prepareNumbers(_ a: String, _ b: String) -> (NSDecimalNumber, NSDecimalNumber) {
        
        let number_a = NSDecimalNumber(string: a)
        let number_b = NSDecimalNumber(string: b)
        
        return (number_a, number_b)
    }
    
    private func calculateResultValid() -> String {
        if self == "NaN" {
            debugPrint("calculate error - NaN")
            return "0"
        } else {
            return self
        }
    }
}

fileprivate extension Int {
    var validateDecimal: Int16 {
        var _decimal: Int16 = 0
        if self > Int16.max {
            _decimal = Int16.max
        } else if self <= 0 {
            _decimal = 0
        } else {
            _decimal = Int16(self)
        }
        return _decimal
    }
}

fileprivate extension String {
    var withoutSpacesAndNewLines: String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
}
