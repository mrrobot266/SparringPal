import Combine
import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []

    private var cancellable: AnyCancellable?

    func fetchNews() {
        let urlString = "https://newsapi.org/v2/everything?q=boxing&sortBy=publishedAt&apiKey=3d3ae81b6a28423ab94289ca18b0a52d"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .replaceError(with: NewsResponse(articles: []))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                self?.articles = response.articles
            }
    }
}
