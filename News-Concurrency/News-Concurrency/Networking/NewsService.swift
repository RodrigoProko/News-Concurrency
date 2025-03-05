//
//  NewsService.swift
//  News-Concurrency
//
//  Created by Rodrigo on 05/03/2025.
//

import Foundation

// actor evita accesos simultáneos a los datos de la "clase"
actor NewsService {
    private let apiKey: String
    private let baseURL = "https://gnews.io/api/v4"
    
    init() {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let key = config["APIKey"] as? String else {
            fatalError("No se pudo cargar la APIKey")
        }
        self.apiKey = key
    }
    
    func fetchNews(page: Int, pageSize: Int) async throws -> NewsResponse {
        
        let urlString = "\(baseURL)/top-headlines?category=technology&lang=en&max=\(pageSize)&page=\(page)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(NewsResponse.self, from: data)
    }
}


//#MARK: - Aclaraciones sobre el uso de "actor"
//    1.    Evita problemas de concurrencia 🛑
//    •    Si varios lugares en la app llaman a fetchNews(page:pageSize:) simultáneamente, el actor se asegura de que la función se ejecute de manera segura sin interferencias.
//    2.    Encapsula el estado de forma segura 🔒
//    •    Aunque en este caso solo hay propiedades let (constantes), si en el futuro se agregaran variables mutables, actor aseguraría que solo una tarea pueda modificarlas a la vez.
//    3.    Facilita el uso de async/await ⏳
//    •    Dado que fetchNews realiza una solicitud de red, es una operación que puede demorar, por lo que usar async con un actor ayuda a estructurar el código de manera más segura y legible.
