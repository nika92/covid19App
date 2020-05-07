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
        
        if searchStarted {
            return searchedItems.count
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    var items           = Array<Case>()
    var searchedItems   = Array<Case>()
    var searchStarted   = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        } else {
            showSearchBar(show: false)
        }
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
    
    func fetchAllCases () {
        
        DispatchQueue.global(qos: .userInitiated).async {
         
            CaseProvider.shared.getAllCases(completionHandler: {(response) -> (Void) in
                self.items = response
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }, errorHandler: {(error) -> (Void) in
                self.items = CaseProvider.shared.getSavedCases()
                self.handleErrorCallback()
            })
        }
    }
    
    func setupTableView () {
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        
        tableView.register(UINib(nibName: CaseCell.reuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: CaseCell.reuseIdentifier)
    }
    
    func handleErrorCallback () {
        
        if items.count == 0 {
            //Show no data notification
        } else {
            //Show saved data notification
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let result = CaseProvider.shared.getCaseByKeyword(keyword: searchText)
        
        searchStarted = true
        searchedItems = result
        
        tableView.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        searchBar.searchTextField.text = ""
        endSearch()
        return false
    }
    
    func endSearch () {
        
        searchStarted = false
        searchedItems.removeAll()
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
}
