//
//  ContentView.swift
//  Moonshot
//
//  Created by Radu Dan on 24/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var buttonTitle = "Crew Names"
    @State private var showCrewNames = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts, allMissions: missions)) {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .accessibility(removeTraits: .isImage)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(showCrewNames ?
                            mission.formattedCrewNames :
                            mission.formattedLaunchDate)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(
                        Text("Mission \(mission.displayName),  \(showCrewNames ? mission.formattedCrewNames : mission.formattedLaunchDate)"))
                }
            }
            .navigationBarTitle("Moonshoot")
            .navigationBarItems(trailing:
                Button(buttonTitle) {
                    toggleView()
            })
        }
    }
    
    private func toggleView() {
        showCrewNames.toggle()
        
        if showCrewNames {
            buttonTitle = "Launch Dates"
        } else {
            buttonTitle = "Crew Names"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
