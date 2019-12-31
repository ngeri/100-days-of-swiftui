//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Németh Gergely on 2019. 12. 28..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

enum SortingOptions {
    case `default`, abc, country

    var formattedName: String {
        switch self {
        case .default: return "Default"
        case .abc: return "Alphabetical"
        case .country: return "Country"
        }
    }
}

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    private var filteredAndSortedResorts: [Resort] {
        let filteredResorts = resorts.filter { resort in
            if self.filterCountry != "", resort.country != self.filterCountry {
                return false
            }

            if self.filterSize != -1, resort.size != self.filterSize {
                return false
            }

            if self.filterPrice != -1, resort.price != self.filterPrice {
                return false
            }

            return true
        }
        switch selectedSortingOption {
        case .default: return filteredResorts
        case .abc: return filteredResorts.sorted(by: { $0.name < $1.name })
        case .country: return filteredResorts.sorted(by: { $0.country < $1.country })
        }
    }
    @State private var selectedSortingOption = SortingOptions.default
    @State private var filterCountry: String = ""
    @State private var filterSize: Int = -1
    @State private var filterPrice: Int = -1
    @State private var isShowingFilteringOptions = false
    private let sortingOptions = [SortingOptions.default, .abc, .country]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Sorting")
                    .padding(.horizontal)
                Picker(selection: self.$selectedSortingOption, label: EmptyView()) {
                    ForEach(self.sortingOptions, id: \.self) { sortingOption in
                        Text(sortingOption.formattedName)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                List(filteredAndSortedResorts) { resort in
                    NavigationLink(destination: ResortView(resort: resort)) {
                        CountryView(imageName: resort.country)
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                        )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                        )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        .layoutPriority(1)

                        if self.favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(Color.red)
                        }
                    }
                }
                .navigationBarTitle("Resorts")
                .navigationBarItems(trailing: Button(action: { self.isShowingFilteringOptions = true }, label: { Image(systemName: "tuningfork") }))
                .sheet(isPresented: self.$isShowingFilteringOptions) {
                    FilterView(resorts: self.resorts, country: self.$filterCountry, size: self.$filterSize, price: self.$filterPrice)
                }
            }

            WelcomeView()
        }
        .phoneOnlyStackNavigationView()
        .environmentObject(favorites)
    }
}

struct CountryView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
