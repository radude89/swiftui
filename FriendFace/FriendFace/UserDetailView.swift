//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Radu Dan on 02/09/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

// MARK: - UserDetailView
struct UserDetailView: View {
    let user: User
    let allUsers: [User]
    let name: String?
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information".uppercased())) {
                UserDetailInfoView(
                    name: "Name",
                    value: user.name
                )
                
                UserDetailInfoView(
                    name: "Email",
                    value: user.email
                )
                
                UserDetailInfoView(
                    name: "Age",
                    value: "\(user.age) years old"
                )
                
                UserDetailInfoView(
                    name: "Address",
                    value: user.address
                )
                
                UserDetailInfoView(
                    name: "Company",
                    value: user.company
                )
            }
            
            Section(header: Text("About".uppercased())) {
                Text(user.about)
            }
            
            Section(header: Text("Friends".uppercased())) {
                ForEach(user.friends) { friend in
                    if self.friendAsUser(friend) != nil {
                        NavigationLink(
                            destination: UserDetailView(
                                user: self.friendAsUser(friend)!,
                                allUsers: self.allUsers,
                                name: friend.name
                            )
                        ) {
                            Text(friend.name)
                        }
                    } else {
                        Text(friend.name)
                    }
                }
            }
            
            Section(header: Text("Tags".uppercased())) {
                ForEach(0..<user.tags.count) { index in
                    Text("\(self.user.tags[index])")
                }
            }
            
            Section(header: Text("Data".uppercased())) {
                Text("\(user.isActive ? "Active user" : "Inactive user")")
                    .foregroundColor(user.isActive ? Color.green : Color.orange)
                    .fontWeight(user.isActive ? .bold : .light)
                
                UserDetailInfoView(
                    name: "Registered on",
                    value: user.formattedRegisteredDate ?? "N/A"
                )
                
                Text(user.id.uuidString)
                    .fontWeight(.ultraLight)
                    .font(.footnote)
            }
        }
        .navigationBarTitle(Text("\(user.name)"), displayMode: .inline)
    }
    
    private func friendAsUser(_ friend: Friend) -> User? {
        allUsers.first { friend.id == $0.id }
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

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User.demoUser,
                       allUsers: [],
                       name: nil)
    }
}
