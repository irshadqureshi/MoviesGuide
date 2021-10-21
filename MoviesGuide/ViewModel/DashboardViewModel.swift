//
//  DashboardViewModel.swift
//  MoviesGuideAssessment
//
//  Created by irshad.ahmed on 09/08/2021.
//

import Foundation

protocol DashboardViewModelProtocol: AnyObject {
    var view: DashboardViewProtocol? {get set}
    var apiManager: APIManagerProtocol? {get set}
    var moviesListModel: [Movies]? {get set}
    func viewDidload()
    func apply(filter: MovieFilter)
    func getMovieList(url: String)
    func numberOfItems() -> Int
    func model(for index: IndexPath) -> DashboardCellViewModel?
}

enum MovieFilter:Int {
    case popular = 0
    case topRated = 1
    case upcoming = 2
    case none
}

class DashboardViewModel: DashboardViewModelProtocol {
    
    weak var view: DashboardViewProtocol?
    var apiManager: APIManagerProtocol?
    
    var moviesListModel: [Movies]?
    var cellViewModel: DashboardCellViewModel?
    
    init(apiManager: APIManagerProtocol? = APIManager(),
         view: DashboardViewProtocol? = DashboardViewController()) {
        self.apiManager = apiManager
        self.view = view
    }
    
    func viewDidload() {
        apply(filter: .popular)
    }
    
    func apply(filter: MovieFilter) {
        self.apiManager?.cancelNetworkRequest()
        switch filter {
        case .popular:
            getMovieList(url: Constants.WebService.popularAPI)
            break
        case .topRated:
            getMovieList(url: Constants.WebService.topRatedAPI)
            break
        case .upcoming:
            getMovieList(url: Constants.WebService.upcomingAPI)
            break
        case .none: break
        }
    }
}

typealias DashboardAPIService = DashboardViewModel
extension DashboardAPIService {
    
    func getMovieList(url: String) {
        moviesListModel = nil
        self.apiManager?.requestApi(
            apiUrl: url,
            params: Constants.QueryParameter.page,
            handler: {[weak self] data, response, error in
                if let error = error {
                    self?.view?.didFailedPopularResult(with: ErrorResponse(code: -1, info: error.localizedDescription))
                }
                
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(MoviesModel.self, from: data)
                        self?.view?.didSuccessPopularResult(response: response)
                    } catch _ {
                        self?.view?.didFailedPopularResult(with: ErrorResponse(code: -1, info: Constants.ErrorResponse.message))
                    }
                }
            })
    }
}

typealias DashboardListDataSource = DashboardViewModel
extension DashboardListDataSource {
    
    func numberOfItems() -> Int {
        moviesListModel?.count ?? 0
    }
    
    func model(for index: IndexPath) -> DashboardCellViewModel? {
        cellViewModel = DashboardCellViewModel(moviesListModel: moviesListModel?[index.row])
        return cellViewModel
    }
}
