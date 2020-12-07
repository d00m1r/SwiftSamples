//
//  ContentView.swift
//  MySwiftSamples
//
//  Created by Damasya on 10/31/20.
//

import SwiftUI
struct CircleDiagram:Shape, Animatable {
    var animatableData: CGFloat{
        get{ userInput }
        set{ userInput = newValue}
    }
    var userInput: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2, startAngle: .radians(1.5 * .pi), endAngle: .init(radians: 2 * Double.pi * Double(userInput)/100 + 1.5 * Double.pi), clockwise: false)
        return path
    }
}
struct DiagramsView: View {
    @State private var pickerItem = true
    @State var userInput: CGFloat = 50
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                Text("Analitics Diagrams")
                    .font(.system(size: 25))
                    .fontWeight(.light)
                withAnimation{
                Picker(selection: $pickerItem, label: Text("some")) {
                    Text("rectangle").tag(true)
                    Text("circle").tag(false)
                }.pickerStyle(SegmentedPickerStyle()).padding([.leading, .bottom, .trailing], 40)
                }
                if pickerItem{
                    RectangleDiagramView(width: geometry.size.width/6, height: 250, color: Color.green, userInput: self.userInput)
                        //.transition(.move(edge: .leading))
                        //.animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                }
                if !pickerItem{
                    CircleDiagramView(width: 40, color: Color.green, userInput: self.userInput)
                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        //.transition(.move(edge: .trailing))
                        //.animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                }
                
                Spacer()
                Slider(value: self.$userInput, in: 0...100)
                Button(action: {
                    withAnimation(.spring(response: 1,
                                          dampingFraction: 0.5,
                                          blendDuration: 0.5)){
                        self.userInput = 50
                    }
                }){
                    Text("set to 50")
                }
            }.padding()
        }
    }
    
}

struct CircleDiagramView: View{
    let width: CGFloat
    let color: Color
    var userInput: CGFloat
    
    var body: some View{
        VStack{
            ZStack(alignment: .center){
                CircleDiagram(userInput: 100)
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: width,
                                                           lineCap: .butt,
                                                           lineJoin: .round,
                                                           miterLimit: 0,
                                                           dash: [],
                                                           dashPhase: 0))
                    .opacity(0.25)
                CircleDiagram(userInput: self.userInput)
                    .stroke(color, style: StrokeStyle(lineWidth: width,
                                                      lineCap: .butt,
                                                      lineJoin: .round,
                                                      miterLimit: 0,
                                                      dash: [],
                                                      dashPhase: 0))
                    .opacity(0.7)
                Text("\(Int(userInput))%").foregroundColor(.gray)
            }
        }
    }
}
struct RectangleDiagramView: View {
    let width: CGFloat
    let height: CGFloat
    let color: Color
    var userInput: CGFloat
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottom){
                RoundedRectangle(cornerRadius: 5.0)
                    .fill(Color.gray)
                    .opacity(0.25)
                    .frame(width: self.width, height: self.height)
                RoundedRectangle(cornerRadius: 5.0)
                    .fill(self.color)
                    .opacity(0.7)
                    .frame(width: self.width, height: 2.5 * userInput)
            }
            Text("\(Int(userInput))%").foregroundColor(.gray)
        }
    }
}

//@propertyWrapper
//struct Clamping<Value: Comparable> {
//    var value: Value
//    let range: ClosedRange<Value>
//
//    init(initialValue value: Value, _ range: ClosedRange<Value>) {
//        precondition(range.contains(value))
//        self.value = value
//        self.range = range
//    }
//
//    var wrappedValue: Value {
//        get { value }
//        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
//    }
//}

struct DiagramsView_Previews: PreviewProvider {
    static var previews: some View {
        DiagramsView()
    }
}


