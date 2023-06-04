//
//  PostReviewView.swift
//  AllMovies
//
//  Created by user232715 on 4/30/23.
//

import SwiftUI

struct PostReviewView: View {
    @State var text : String = ""
    var body: some View {
        VStack{
            Text("Write a Review: ").font(.title)
                .padding(.leading,10)
            TextField("Review", text: $text, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .padding()
            HStack{
                Spacer()
                Button(action: {
                
                            }){
                                Text("Post Review")
                            }.padding()
                            .foregroundColor(.red).underline()
            }
            Spacer()
        }
//        VStack(spacing : 15){
//            Text("Write a review:").font(.title)
//            Spacer()
//            ZStack{
//                Color.red
//                    .opacity(0.2)
//                MultiLineTextField(text: $text)
//            }
//            Button(action: {
//
//            }){
//                Text("Post Review").padding()
//            }.background(Color.red).opacity(0.7)
//             .foregroundColor(.white)
//             .clipShape(Rectangle())
//             .cornerRadius(10)
//        }.padding()
    }
}

struct PostReviewView_Previews: PreviewProvider {
    static var previews: some View {
        PostReviewView()
    }
}

//
//struct MultiLineTextField : UIViewRepresentable {
//    func makeCoordinator() -> Coordinator {
//        return MultiLineTextField.Coordinator(parent1: self)
//    }
//    @Binding var text : String
//    func makeUIView(context: UIViewRepresentableContext<MultiLineTextField>) -> UITextView{
//        let textview = UITextView()
//        textview.isEditable = true
//        textview.isUserInteractionEnabled = true
//        textview.isScrollEnabled = true
//        textview.textColor = .gray
//        textview.font = .systemFont(ofSize: 20)
//        return textview
//    }
//
//    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTextField>) {
//
//    }
//
//    class Coordinator : NSObject, UITextViewDelegate{
//
//        var parent : MultiLineTextField
//
//        init(parent1 : MultiLineTextField){
//            parent = parent1
//        }
//
//        func textviewDidChange(_ textview : UITextView){
//            self.parent.text = textview.text
//        }
//        func textviewDidBeginEditing(_ textview : UITextView){
//            textview.text = ""
//        }
//    }
//
//}
//
    
