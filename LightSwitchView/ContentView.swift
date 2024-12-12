//
//  ContentView.swift
//  LightSwitchView
//
//  Created by Shishir_Mac on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    
    let appWidth = UIScreen.main.bounds.width
    let appHeight = UIScreen.main.bounds.height
    let animationDuration: TimeInterval = 0.35
    
    @State var xScale: CGFloat = 2
    @State var yScale: CGFloat = 0.4
    @State var yOffset: CGFloat = UIScreen.main.bounds.height * 0.8
    
    @State var isOff: Bool = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            // Light Bulb
            Circle()
                .fill(Color.yellow)
                .scaleEffect(CGSize(width: xScale, height: yScale))
                .offset(y: yOffset)
            
            // Light Text
            Text(isOff ? "Light OFF" : "Light ON")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .opacity(isOff ? 0.6 : 1.0)
                .offset(y: -appHeight / 2 + 80)
            
            // Switch Control
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(isOff ? .white : .black)
                        .font(.system(size: 24,
                                      weight: .semibold,
                                      design: .monospaced))
                    Spacer()
                        .offset(x: -12)
                    
                    Spacer()
                }
                .padding([.top, .bottom], 24)
                
                Spacer()
            }
            .offset(y: 32)
            .padding([.leading, .trailing], 24)
            
            // Switch Mechanism
            ZStack {
                Capsule(style: .continuous)
                    .foregroundColor(.gray)
                    .frame(width: 52, height: appHeight * 0.25 + 6)
                    .opacity(0.275)
                    .offset(x: appWidth / 2 - 48, y: 16)
                
                ZStack {
                    Capsule()
                        .frame(width: 3, height: self.isOff ? appHeight * 0.41 : appHeight * 0.625)
                        .foregroundColor(.white)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 42, height: 42)
                        .offset(y: self.isOff ? appHeight * 0.225 : appHeight * 0.25 + 42)
                        .onTapGesture {
                            toggleAllLight()
                        }
                }
                .offset(x: appWidth / 2 - 48, y: -appHeight / 2)
                .frame(height: 0, alignment: .top)
            }
            .animation(.spring(dampingFraction: 0.65).speed(1.25), value: isOff)
        }
    }
    
    // Toggle All Light
    func toggleAllLight() {
        withAnimation(Animation.easeIn(duration: animationDuration)) {
            if isOff {
                xScale = 4
                yScale = 4
                yOffset = 0
            } else {
                xScale = 2
                yScale = 0.4
                yOffset = UIScreen.main.bounds.height * 0.8
            }
            
            isOff.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
