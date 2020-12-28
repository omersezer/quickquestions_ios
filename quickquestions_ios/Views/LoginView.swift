//
//  LoginView.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 1.11.2020.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var vm: LoginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        Spacer()
                        VStack {
                            // Sign in & sign up buttons
                            LoginHeaderView(vm: vm)
                            // Quick Question Text
                            Text("Quick Questions")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 20)
                            // Email & Password
                            LoginContentView(vm: vm)
                        }
                        // Sign In & Forgot Password
                        LoginBottomButtonsView(vm: vm)
                        Spacer()
                    }
                    .animation(.linear)
            )
            if (vm.isLoading) {
                LoadingView(isLoading: vm.isLoading)
            }
        }
        .alert(isPresented: $vm.isShowingAlert) {
            Alert(title: Text("Hata"), message: Text(vm.alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LoginHeaderView: View {
    
    @ObservedObject var vm: LoginViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack {
                Button(action: {
                    vm.onChangeContent(isSignIn: true)
                }, label: {
                    Text("SIGN IN")
                        .foregroundColor(vm.isSignIn ? .white : .gray)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                })
                Rectangle()
                    .frame(height: 1, alignment: .center)
                    .foregroundColor(vm.isSignIn ? .white : .gray)
            }
            .fixedSize()
            .animation(.linear)
            
            VStack {
                Button(action: {
                    vm.onChangeContent(isSignIn: false)
                }, label: {
                    Text("SIGN UP")
                        .foregroundColor(vm.isSignIn ? .gray : .white)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                })
                Rectangle()
                    .frame(height: 1, alignment: .center)
                    .foregroundColor(vm.isSignIn ? .gray : .white)
            }
            .fixedSize()
            .animation(.linear)
            Spacer()
        }
    }
}

struct LoginContentView: View {
    
    @ObservedObject var vm: LoginViewModel
    
    var body: some View {
        VStack {
            // Email
            HStack {
                TextField("Email", text: $vm.emailText)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.leading, 24)
            }
            .padding(.all, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                    .overlay(
                        HStack {
                            Image(systemName: "mail.fill")
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .foregroundColor(.gray)
                    )
            )
            
            // Password
            HStack {
                SecureField("Password", text: $vm.passwordText)
                    .padding(.leading, 24)
            }
            .padding(.all, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                    .overlay(
                        HStack {
                            Image(systemName: "lock.fill")
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "eye.fill")
                                    .padding(.vertical)
                            })
                        }
                        .padding(.horizontal, 16)
                        .foregroundColor(.gray)
                    )
            )
            
            HStack {
                SecureField("Re-Password", text: $vm.rePasswordText)
                    .padding(.leading, 24)
            }
            .padding(.all, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                    .overlay(
                        HStack {
                            Image(systemName: "lock.fill")
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "eye.fill")
                                    .padding(.vertical)
                            })
                        }
                        .padding(.horizontal, 16)
                        .foregroundColor(.gray)
                    )
            )
            .opacity(vm.isSignIn ? 0 : 1)
            .frame(width: vm.isSignIn ? .zero : .none, height: vm.isSignIn ? .zero : .none, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .animation(.linear)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(radius: 10)
    }
}

struct LoginBottomButtonsView: View {
    
    @ObservedObject var vm: LoginViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Button( action: {}, label: {
                Text("FORGOT PASSWORD?")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
            })
            .opacity(vm.isSignIn ? 1.0 : 0.0)
            
            Button(action: {
                vm.signUp()
            }, label: {
                Text(vm.isSignIn ? "SIGN IN" : "SIGN UP")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryColor)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(Color.white)
                
            })
            .cornerRadius(12)
            .shadow(radius: 6)
            .padding(.all)
            .fullScreenCover(isPresented: $vm.isPresented, content: {
                MainView()
            })
            
        }
    }
}
