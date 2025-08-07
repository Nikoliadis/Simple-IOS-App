import  SwiftUI

struct  ContentView: View {
    @State private var display = "0"
    @State private var currentNumber: Double = 0
    @State private var previousNumber: Double = 0
    @State private var operation: String? = nil
    @State private var isTyping = false

    let buttons: [[String]] = [
        ["C", "÷", "×", "−"],
        ["7", "8", "9", "+"],
        ["4", "5", "6", "="],
        ["1", "2", "3", ""],
        ["0", ".", "", ""]
    ]

    func buttonTapped(_ symbol: String) {
        switch  symbol {
        case "0"..."9", ".":
            if isTyping {
                display += symbol
            }   else {
                display = symbol
                isTyping = true
            }
        case "+", "−", "×", "÷":
            operation = symbol
            previousNumber = Double(display) ?? 0
            isTyping = false
        case "=":
            currentNumber = Double(display) ?? 0
            if let op = operation {
                switch op {
                case "+": display = String(previousNumber + currentNumber)
                case "−": display = String(previousNumber - currentNumber)
                case "×": display = String(previousNumber * currentNumber)
                case "÷":
                    display = currentNumber == 0 ? "Error" : String(previousNumber / currentNumber)
                default: break
                }
            }
            isTyping = false
        case "C":
            display = "0"
            currentNumber = 0
            previousNumber = 0
            operation = nil
            isTyping = false
        default:
            break 
            
        }
    }
    
}