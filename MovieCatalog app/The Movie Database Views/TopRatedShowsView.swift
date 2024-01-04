//
//  TopRatedShowsView.swift
//  MovieCatalog app
//
//  Created by Diego Santamaria on 4/1/24.
//

import SwiftUI

struct TopRatedShowsView: View {
    @StateObject var tmdbService = TMDbService()

    var body: some View {
        NavigationView {
            List(tmdbService.topShows, id: \.id) { show in
                VStack(alignment: .leading) {
                    Text(show.name)
                        .font(.headline)
                    Text(show.overview)
                        .font(.subheadline)
                        .lineLimit(3)
                }
            }
            .navigationTitle("Top Rated Shows")
            .onAppear {
                tmdbService.fetchTopRatedShows()
            }
        }
    }
}

struct TopRatedShowsView_Previews: PreviewProvider {
    static var previews: some View {
        TopRatedShowsView()
    }
}

