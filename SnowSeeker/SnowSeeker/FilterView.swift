//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Németh Gergely on 2019. 12. 31..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    let resorts: [Resort]
    private var countries: [String] { Array(Set(resorts.map { $0.country })).sorted() }
    private var sizes: [Int] { Array(Set(resorts.map { $0.size })).sorted() }
    private var prices: [Int] { Array(Set(resorts.map { $0.price })).sorted() }
    @Binding var country: String
    @Binding var size: Int
    @Binding var price: Int

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Country")) {
                    Picker(selection: self.$country, label: EmptyView()) {
                        ForEach(self.countries, id: \.self) { country in
                            HStack {
                                Text(country)
                                CountryView(imageName: country)
                                    .frame(width: 10, height: 5)
                                    .layoutPriority(1)
                            }

                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }

                Section(header: Text("Size")) {
                    Picker(selection: self.$size, label: EmptyView()) {
                        ForEach(self.sizes, id: \.self) { size in
                            Text(self.string(for: size))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Price")) {
                    Picker(selection: self.$price, label: EmptyView()) {
                        ForEach(self.prices, id: \.self) { price in
                            Text(String(repeating: "$", count: price))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Filter")
            .navigationBarItems(leading: Button(action: {
                self.$country.wrappedValue = ""
                self.$price.wrappedValue = -1
                self.$size.wrappedValue = -1
                self.presentationMode.wrappedValue.dismiss()
            }, label: { Text("Reset") }), trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: { Text("Apply") }))
        }
    }

    private func string(for size: Int) -> String {
        switch size {
        case 1: return "Small"
        case 2: return "Average"
        default: return "Large"
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(resorts: Bundle.main.decode("resorts.json"), country: .constant("A"), size: .constant(1), price: .constant(1))
    }
}
