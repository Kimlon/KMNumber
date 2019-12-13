# KMNumber
calculate
### DESC
KMNumber is a library that solves the calculation accuracy problem of floating-point types. It is easy to use and welcomes everyone.
### CocoPods
`pod 'KMNumber'`
### How to use
You can use operator +-* /, default rounding:
```
let n1 = KMNumber("100.00100100100")
let n11 = KMNumber("1.1101101101")
let result1 = n1 + n11 
let result2 = n1 - n11
let result3 = n1 * n11
let result4 = n1 / n11
```
or you can:
```
let n1 = KMNumber("100.00100100100")
let n11 = KMNumber("1.1101101101")
let result1 = n1.calculate(operator: .add, aNumber: n11)
let result2 = n1.calculate(operator: .subtract, aNumber: n11)
let result3 = n1.calculate(operator: .multiply, aNumber: n11)
let result4 = n1.calculate(operator: .divide, aNumber: n11)
```
and:
```
let n1 = KMNumber("100.00100100100")
let n11 = KMNumber("1.1101101101")
let result1 = n1.calculate(operator: .add, aNumber: n11, roundingMode: .down, decimal: 5)
```
