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

    var body: some View {
    VStack(spacing: 12) {
        Spacer()
        Text(display)
            .font(.system(size: 64))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()

        ForEach(buttons, id: \.self) { row in
            HStack(spacing: 12) {
                ForEach(row, id: \.self) { button in
                    Button(action: {
                        self.buttonTapped(button)
                    }) {
                        Text(button)
                            .font(.title)
                            .frame(width: 70, height: 70)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(35)
                    }
                }
            }
        }
    }
    .padding()
}


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

