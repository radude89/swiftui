//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Radu Dan on 02/09/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI
import CoreData

// MARK: - UserDetailView
struct UserDetailView: View {
    let user: UserC
    let allUsers: FetchedResults<UserC>
    
    var body: some View {
        Form {
            UserDetailPersonalInfoSection(user: user)
            UserDetailAboutSection(user: user)
            UserDetailFriendsSection(user: user, allUsers: allUsers)
            UserDetailTagsSection(user: user)
            UserDetailDataSection(user: user)
        }
        .navigationBarTitle(Text("\(user.wrappedName)"), displayMode: .inline)
    }
}

// MARK: - UserDetailInfoView
struct UserDetailInfoView: View {
    let name: String
    let value: String
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(value)
                .fontWeight(.light)
                .font(.callout)
        }
    }
}

// MARK: - Section Personal Info
struct UserDetailPersonalInfoSection: View {
    let user: UserC
    
    var body: some View {
        Section(header: Text("Personal Information".uppercased())) {
            UserDetailInfoView(
                name: "Name",
                value: user.wrappedName
            )
            
            UserDetailInfoView(
                name: "Email",
                value: user.wrappedEmail
            )
            
            UserDetailInfoView(
                name: "Age",
                value: "\(user.age) years old"
            )
            
            UserDetailInfoView(
                name: "Address",
                value: user.wrappedAddress
            )
            
            UserDetailInfoView(
                name: "Company",
                value: user.wrappedCompany
            )
        }
    }
}

// MARK: - Section About
struct UserDetailAboutSection: View {
    let user: UserC
    
    var body: some View {
        Section(header: Text("About".uppercased())) {
            Text(user.wrappedAbout)
        }
    }
}

// MARK: - Section Friends
struct UserDetailFriendsSection: View {
    let user: UserC
    let allUsers: FetchedResults<UserC>
    
    var body: some View {
        Section(header: Text("Friends".uppercased())) {
            ForEach(0..<user.friendsArray.count) { index in
                if self.friendAsUser(self.user.friendsArray[index]) != nil {
                    NavigationLink(
                        destination: UserDetailView(
                            user: self.friendAsUser(self.user.friendsArray[index])!,
                            allUsers: self.allUsers
                        )
                    ) {
                        Text("\(self.user.friendsArray[index].wrappedName)")
                    }
                } else {
                    Text(self.user.friendsArray[index].wrappedName)
                }
            }
        }
    }
    
    private func friendAsUser(_ friend: FriendC) -> UserC? {
        allUsers.first { friend.id == $0.id }
    }
}

// MARK: - Section Tags
struct UserDetailTagsSection: View {
    let user: UserC
    
    var body: some View {
        Section(header: Text("Tags".uppercased())) {
            ForEach(0..<user.tagsArray.count) { index in
                Text("\(self.user.tagsArray[index].wrappedName)")
            }
        }
    }
}

// MARK: - Section Data
struct UserDetailDataSection: View {
    let user: UserC
    
    var body: some View {
        Section(header: Text("Data".uppercased())) {
            Text("\(user.isActive ? "Active user" : "Inactive user")")
                .foregroundColor(user.isActive ? Color.green : Color.orange)
                .fontWeight(user.isActive ? .bold : .light)
            
            UserDetailInfoView(
                name: "Registered on",
                value: user.formattedRegisteredDate ?? "N/A"
            )
            
            Text(user.wrappedID.uuidString)
                .fontWeight(.ultraLight)
                .font(.footnote)
        }
    }
}
