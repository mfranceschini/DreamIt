//
//  ContentView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-09.
//

import SwiftUI
import SystemConfiguration
import LocalAuthentication

enum TargetView {
    case SignUp
    case Login
    case None
}

var flags = SCNetworkReachabilityFlags()

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var isModalPresented = false
    @State var targetView: TargetView = TargetView.None
    @State private var currentHeight: CGFloat = 0.0
    @State private var movingOffset: CGFloat = 0.0
    @State var isLoggedIn = false
    @State var isConnected: Bool = false
    
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnections = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isReachable && (!needsConnections || canConnectWithoutInteraction)
    }
    
    private func authenticate() {
        
        //first, need to check if the user has logged in before, so the info is saved locally
        
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        withAnimation {
                            isLoggedIn = true
                        }
                    } else {
                        // there was a problem
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
    
    var body: some View {
        if isLoggedIn {
            TabbarView(newListingPresented: false)
                .transition(.move(edge: .trailing))
        }
        else {
            ZStack {
                VStack {
                    ZStack(alignment: .top) {
                        Color.clear
                        VStack(alignment: .center) {
                            Image("DreamItLogo_inApp")
                                .resizable()
                                .modifier(AppLogoStyle())
                            Text("DreamIt")
                                .fontWeight(.bold)
                                .kerning(2.0)
                                .modifier(LandingViewTitleStyle())
                        }
                    }
                    .padding(.top, 20)
                    
                    // Validate if has internet connection
                    if self.isConnected {
                        VStack(alignment: .center) {
                            if !self.isModalPresented {
                                Button("Sign Up") {
                                    withAnimation(.spring(dampingFraction: 0.7)) {
                                        self.isModalPresented = true
                                        self.targetView = TargetView.SignUp;
                                        self.currentHeight = 0.0
                                        self.movingOffset = 0.0
                                    }
                                }
                                .buttonStyle(SignUpButtonStyle())
                                
                                Button("Login") {
                                    withAnimation(.spring(dampingFraction: 0.7)) {
                                        self.isModalPresented = true
                                        self.targetView = TargetView.Login;
                                        self.currentHeight = 0.0
                                        self.movingOffset = 0.0
                                    }
                                }
                                .buttonStyle(LoginButtonStyle())
                            }
                        }
                        .padding(.bottom, 70)
                    }
                    else {
                        VStack {
                            Text("⚠️")
                                .font(.system(size: 60))
                                .shadow(radius: 15)
                            Text("To use the app is necessary an Internet Connection")
                                .font(.title3)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            Spacer()
                        }
                    }
                }
                .blur(radius: self.isModalPresented ? 3.0 : 0.0)
                .padding()
                .onTapGesture {
                    if self.isModalPresented {
                        withAnimation {
                            self.isModalPresented = false
                        }
                    }
                }
                .transition(.move(edge: .top))
                
                CustomSheetView(currentHeight: self.$currentHeight, movingOffset: self.$movingOffset, isShowing: self.$isModalPresented, targetView: self.$targetView, isLoggedIn: self.$isLoggedIn)
                    .transition(.move(edge: .bottom))
            }
            .background(
                LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? Constants.background.reversed() : Constants.background), startPoint: .bottom, endPoint: .top)
            )
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                SCNetworkReachabilityGetFlags(self.reachability!, &flags)
                self.isConnected = isNetworkReachable(with: flags)
                authenticate()
            }
            .onTapGesture {
                self.isConnected = isNetworkReachable(with: flags)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
