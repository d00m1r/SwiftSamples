//
//  DefaultShapesTest.swift
//  MySwiftSamples
//
//  Created by Damasya on 10/31/20.
//

import SwiftUI

struct DefaultShapesTest: View {
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Circle()
                .foregroundColor(Color.white)
                .background(Color.black)
                .padding()
                .overlay(
                    Ellipse()
                        .frame(width:320, height: 150)
                )
                .offset(CGSize(width: 0.0, height:-100.0))
            Capsule()
                .fill(Color.blue)
                .frame(width: 150, height: 270)
                .overlay(RoundedRectangle(cornerSize: CGSize(width: 40, height: 40))
                            .fill(Color.red)
                            .frame(width:100,height:100))
            Text("Hello, world!")
                .border(Color.yellow)
                .padding()
                .border(Color.black)
                .offset(CGSize(width: 15.0, height: 15.0))
                .border(Color.white)
            
        }
        .foregroundColor(Color.yellow)
    }
}

struct DefaultShapes_Previews: PreviewProvider {
    static var previews: some View {
        DefaultShapesTest()
    }
}
