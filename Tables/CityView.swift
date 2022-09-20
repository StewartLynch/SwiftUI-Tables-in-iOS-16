//
// Created for NavigationStack 2
// by Stewart Lynch on 2022-09-02
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

struct CityView: View {
    let city: City
    var body: some View {
        VStack {
            ZStack {
                if city.isCapital {
                    Text("🌟")
                        .font(.system(size: 200))
                }
                VStack {
                    Text(city.name)
                    Text("(\(city.country))")
                    Text("\(city.population)")
                        .font(.title)
                }
                .font(.largeTitle)
                .padding()
            }
        }
        .navigationTitle("City")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CityView(city: City.sample[1])
        }
    }
}
