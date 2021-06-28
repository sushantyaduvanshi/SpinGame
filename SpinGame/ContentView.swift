//
//  ContentView.swift
//  SpinGame
//
//  Created by Sushant Yadav on 02/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var credits = 1000
    @State private var images = ["star","apple","cherry"]
    @State private var image1 = "star"
    @State private var image2 = "apple"
    @State private var image3 = "cherry"
    @State private var animationValue = 0.0
    @State private var spinButtonDisable = false
    @State private var matchFound = true
    @State private var scaleValue:CGFloat = 1.0
    @State private var buttonPressedCount = 0
    
    var body: some View {
        
        ZStack {
            
            VStack{
                
                Spacer()
                
                Text("SwiftUI Slots!")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Credits: \(credits)")
                
                Spacer()
                
                HStack{
                    
                    Image(image1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotation3DEffect(
                            .degrees(animationValue),
                            axis: (x: 1.0, y: 0.0, z: 0.0)
                            )
                    
                    Image(image2)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotation3DEffect(
                            .degrees(animationValue),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                        .scaleEffect(scaleValue)
                        .zIndex(1.0)
                        .onChange(of: buttonPressedCount, perform: { value in
                            scaleEffect()
                        })
                    
                    Image(image3)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotation3DEffect(
                            .degrees(animationValue),
                            axis: (x: 0.0, y: 0.0, z: 1.0)
                            )
                        .transition(.scale(scale: 2.0))
                    
                }
                
                Spacer()
                
                Button(action: {
                    spinButtonDisable = true
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        animationValue = 360.0 * 2.0
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                            randomizeImage()
                            calculateCredits()
                            DispatchQueue.main.asyncAfter(deadline: .now() + ( image1 == image2 && image2 == image3 ? 2.0 : 0.3 ) ) {
                                animationValue = 0.0
                                spinButtonDisable = false
                            }
                        }
                    }
                }){
                    Text("Spin")
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .frame(width: 120.0, height: 40.0)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.red/*@END_MENU_TOKEN@*/)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                }
                .disabled(spinButtonDisable)
                
                Spacer()
                
            }
            
        }
        
    }
    
    func randomizeImage(){
        
        image1 = images.randomElement()!
        image2 = images.randomElement()!
        image3 = images.randomElement()!
        buttonPressedCount += 1
        
    }
    
    func calculateCredits(){
        
        if(image1 == image2 && image2 == image3){
            credits += 100
            matchFound = true
        }
        else{
            credits -= 10
        }
        
    }
    
    func scaleEffect(){
        if(image1 == image2 && image2 == image3){
            withAnimation(Animation.easeInOut(duration: 1.0)) {
                scaleValue = 6.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(Animation.easeInOut(duration: 1.0)) {
                    scaleValue = 1.0
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
