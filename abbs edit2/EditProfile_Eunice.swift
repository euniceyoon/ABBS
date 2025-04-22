//
//  EditProfile_Eunice.swift
//  abbs edit2
//
//  Created by Eunice Yoon on 4/21/25.
//

import SwiftUI
import PhotosUI

struct EditProfile: View {
    // MARK: - State variables
    @Environment(\.presentationMode) var presentationMode
    @State private var introduction: String = ""
    @State private var selectedDate: Date = Date()
    @State private var grade: String = ""
    @State private var classType: String = ""
    @State private var race: String = ""
    @State private var gender: String = ""
    @State private var showAlert: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var showImagePicker = false
    @State private var showPhotoSourceDialog = false
    @State private var useCamera = false
    

    let grades = ["Freshman", "Sophomore", "Junior", "Senior", "Graduate Student"]
    let classTypes = ["Lecture", "Seminar", "Workshop", "Online", "In-person"]
    let races = ["Asian", "White", "Native American", "Hispanic/Latino", "Pacific Islander", "Black", "Other"]
    let genders = ["Male", "Female", "Other"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Image and Edit Button
                    VStack {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .clipped()
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                        }

                        Button("Select Profile Photo") {
                            showPhotoSourceDialog = true
                        }
                        .font(.subheadline)
                        .padding(.top, 8)
                        .confirmationDialog("Select Photo Source", isPresented: $showPhotoSourceDialog) {
                            Button("Camera") {
                                useCamera = true
                                showImagePicker = true
                            }
                            Button("Photo Library") {
                                useCamera = false
                                showImagePicker = true
                            }
                            Button("Cancel", role: .cancel) {}
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: useCamera ? .camera : .photoLibrary, selectedImage: $selectedImage)
                    }


                    // Introduction Section
                    VStack(alignment: .leading) {
                        Text("Introduction")
                            .font(.headline)
                        TextEditor(text: $introduction)
                            .frame(height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                    }
                    .padding(.horizontal)

                    // Meeting Times
                    VStack(alignment: .leading) {
                        Text("Preferred Meeting Times")
                            .font(.headline)
                        DatePicker("Select time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden()
                    }
                    .padding(.horizontal)

                    // Grade Dropdown
                    VStack(alignment: .leading) {
                        Text("Grade")
                            .font(.headline)
                        Picker("Select grade", selection: $grade) {
                            Text("Select").tag("")
                            ForEach(grades, id: \.self) { grade in
                                Text(grade).tag(grade)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.horizontal)

                    // Class Type
                    VStack {
                        Text("Type of Classes")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Picker("Select class type", selection: $classType) {
                            Text("Select").tag("")
                            ForEach(classTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)

                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Race/Ethnicity")
                                .font(.headline)
                            Picker("Select race", selection: $race) {
                                Text("Select").tag("")
                                ForEach(races, id: \.self) { race in
                                    Text(race).tag(race)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        VStack(alignment: .leading) {
                            Text("Gender")
                                .font(.headline)
                            Picker("Select gender", selection: $gender) {
                                Text("Select").tag("")
                                ForEach(genders, id: \.self) { gender in
                                    Text(gender).tag(gender)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if grade.isEmpty || classType.isEmpty || race.isEmpty || gender.isEmpty {
                            showAlert = true
                        } else {
                            print("Profile saved")
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Save")
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text("Please fill out all required fields."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    EditProfile()
}
