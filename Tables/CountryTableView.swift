//
//  CountryTableView.swift
//  Tables
//
//  Created by Stewart Lynch on 2022-09-17.
//

import SwiftUI

struct CountryTableView: View {
    @State private var sampleCities = City.sample.sorted(using: KeyPathComparator(\.name))
    @State private var sortOrder = [KeyPathComparator(\City.name)]
    @State private var selection: City.ID?
    @State private var path = [City]()
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var ascend = true
    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .leading){
                Text("Cities")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                if sizeClass == .compact {
                    Button {
                        ascend.toggle()
                        if ascend {
                            sampleCities.sort {$0.name < $1.name}
                        } else {
                            sampleCities.sort {$0.name > $1.name}
                        }
                    } label: {
                        Text(ascend ? "Sort \(Image(systemName: "arrowtriangle.down"))" : "Sort \(Image(systemName: "arrowtriangle.up"))")
                    }
                    .buttonStyle(.bordered)
                }
                Table(sampleCities, selection: $selection, sortOrder: $sortOrder) {
                    TableColumn("Name", value: \.name) { city in
                        HStack{
                            Text("\(city.name) \(city.isCapital && sizeClass == .compact ? "🌟" : "")")
                            Spacer()
                            if sizeClass == .compact {
                                Text(city.country)
                                    .font(.caption2)
                                    .textCase(.uppercase)
                            }
                        }
                    }
                    TableColumn("Capital", value: \.isCapitalInt) { city in
                        HStack {
                            Spacer()
                            Text(city.isCapital ? "🌟" : "")
                            Spacer()
                        }
                    }
                    .width(60)
                    TableColumn("Country", value: \.country)
                    TableColumn("Population", value: \.population) { city in
                        Text("\(city.population)")
                    }
                }
            }
            .padding()
            .navigationDestination(for: City.self) { city in
                CityView(city: city)
            }
            .onAppear {
                selection = nil
            }
        }
        .onChange(of: sortOrder) { newOrder in
            sampleCities.sort(using: newOrder)
        }
        .onChange(of: selection) { selection in
            if let selection = selection,
               let city = sampleCities.first(where: {$0.id == selection}) {
                path.append(city)
            }
        }
    }
}

struct CountryTableView_Previews: PreviewProvider {
    static var previews: some View {
        CountryTableView()
    }
}


