//
//  MainView.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 1.11.2020.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var vm: MainViewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Color.primaryColor
                        .ignoresSafeArea(.all)
                        .frame(height: 320, alignment: .top)
                        .overlay(
                            VStack {
                                MainTopView(vm: vm)
                            }
                        )
                    Text("Top Quizzes")
                        .foregroundColor(.primaryColor)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    MainQuizList(vm: vm)
                    Spacer()
                }
                .fullScreenCover(isPresented: $vm.isPresentedLoginView, content: {
                    LoginView()
                })
                .fullScreenCover(isPresented: $vm.isPresentedQuizView, content: {
                    QuizView(category: vm.categories[vm.selectedCategory])
                })
            }
            .alert(isPresented: $vm.isAlertPresented) {
                Alert(title: Text("Uyarı"), message: Text(vm.alertMessage), primaryButton: Alert.Button.default(Text("Tamam"), action: {
                    vm.signOut()
                }), secondaryButton: Alert.Button.cancel(Text("Vazgeç")))
            }
//            LoadingView(isLoading: vm.isLoading)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct MainTopView: View {
    
    @ObservedObject var vm: MainViewModel
    
    var body: some View {
        Color.primaryColor
            .cornerRadius(20)
            .ignoresSafeArea(.all)
            .frame(height: 350, alignment: .leading)
            .overlay(
                VStack {
                    HStack {
                        Text("Welcome")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                        
                        Button(action: {
                            vm.onSignOutButtonClicked()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .aspectRatio(contentMode: .fit)
                        })
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        
                    }
                    Text("Highest Score: \(vm.myScore)")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(vm.categories.indices, id: \.self) { indices in
                                HStack {
                                    Text("\(vm.categories[indices].name)")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 250, height: 120, alignment: .center)
                                .padding()
                                .background(vm.categories[indices].backgroundColor)
                                .cornerRadius(16)
                                .shadow(radius: 4)
                            }
                            .padding(.leading, 10)
                        }
                        
                    }
                    .frame(height: 200)
                    
                    Spacer()
                }
            )
    }
}

struct MainQuizList: View {
    
    @ObservedObject var vm: MainViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.categories.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(vm.categories[index].name)
                                .font(.title3)
                                .foregroundColor(.primaryColor)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            vm.onStartButtonClicked(categoryIndex: index)
                        }, label: {
                            Text("START")
                                .foregroundColor(.white)
                        })
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.primaryColor)
                        .cornerRadius(4)
                        .shadow(radius: 4)
                    }
                    .padding(.vertical, 5)
                }
                .padding(.horizontal, 12)
            }
        }
    }
}
