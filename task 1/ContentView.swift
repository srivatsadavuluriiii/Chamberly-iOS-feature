import SwiftUI
struct ContentView: View {
    @EnvironmentObject var messageFieldVM: MessageFieldViewModel
    @FocusState var isTextFieldFocused: Bool
    @State private var newCommentText: String = ""
    @State private var replyText = "default"
    @State private var selectedCommentIndex: Int?

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.968626678, green: 0.9686279893, blue: 0.9987213016, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Swipe right to start chatting!")
                    .font(.footnote)
                    .fontWeight(.medium)
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(LinearGradient(colors: [Color(#colorLiteral(red: 0.6588120461, green: 0.6588326097, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1))], startPoint: .top, endPoint: .bottom))
                    .frame(width: 330, height: 130)
                    .overlay(
                        Text("How to overcome daily anxiety?")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.semibold)
                    )
                
                HStack (spacing: 20){
                    HStack(spacing: 5){
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        
                        Text("\(messageFieldVM.totalLikes)")
                            .foregroundColor(.red)
                    }
                    
                    HStack (spacing: 5){
                        Image(systemName: "message")
                            .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
                        Text("\(messageFieldVM.replyContent.count)")
                            .foregroundColor(Color(#colorLiteral(red: 0.5411589146, green: 0.5411903262, blue: 0.990190804, alpha: 1)))
                    }
                }
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(Array(messageFieldVM.posts.values), id: \.self) { post in
                        PostCardView(selectedCommentIndex: $selectedCommentIndex, post: .constant(post))
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .onTapGesture {
                                // Update selectedCommentIndex or replyText if needed
                                selectedCommentIndex = 1 // Example update
                                replyText = post.authorName // Example update
                            }
                    }
                }

                .frame(width: 350.0)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: 330.0, height: 80)
                    .overlay(
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(Color(#colorLiteral(red: 0.4784063697, green: 0.4784510732, blue: 1, alpha: 1)))
                                .padding(.horizontal, 20)
                            
                            TextField("Reply to \(replyText)", text: $messageFieldVM.text)
                                .opacity(0.6)
                                .padding(.horizontal)
                                .focused($isTextFieldFocused)
                            Button {
                                messageFieldVM.addNewReply(authorName: replyText)
                            } label: {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.4784063697, green: 0.4784510732, blue: 1, alpha: 1)))
                                    .padding(.horizontal, 30)
                            }
                        }
                    )
            }
        }
        .onTapGesture { isTextFieldFocused = false}
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(MessageFieldViewModel())
    }
}