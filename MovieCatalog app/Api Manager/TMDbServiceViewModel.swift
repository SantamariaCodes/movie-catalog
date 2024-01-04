import Foundation

class TMDbService: ObservableObject {
    
    @Published var topShows: [TVShow] = []

    func fetchTopRatedShows() {
        
        guard let apiKey = ConfigurationManager.shared.apiKey else {
            print("API Key not found")
            return
        }

        let urlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=\(apiKey)&language=en-US&page=1"
        
        NetworkingManager.shared.request(urlString, type: TopRatedShows.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let topRatedShowsResponse):
                    self?.topShows = topRatedShowsResponse.results
                case .failure(let error):
                    print("Error fetching top rated shows: \(error)")
                }
            }
        }
    }
}
