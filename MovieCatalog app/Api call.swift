import Foundation

class APIService {
    static func fetchPopularPersons() {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzIyZmMxYzUxNjZkYWUxZDgxZjA1MGQxMTcyNTEwZCIsInN1YiI6IjY1OGVkYTExZDRjYzhlNWZiNWU5YWRmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eOtfYC6zYztIWu8_R-p3686coZczDZxkA3NNATCDcSs"
        ]

        guard let url = URL(string: "https://api.themoviedb.org/3/person/popular?api_key=YOUR_API_KEY") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response: \(httpResponse.statusCode)")
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response Data: \(dataString)")
            }
        }
        dataTask.resume()
    }
}
