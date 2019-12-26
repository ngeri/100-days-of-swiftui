//
//  MissionView.swift
//  Moonshot
//
//  Created by Németh Gergely on 2019. 11. 03..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct PixelSize {
    var sizeInPixel: CGFloat
    var sizeInPoints: CGFloat {
        sizeInPixel / UIScreen.main.scale
    }
}

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]

    private let defaultHeight: CGFloat = 200
    
    var body: some View {
        GeometryReader { globalView in
            ScrollView {
                VStack {
                    self.headerView(globalView: globalView, mission: self.mission)

                    self.formattedLaunchDate(mission: self.mission)

                    self.descriptionView(mission: self.mission)

                    ForEach(self.astronauts, id: \.role) { crewMember in
                        self.cell(crewMember: crewMember)
                    }

                    Spacer(minLength: 25)
                }
            }.coordinateSpace(name: "CustomCoordinate")
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }

    private func headerView(globalView: GeometryProxy, mission: Mission) -> some View {
        return GeometryReader { localView in
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: self.sizeForImage(localView: localView, globalView: globalView), height: self.sizeForImage(localView: localView, globalView: globalView), alignment: .bottom)
                    .offset(CGSize(width: (self.defaultHeight - self.sizeForImage(localView: localView, globalView: globalView))/2, height: self.defaultHeight - self.sizeForImage(localView: localView, globalView: globalView)))
        }.frame(width: defaultHeight, height: defaultHeight)
    }

    private func sizeForImage(localView: GeometryProxy, globalView: GeometryProxy) -> CGFloat {
        let offset = localView.frame(in: .named("CustomCoordinate")).origin.y - globalView.safeAreaInsets.top
        let size = max(defaultHeight + min(offset, 0), 0)
        return size
    }

    private func formattedLaunchDate(mission: Mission) -> some View {
        Text(mission.formattedLaunchDate)
            .padding()
    }

    private func descriptionView(mission: Mission) -> some View {
        Text(mission.description)
            .padding()
    }

    private func cell(crewMember: CrewMember) -> some View {
        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: Bundle.main.decode("missions.json"))) {
            HStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color.primary, lineWidth: PixelSize(sizeInPixel: 1).sizeInPoints)
                    )

                VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .font(.subheadline)

                    Text(crewMember.role)
                        .font(.footnote)
                        .foregroundColor(Color.secondary)
                }

                Spacer()
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing member")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
