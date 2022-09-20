//
//  StartView.swift
//  Tables
//
//  Created by Stewart Lynch on 2022-09-18.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        TabView {
            CountryTableView()
                .tabItem {
                    Label("Example", systemImage: "1.circle.fill")
                }
            CountrySplitView()
                .tabItem {
                    Label("Example", systemImage: "2.circle.fill")
                }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
