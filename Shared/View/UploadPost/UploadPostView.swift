//
//  UploadPostView.swift
//  SwiftUIClass (iOS)
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import SwiftUI

struct UploadPostView: View {
    @State private var selectedImage: UIImage?
    @State private var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @Binding var navigationTabIndex: Int
    @ObservedObject var viewModel = UploadPostViewModel()
    
    var body: some View {
        VStack {
            if postImage == nil {
                Button (action: {imagePickerPresented.toggle()},
                    label: {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFill()
                        .clipped()
                        .padding(.top, 30)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.black)
                        
                }).sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                    ImagePicker(image: $selectedImage)
                })

            } else if let image = postImage {
                HStack(alignment: .top) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipped()
                    TextArea(text: $captionText, placeholder: "Enter your subtitle...")
                        .frame(height: 200)
                }.padding()
                HStack(spacing: 16){
                    Button(action: {
                        if let image = selectedImage {
                            viewModel.uploadPost(caption: captionText, image: image) {_ in
                                captionText = ""
                                postImage = nil
                                navigationTabIndex = 0
                            }
                        }
                        }) {
                        Text("Share")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 120, height: 50)
                            .foregroundColor(.white)
                    }
                    .background(Color.blue)
                    .cornerRadius(5)
                    Button(action: {
                        captionText = ""
                        postImage = nil
                        navigationTabIndex = 0
                        }) {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 120, height: 50)
                            .foregroundColor(.white)
                    }
                        .background(Color.red)
                    .cornerRadius(5)
                }.padding()
            }
            Spacer()
            
        }

    }
}

extension UploadPostView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
