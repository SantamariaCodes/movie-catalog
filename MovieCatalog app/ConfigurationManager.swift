//
//  ConfigurationManager.swift
//  MovieCatalog app
//
//  Created by Diego Santamaria on 4/1/24.
//

import Foundation
import Yams

class ConfigurationManager {
    static let shared = ConfigurationManager()
    var apiKey: String?

    private init() {
        loadConfigurations()
    }

    private func loadConfigurations() {
        guard let url = Bundle.main.url(forResource: "Config", withExtension: "yml"),
              let contents = try? String(contentsOf: url) else {
            return
        }

        do {
            if let config = try Yams.load(yaml: contents) as? [String: Any] {
                apiKey = config["TMDB_API_KEY"] as? String
            }
        } catch {
            print("Error parsing Config.yml: \(error)")
        }
    }
}
