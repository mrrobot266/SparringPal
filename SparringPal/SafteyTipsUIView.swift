//
//  SafteyTipsUIView.swift
//  SparringPal
//
//  Created by Erick Soto on 4/12/23.
//

import SwiftUI

struct SafteyTipsUIView: View {
        @StateObject private var viewModel = NewsViewModel()

           var body: some View {
               Text("Boxing News")
               NavigationView {
                           List(viewModel.articles) { article in
                               VStack(alignment: .leading) {
                                   Text(article.title)
                                       .font(.headline)
                                   Text(article.url)
                                       .font(.subheadline)
                               }
                           }
                           .navigationTitle("Boxing News")
                       }
                       .onAppear {
                           viewModel.fetchNews()
                       }
           }
    }

struct SafteyTipsUIView_Previews: PreviewProvider {
    static var previews: some View {
        SafteyTipsUIView()
    }
}
