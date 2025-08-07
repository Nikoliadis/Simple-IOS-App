import  SwiftUI

struct  ContentView: View {
    @State private var display = "0"
    @State private var currentNumber: Double = 0
    @State private var previousNumber: Double = 0
    @State private var operation: String? = nil
    @State private var isTyping = false
    @State private var memory: Double = 0
    @State private var history: [String] = []

    let buttons: [[String]] = [
        ["MC", "MR", "M+", "M-"],
        ["⌫", "C", "÷", "×"],
        ["7", "8", "9", "+"],
        ["4", "5", "6", "="],
        ["1", "2", "3", "±"],
        ["0", ".", "%", ""]
    ]

    
        playClickSound()
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

    var audioPlayer: AVAudioPlayer?

    func playClickSound() {
        guard let url = Bundle.main.url(forResource: "click", withExtension: "wav") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
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
                case "+": let result = previousNumber + currentNumber
                display = String(result)
                history.append("\(previousNumber) + \(currentNumber) = \(result)")
if display.hasSuffix(".0") {
            display = String(display.dropLast(2))
        }
                case "−": let result = previousNumber - currentNumber
                display = String(result)
                history.append("\(previousNumber) - \(currentNumber) = \(result)")
if display.hasSuffix(".0") {
            display = String(display.dropLast(2))
        }
                case "×": let result = previousNumber * currentNumber
                display = String(result)
                history.append("\(previousNumber) × \(currentNumber) = \(result)")
if display.hasSuffix(".0") {
            display = String(display.dropLast(2))
        }
                case "÷":
                    if currentNumber == 0 {
                    display = "Error"
                } else {
                    let result = previousNumber / currentNumber
                    display = String(result)
                    history.append("\(previousNumber) ÷ \(currentNumber) = \(result)")
                }
                

        case "M+":
            if let value = Double(display) {
                memory += value
            }
        case "M-":
            if let value = Double(display) {
                memory -= value
            }
        case "MR":
            display = String(memory)
            isTyping = true
        case "MC":
            memory = 0
        case "⌫":
            if isTyping && !display.isEmpty {
                display.removeLast()
                if display.isEmpty { display = "0"; isTyping = false }
            }
        case "±":
            if let value = Double(display) {
                display = String(-value)
if display.hasSuffix(".0") {
            display = String(display.dropLast(2))
        }
            }
        case "%":
            if let value = Double(display) {
                display = String(value / 100)
if display.hasSuffix(".0") {
            display = String(display.dropLast(2))
        }
            }
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
        

        case "M+":
            if let value = Double(display) {
                memory += value
            }
        case "M-":
            if let value = Double(display) {
                memory -= value
            }
        case "MR":
            display = String(memory)
            isTyping = true
        case "MC":
            memory = 0
        case "⌫":
            if isTyping && !display.isEmpty {
                display.removeLast()
                if display.isEmpty { display = "0"; isTyping = false }
            }
        case "±":
            if let value = Double(display) {
                display = String(-value)
if display.hasSuffix(".0") {
            display = String(display.dropLast(2))
        }
            }
        case "%":
            if let value = Double(display) {
                display = String(value / 100)
if display.hasSuffix(".0") {
            display = String(display.dropLast(2))
        }
            }
        default:
            break 
            
        }
    }
    
}

var body: some View {
    GeometryReader { geometry in
    VStack(spacing: 12) {
        Spacer()
        if !history.isEmpty {
                ScrollView {
                    ForEach(history.reversed(), id: \.self) { entry in
                        Text(entry).font(.caption).foregroundColor(.secondary).frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }.frame(height: 100)
            }
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
                            .frame(width: geometry.size.width / 5 - 16, height: geometry.size.width / 5 - 16)
                            .scaleEffect(isTyping ? 0.95 : 1.0)
                            .animation(.spring(), value: isTyping)
                            .background(Color(UIColor.secondarySystemBackground))
                            .foregroundColor(Color.primary)
                            .cornerRadius(35)
                    }
                }
            }
        }
    }
    .padding()
}
