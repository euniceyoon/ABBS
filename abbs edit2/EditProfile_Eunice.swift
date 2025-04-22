//
//  EditProfile_Eunice.swift
//  abbs edit2
//
//  Created by Eunice Yoon on 4/21/25.
//

import SwiftUI

struct EditProfile_Eunice: View {
    // MARK: - State variables
    @State private var introduction: String = ""
    @State private var selectedDate: Date = Date()
    @State private var grade: String = "Freshman"
    @State private var classType: String = "Lecture"
    @State private var race: String = "Asian"
    @State private var gender: String = "Female"
    
    let grades = ["Freshman", "Sophomore", "Junior", "Senior", "Graduate Student"]
    let classTypes = ["Lecture", "Seminar", "Workshop", "Online", "In-person"]
    let races = ["Asian", "White", "Native American", "Other"]
    let genders = ["Male", "Female", "Other"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Image and Edit Button
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                        
                        Button("Edit Profile") {
                            // Edit profile action
                        }
                        .font(.subheadline)
                        .padding(.top, 8)
                    }
                    .padding(.top, 10)
                    
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
                            ForEach(grades, id: \.self) { grade in
                                Text(grade)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.horizontal)
                    
                    // Class Type Dropdown
                    VStack(alignment: .leading) {
                        Text("Type of Classes")
                            .font(.headline)
                        Picker("Select class type", selection: $classType) {
                            ForEach(classTypes, id: \.self) { type in
                                Text(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.horizontal)
                    
                    // Race and Gender side-by-side
                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Race/Ethnicity")
                                .font(.headline)
                            Picker("Select race", selection: $race) {
                                ForEach(races, id: \.self) { race in
                                    Text(race)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        VStack(alignment: .leading) {
                            Text("Gender")
                                .font(.headline)
                            Picker("Select gender", selection: $gender) {
                                ForEach(genders, id: \.self) { gender in
                                    Text(gender)
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
                        // Reload action
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Save action
                    }) {
                        Text("Save")
                    }
                }
            }
        }
    }
}

#Preview {
    EditProfile_Eunice()
}
