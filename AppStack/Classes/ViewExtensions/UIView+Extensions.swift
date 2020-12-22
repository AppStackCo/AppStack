//
//  UIView+Extensions.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxDataSources
import RxSwift

public struct AnchorPadding {
    let top: CGFloat
    let bottom: CGFloat
    let left: CGFloat
    let right: CGFloat
}

extension AnchorPadding {
    public static var zero: AnchorPadding {
        AnchorPadding(top: 0, bottom: 0, left: 0, right: 0)
    }
}

extension UIView {
    public func fixInView(_ container: UIView, anchorPadding: AnchorPadding = AnchorPadding.zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.bounds
        container.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: anchorPadding.top),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: anchorPadding.bottom),
            leftAnchor.constraint(equalTo: container.leftAnchor, constant: anchorPadding.left),
            rightAnchor.constraint(equalTo: container.rightAnchor, constant: anchorPadding.right)
        ])
    }
    
    public func presentSelf(duration: Double = 0.2, options: AnimationOptions = [.transitionCrossDissolve], completionHandler: (() -> Void)? = nil) {
        if let window = UIApplication.shared.keyWindow {
            UIView.transition(with: window, duration: duration, options: options, animations: {
                self.fixInView(window)
            }) { _ in
                completionHandler?()
            }
        }
    }
    
    public func removeSelf(duration: Double = 0.2, options: AnimationOptions = [.transitionCrossDissolve], completionHandler: (() -> Void)? = nil) {
        if let window = UIApplication.shared.keyWindow {
            UIView.transition(with: window, duration: duration, options: options, animations: {
                self.alpha = 0
            }) { [unowned self] (finished) in
                if finished {
                    self.removeFromSuperview()
                }
                completionHandler?()
            }
        }
    }
    
    public func setupTableViewDataSource(tableView: UITableView, cellIdentifiers: [String], dataSource: inout RxTableViewSectionedReloadDataSource<TableViewSectionModel>?, disposeBag: DisposeBag) {
        tableView.setup()
        
        cellIdentifiers.forEach { cellIdentifier in
            tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
        
        let configureCell: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.ConfigureCell = { (_, tableView, indexPath, cellModel) in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath)
            (cell as? BaseTableViewCell)?.update(using: cellModel)
            
            return cell
        }
        
        let canEditRowAtIndexPath: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.CanEditRowAtIndexPath = { (_, _) in false }
        
        dataSource = .init(configureCell: configureCell,
                           canEditRowAtIndexPath: canEditRowAtIndexPath)
        
        tableView.rx.modelSelected(BaseTableViewCellViewModel.self)
            .subscribe(onNext: { model in
                (model as? SelectableTableViewCellViewModel)?.selectedAction.execute()
            })
            .disposed(by: disposeBag)
        
        // This adds the visual effect of de-selecting a row once touchUp has been fired.
        tableView.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
