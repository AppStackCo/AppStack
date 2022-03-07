//
//  CharacterListViewController.swift
//  AppStack
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright (c) 2022 AppStack. All rights reserved.
//

import AppStack
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class CharacterListViewController: UIViewController, ViewControllable {
    
    var viewModel: CharacterListViewModel!
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var charactersTableView: UITableView! {
        didSet {
            charactersTableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view model inputs
        
        let loadNextPage = charactersTableView.rx.contentOffset
            .debounce(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .flatMap { [weak self] offset -> Observable<Void> in
                guard let tableView = self?.charactersTableView else { return Observable.empty() }
                return tableView.isNearBottomEdge()
                    ? Observable.just(())
                    : Observable.empty()
            }
        
        
        // bind view model
        viewModel.bind(loadNextPage: loadNextPage)
        
        
        // bind to view model outputs
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCharacterListCellModels>(
            configureCell: { _, tableView, indexPath, item -> UITableViewCell in
                
                switch item {
                case .character(let model):
                    let cell = CharacterCell.dequeue(from: tableView, at: indexPath)
                    cell.model = model
                    return cell
                }
            })
        
        viewModel.charactersDriver
            .asObservable()
            .bind(to: charactersTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        // load first page
        viewModel.loadFirstPage()
    }
}

extension CharacterListViewController: StoryboardBased {
    static var owningStoryboard: UIStoryboard {
        return .characters
    }
}

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        let isNear = self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
        return isNear
    }
}
