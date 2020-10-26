//
//  MissionView.swift
//  Moonshot
//
//  Created by Radu Dan on 27/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let allMissions: [Mission]
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                        .accessibility(removeTraits: .isImage)
                    
                    Text(mission.formattedLaunchDate)
                        .font(.headline)
                        .padding()
                    
                    Text(mission.description)
                        .padding()
                    
                    ForEach(astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: missions(for: crewMember.astronaut))) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel(
                                    Text(
                                        "Astronaut \(crewMember.astronaut.name), \(crewMember.role)"
                                    )
                                )
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName),
                            displayMode: .inline)
    }
}

extension MissionView {
    init(mission: Mission,
         astronauts: [Astronaut],
         allMissions: [Mission]) {
        self.mission = mission
        self.allMissions = allMissions
        
        var matches: [CrewMember] = []
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role,
                                          astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    func missions(for astronaut: Astronaut) -> [Mission] {
        allMissions.filter { mission in
            mission.crew.first(where: { $0.name == astronaut.id }) != nil
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts, allMissions: missions)
    }
}
