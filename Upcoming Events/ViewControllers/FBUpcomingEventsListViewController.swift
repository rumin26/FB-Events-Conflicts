//
//  FBUpcomingEventsListViewController.swift
//  Upcoming Events
//
//  Created by Shah, Rumin on 4/11/20.
//  Copyright © 2020 Shah, Rumin. All rights reserved.
//

import UIKit

class FBUpcomingEventsListViewController: UIViewController {
    
    /// eventsTableView table view outlet
    @IBOutlet private weak var eventsTableView: UITableView!
    
    /// View model object
    private let eventsViewModel = FBEventsViewModel()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarStyle()
        
        eventsTableView.dataSource = eventsViewModel
        eventsTableView.estimatedRowHeight = 60
        eventsTableView.rowHeight = UITableView.automaticDimension
        
        registerTableViewCells()
        bindViewModel()
    }
    
    // MARK: - View Helper Methods
    
    /// Sets navigation bar style
    private func setupNavigationBarStyle() {
        title = FBConstants.eventsListViewTitle
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.FBUpcomingEventColor.appBackground,
                              NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: FBConstants.navigationBarTitleFontSize)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    /// Registers nibs of custom cell
    private func registerTableViewCells() {
        let eventTableViewCell = UINib(nibName: String(describing: FBEventTableViewCell.self),
                                  bundle: nil)
        eventsTableView.register(eventTableViewCell,
                                 forCellReuseIdentifier: FBEventTableViewCell.eventTableViewCellIdentifier)
    }
    
    /// Bind view model with view controller
    private func bindViewModel() {
        eventsViewModel.showConflictAlert = { [weak self] alert in
            self?.present(alert, animated: true)
        }
    }
}

extension FBUpcomingEventsListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FBConstants.tableViewSectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: tableView.bounds.width,
                                        height: FBConstants.tableViewSectionHeight))
        view.backgroundColor = UIColor.FBUpcomingEventColor.appBackground
        
        let label = UILabel(frame: CGRect(x: 15, y: 0,
                                          width: tableView.bounds.width - 30,
                                          height: FBConstants.tableViewSectionHeight))
        label.font = .boldSystemFont(ofSize: FBConstants.tableViewSectionTitleFontSize)
        label.textColor = .white
        label.text = eventsViewModel.sections[section].getDateToString()

        view.addSubview(label)
        return view
    }
}
