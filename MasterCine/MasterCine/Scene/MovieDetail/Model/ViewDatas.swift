//
//  ViewDatas.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

struct HeaderViewData {
  let title: String
  let subtitle: String
  let posterURL: String?
  let backdropURL: String?
}

struct ActionsViewData {
  let trailerURL: URL?
  let isFavorite: Bool
}

struct OverviewViewData {
  let text: String
}

struct GenresViewData {
  let genres: [String]
}

struct CastViewData {
  let cast: [CastMember]
}

struct RecommendationsViewData {
  let movies: [MovieSummary]
}
