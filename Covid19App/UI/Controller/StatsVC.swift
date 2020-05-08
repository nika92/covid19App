//
//  StatsVC.swift
//  Covid19App
//
//  Created by Nika Chkadua on 5/7/20.
//  Copyright © 2020 Nika Chkadua. All rights reserved.
//

import UIKit

class StatsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if listSelected {
            
            if searchStarted {
                return searchedItems.count
            }
            return items.count
            
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if listSelected {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CaseCell.reuseIdentifier, for: indexPath) as? CaseCell else {
                preconditionFailure("Invalid cell type")
            }
            cell.selectionStyle = .none
            
            if searchStarted {
                cell.setupWithCase(_case: searchedItems[indexPath.row])
            } else {
                cell.setupWithCase(_case: items[indexPath.row])
            }
            
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TotalCasesCell.reuseIdentifier, for: indexPath) as? TotalCasesCell else {
                preconditionFailure("Invalid cell type")
            }
            cell.selectionStyle = .none
            
            if let _totalCase = self.totalCase {
                cell.setupWithTotalCases(totalCases: _totalCase)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if listSelected {
            return 44
        } else {
            return 260
        }
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    var items           = Array<Case>()
    var searchedItems   = Array<Case>()
    
    var totalCase: TotalCases?
    
    var searchStarted   = false
    var listSelected    = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        styleViews()
        setupTableView()
        fetchAllCases()
    }
    
    func styleViews () {
        
        view.backgroundColor = StyleUtils.appBgColor()
        
        //SegmentedControl
        segmentedControl.backgroundColor = StyleUtils.appGreyColor()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: StyleUtils.appGreyColor()], for: .selected)
        
        //SearchBar
        searchBar.barTintColor                      = StyleUtils.appBgColor()
        searchBar.backgroundImage                   = UIImage()
        searchBar.searchTextField.backgroundColor   = StyleUtils.appGreyColor()
        searchBar.searchTextField.textColor         = .white
        searchBar.searchTextField.font              = UIFont.systemFont(ofSize: 15)
        searchBar.setImage(UIImage(named: "search_icon"), for: .search, state: .normal)
        
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
    }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            showSearchBar(show: true)
            listSelected = true
            tableView.separatorStyle = .singleLine
            
            self.reloadTableView()
            
        } else {
            
            showSearchBar(show: false)
            listSelected = false
            tableView.separatorStyle = .none
            
            if segmentedControl.selectedSegmentIndex == 2 {
                self.fetchTotalGlobalCases()
            } else {
                self.totalCase = CaseProvider.shared.getToTalLocalCases()
                reloadTableView()
            }
        }
        
        view.endEditing(true)
    }
    
    func showSearchBar (show: Bool) {
        
        if show {
            searchBarHeight.constant = 44
        } else {
            searchBarHeight.constant = 0
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func fetchAllCases () {
        
        DispatchQueue.global(qos: .userInitiated).async {
         
            CaseProvider.shared.getAllCases(completionHandler: {(response) -> (Void) in
                self.items = response
                
                DispatchQueue.main.async {
                    self.reloadTableView()
                }
                
            }, errorHandler: {(error) -> (Void) in
                self.items = CaseProvider.shared.getSavedCases()
                self.handleErrorCallback()
            })
        }
    }
    
    func fetchTotalGlobalCases () {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            CaseProvider.shared.getTotalGlobalCases(completionHandler: {(response) -> (Void) in
                
                self.totalCase = response
                DispatchQueue.main.async {
                    self.reloadTableView()
                }
                
            }, errorHandler: {(error) -> (Void) in
                self.handleTotalCasesErrorCallback()
            })
        }
    }
    
    var refreshControl = UIRefreshControl()
    func setupTableView () {
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        
        tableView.register(UINib(nibName: CaseCell.reuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: CaseCell.reuseIdentifier)
        tableView.register(UINib(nibName: TotalCasesCell.reuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: TotalCasesCell.reuseIdentifier)
    }
    
    func reloadTableView () {
        
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
    
    func handleTotalCasesErrorCallback () {
        
        DispatchQueue.main.async {
            
            self.totalCase = CaseProvider.shared.getSavedGlobalCases()
            
            if self.totalCase!.isEmpty {
                Popup.shared.show(message: Constants.NO_CONNECTION)
            } else {
                Popup.shared.show(message: Constants.DATA_NOT_UPDATED)
            }
        
            self.reloadTableView()
        }
    }
    
    func handleErrorCallback () {
        
        DispatchQueue.main.async {
            
            if self.items.count == 0 {
                Popup.shared.show(message: Constants.NO_CONNECTION)
            } else {
                Popup.shared.show(message: Constants.DATA_NOT_UPDATED)
                    self.reloadTableView()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 0 {
            
            let result = CaseProvider.shared.getCaseByKeyword(keyword: searchText)
            
            searchStarted = true
            searchedItems = result
            
            self.reloadTableView()
            
        } else {
            endSearch()
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        searchBar.searchTextField.text = ""
        endSearch()
        return false
    }
    
    func endSearch () {
        
        searchStarted = false
        searchedItems.removeAll()
        self.reloadTableView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
}
