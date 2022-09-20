//
//  CountrySplitView.swift
//  Tables
//
//  Created by Stewart Lynch on 2022-09-18.
//

import SwiftUI

struct CountrySplitView: View {
    enum SelectionType: Hashable {
        case all
        case specific([City])
        var cities: [City] {
            switch self {
            case .specific(let cities):
                return cities
            default: return []
            }
        }
        
        var countryName: String {
            switch self {
            case .specific(let cities):
                if !cities.isEmpty {
                    return cities[0].country
                } else {
                    return ""
                }
            default: return "All Countries"
            }
        }
    }
    @State private var sidebarSelection: SelectionType?
    @State private var cities = [City]()
    @State private var sortOrder = [KeyPathComparator(\City.name)]
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var selection: City.ID?
    @State private var path = [City]()
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.doubleColumn)) {
            List(selection: $sidebarSelection) {
                Text("All Cities").bold()
                    .tag(SelectionType.all)
                ForEach(City.countries, id: \.self) { country in
                    Text(country)
                        .tag(SelectionType.specific(
                            City.sample.filter({$0.country == country})
                        ))
                }
                .navigationTitle("Countries")
            }
            .onChange(of: sidebarSelection) { newValue in
                switch newValue {
                case .specific(let cities):
                    self.cities = cities
                default: self.cities = City.sample
                }
            }
            
        } detail: {
            NavigationStack(path: $path) {
                if sidebarSelection == nil {
                    Text("Select a row in the sidebar")
                } else {
                    VStack(alignment: .leading){
                        Text(sidebarSelection?.countryName ?? "")
                            .bold()
                            .font(.largeTitle)
                            .padding(.leading)
                        Table(cities, selection: $selection, sortOrder: $sortOrder) {
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
                    .onChange(of: sortOrder) { newValue in
                        cities.sort(using: newValue)
                    }
                    .onChange(of: selection) { selection in
                        if let selection = selection,
                           let city = cities.first(where: {$0.id == selection}) {
                            path.append(city)
                        }
                    }
                    .navigationDestination(for: City.self) { city in
                        CityView(city: city)
                    }
                }
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct CountrySplitView_Previews: PreviewProvider {
    static var previews: some View {
        CountrySplitView()
    }
}
