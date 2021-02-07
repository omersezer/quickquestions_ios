//
//  QuizView.swift
//  quickquestions_ios
//
//  Created by Omer Sezer on 16.11.2020.
//

import SwiftUI

struct QuizView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm: QuizViewModel
    
    init(category: CategoryModel) {
        vm = QuizViewModel(category: category)
    }
    
    var body: some View {
        ZStack {
            VStack{
                Color.primaryColor
                    .cornerRadius(40, corners: [.bottomLeft, .bottomRight])
                    .ignoresSafeArea(.all)
                    .frame(height: 180)
                    .overlay(
                        Text(vm.appearedQuestions?.question ?? "")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.title2)
                    )
                
                Spacer()
                
                AnswersView(vm: vm)
                
                Button(action: {
                    vm.onSubmitClicked()
                }, label: {
                    HStack {
                        Spacer()
                        Text("SUBMIT")
                            .padding()
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                })
                .background(Color.primaryColor)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .alert(isPresented: $vm.isAlertPresented) {
                    Alert(title: Text("Uyarı"), message: Text("Lütfen bir seçim yapınız."), dismissButton: Alert.Button.default(Text("Tamam"), action: {
                        vm.hideAlert()
                    }))
                }
                Spacer()
            }
            .alert(isPresented: $vm.isResultAlertPresented) {
                Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: Alert.Button.default(Text("Tamam"), action: {
                    self.presentationMode.wrappedValue.dismiss()
                }))
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let category = CategoryModel(id: "1", name: "Test Category", questions: [QuestionModel(answer: "a", id: "1", question: "Test Question", option_1: "Test Option 1", option_2: "Test Option 2", option_3: "Test Option 3", option_4: "Test Option 4")])
        QuizView(category: category)
    }
}

struct AnswersView: View {
    
    @ObservedObject var vm: QuizViewModel
    
    var body: some View {
        
        // MARK - Option 1
        HStack {
            Color(.systemGray6)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .overlay(
                    Text("A")
                        .foregroundColor(vm.colorOption1)
                )
            Text(vm.appearedQuestions?.option_1 ?? "")
            Spacer()
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(vm.colorOption1, lineWidth: 1)
                .shadow(radius: 4)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .foregroundColor(vm.colorOption1)
        .onTapGesture {
            vm.onOptionClicked(index: 0)
        }
        
        // MARK - Option 2
        HStack {
            Color(.systemGray6)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .overlay(
                    Text("B")
                        .foregroundColor(vm.colorOption2)
                )
            Text(vm.appearedQuestions?.option_2 ?? "")
            Spacer()
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(vm.colorOption2, lineWidth: 1)
                .shadow(radius: 4)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .foregroundColor(vm.colorOption2)
        .onTapGesture {
            vm.onOptionClicked(index: 1)
        }
        
        // MARK - Option 3
        HStack {
            Color(.systemGray6)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .overlay(
                    Text("C")
                        .foregroundColor(vm.colorOption3)
                )
            Text(vm.appearedQuestions?.option_3 ?? "")
            Spacer()
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(vm.colorOption3, lineWidth: 1)
                .shadow(radius: 4)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .foregroundColor(vm.colorOption3)
        .onTapGesture {
            vm.onOptionClicked(index: 2)
        }
        
        // MARK - Option 4
        HStack {
            Color(.systemGray6)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .overlay(
                    Text("D")
                        .foregroundColor(vm.colorOption4)
                )
            Text(vm.appearedQuestions?.option_4 ?? "")
            Spacer()
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(vm.colorOption4, lineWidth: 1)
                .shadow(radius: 4)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .foregroundColor(vm.colorOption4)
        .onTapGesture {
            vm.onOptionClicked(index: 3)
        }
    }
}
