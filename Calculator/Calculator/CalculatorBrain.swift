//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by passionHan on 12/04/2017.
//  Copyright © 2017 www.hopechina.cc 中和黄埔. All rights reserved.
//

import UIKit

class CalculatorBrain: NSObject {

    private enum Op {
        case Operand(Double) //将操作数和Double类型关联
        case UnaryOperation(String, (Double) ->Double) //关联一元操作符和计算的函数
        case BinaryOperation(String, (Double, Double) ->Double) //关联二元操作符和计算的函数
    }
    
    private var opStack = [Op]()
    
    // 根据操作符找到对应的运算方法
    private var konwOps = [String: Op]()
    
    override init() {
        super.init()
        konwOps["+"] = Op.BinaryOperation("+", +)
        konwOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        konwOps["×"] = Op.BinaryOperation("×", *)
        konwOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        konwOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    //递归获取操作数和操作符
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            print(remainingOps)
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let opration):
                let operandOperation = evaluate(ops: remainingOps)
                if let operand = operandOperation.result {
                    return (opration(operand), operandOperation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let opt1Evaluation = evaluate(ops: remainingOps)
                if let operand1 = opt1Evaluation.result {
                    let opt2Evaluation = evaluate(ops: opt1Evaluation.remainingOps)
                    if let operand2 = opt2Evaluation.result {
                        return (operation(operand1, operand2), opt2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(ops: opStack)
        return result
    }
    
    //将操作数入栈
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = konwOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}
