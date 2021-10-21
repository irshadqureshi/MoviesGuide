//
//  DashboardViewController.swift
//  MoviesGuideAssessment
//
//  Created by irshad.ahmed on 09/08/2021.
//

import UIKit
import CollectionViewSlantedLayout
import BTNavigationDropdownMenu

public protocol DashboardViewProtocol: AnyObject {
    func didSuccessPopularResult(response: MoviesModel?)
    func didFailedPopularResult(with error: ErrorResponse?)
}

class DashboardViewController: BaseViewController, LoginFlowHandler {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: CollectionViewSlantedLayout!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel:DashboardViewModelProtocol = DashboardViewModel()
    var menuView: BTNavigationDropdownMenu!
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.apiManager = APIManager()
        viewModel.viewDidload()
        setUpViews()
        setUpNavigationDropDown()

        showAlertMessage(vc: self, title: "Welcome", message: "Hello \(userName ?? ""), Here you can scroll and view different movie list based on the top filter", actionTitles: ["OK"], actions:[{ okAction in
            self.dismiss(animated: true, completion: nil)
        }])
    }
    
    private func setUpViews() {
        isLoader(animating: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.CellIdentifiers.dashboardCell, bundle: nil), forCellWithReuseIdentifier: Constants.CellIdentifiers.dashboardCell)
        collectionViewLayout.isFirstCellExcluded = true
        collectionViewLayout.isLastCellExcluded = true
        collectionViewLayout.slantingSize = 50
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setUpNavigationDropDown() {
        guard let navigationController = self.navigationController else { return }
        let items = Constants.ScreenTitles.dashboardDropDownList
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = hexStringToUIColor(hex: Constants.HexCode.navBarColor)
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: navigationController.view, title: BTTitle.index(0), items: items)
        
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = navigationController.navigationBar.barTintColor
        menuView.cellSelectionColor = hexStringToUIColor(hex: Constants.HexCode.navBarColor)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: Constants.Font.fontType, size: 17)
        menuView.cellTextLabelAlignment = .center
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> Void in
            self?.isLoader(animating: true)
            self?.viewModel.apply(filter: MovieFilter(rawValue: indexPath) ?? .none)
        }
        self.navigationItem.titleView = menuView
    }
    
    @IBAction func navigationRightBarTapped(_ sender: Any) {
        if let window = UIApplication.shared.keyWindow {
            handleLogout(withWindow: window)
        }
    }
    
    func isLoader(animating: Bool) {
        DispatchQueue.main.async {
            animating ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    
    func reloadData() {
        self.isLoader(animating: false)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

typealias DashboardAPIResponse = DashboardViewController
extension DashboardAPIResponse: DashboardViewProtocol {
    func didSuccessPopularResult(response: MoviesModel?){
        guard let movies = response?.results else { return }
        viewModel.moviesListModel = movies
        reloadData()
    }
    
    func didFailedPopularResult(with error: ErrorResponse?){
        showAlertMessage(vc: self, title: "Alert", message: error?.info ?? "", actionTitles: ["OK"], actions:[{ okAction in
            self.dismiss(animated: true, completion: nil)
        }])
    }
}

typealias DashboardCollectionDataSource = DashboardViewController
extension DashboardCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.dashboardCell, for: indexPath)
                as? DashboardCell,
              let viewModel = viewModel.model(for: indexPath) else { return UICollectionViewCell() }
        
        cell.bind(cellViewModel: viewModel)
        cell.alignLabelAngle(collectionView: collectionView)
        
        return cell
    }
}

typealias DashboardCollectionLayoutDelegate = DashboardViewController
extension DashboardCollectionLayoutDelegate: CollectionViewDelegateSlantedLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: CollectionViewSlantedLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
        return collectionViewLayout.scrollDirection == .vertical ? 275 : 325
    }
}

typealias DashboardScrollViewDelegate = DashboardViewController
extension DashboardScrollViewDelegate: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else {return}
        guard let visibleCells = collectionView.visibleCells as? [DashboardCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight
            let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
            parallaxCell.offset(CGPoint(x: xOffset * Constants.OffsetSpeed.xOffsetSpeed, y: yOffset * Constants.OffsetSpeed.yOffsetSpeed))
        }
    }
}

