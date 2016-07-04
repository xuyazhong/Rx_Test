//
//  Rx_Search.swift
//  TestRx
//
//  Created by xuyazhong on 16/7/3.
//  Copyright © 2016年 fishtrip. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import FishOpenKit
import Alamofire


class Rx_Search:UIViewController,UITableViewDelegate  {
    
    static let startLoadingOffset: CGFloat = 20.0
    
    static func isNearTheBottomEdge(contentOffset: CGPoint, _ tableView: UITableView) -> Bool {
        return contentOffset.y + tableView.frame.size.height + startLoadingOffset > tableView.contentSize.height
    }
    
    

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Repository>>()
//    var dataSource = [SearchItem]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        table.delegate = self
        //table.dataSource = self
        //searchBar.delegate = self
//        table.registerClass(SearchCell.self, forCellReuseIdentifier: String(SearchCell))

        
        let tableView = self.table
        let searchBar = self.searchBar
        

        


        dataSource.configureCell = { (_, tv, ip, repository: Repository) in
            let cell = tv.dequeueReusableCellWithIdentifier("Cell")!
            cell.textLabel?.text = repository.name
            cell.detailTextLabel?.text = repository.url
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            let section = dataSource.sectionAtIndex(sectionIndex)
            return section.items.count > 0 ? "Repositories (\(section.items.count))" : "No repositories found"
        }
        
        
        let loadNextPageTrigger = tableView.rx_contentOffset
            .flatMap { offset in
                Rx_Search.isNearTheBottomEdge(offset, tableView)
                    ? Observable.just()
                    : Observable.empty()
        }
        
        
        
        //throttle 后面是个时间 表示这个对象发送消息，0.3秒内没有再次发送就会相应，若是0.3内又发送消息了，便会在新的信息处重新计时
        //distinctUntilChanged 表示两个消息相同的时候，只会发送一个请求
        let searchResult = searchBar.rx_text.asDriver()
            .throttle(0.3)
            .filter({ (q) -> Bool in
                return q.length > 0
            })
            .distinctUntilChanged()
            .flatMapLatest { query -> Driver<RepositoriesState> in
                debugPrint(query)
                if query.isEmpty {
                    return Driver.just(RepositoriesState.empty)
                } else {
                    return GitHubSearchRepositoriesAPI.sharedAPI.search(query, loadNextPageTrigger: loadNextPageTrigger)
                        .asDriver(onErrorJustReturn: RepositoriesState.empty)
                }
        }
        
        searchResult
            .map { $0.serviceState }
        
        searchResult
            .map { [SectionModel(model: "Repositories", items: $0.repositories)] }
            .drive(tableView.rx_itemsWithDataSource(dataSource))
        
        searchResult
            .filter { $0.limitExceeded }
            .driveNext { n in
                showAlert("Exceeded limit of 10 non authenticated requests per minute for GitHub API. Please wait a minute. :(\nhttps://developer.github.com/v3/#rate-limiting")
            }
        
        // dismiss keyboard on scroll
        tableView.rx_contentOffset
            .subscribe { _ in
                if searchBar.isFirstResponder() {
                    _ = searchBar.resignFirstResponder()
                }
            }
        
        // so normal delegate customization can also be used
        tableView.rx_setDelegate(self)
        
        // activity indicator in status bar
        // {
        GitHubSearchRepositoriesAPI.sharedAPI.activityIndicator
            .drive(UIApplication.sharedApplication().rx_networkActivityIndicatorVisible)
        // }

        
    }
    
    
    
    
    
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    /*
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var res = ""
        if (dataSource.count > 0) {
            res = "Repositories (\(dataSource.count))"
        } else {
            res = "No repositories found"
        }
        return res
    }
    
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCellWithIdentifier(String(SearchCell))! as! SearchCell
        let model = dataSource[indexPath.row]
        cell.refresh(model.prompt!)
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint("search key:\(searchText)")
        let key = url + searchText
        FishRequest.create(key, needsSID: false)
            .setRequestMethod(.GET)
            .send { (response:Result<SearchModel,NSError>) in
                if (response.isSuccess) {
                    if response.value?.data?.count > 0 {
                        self.dataSource = (response.value?.data)!
                    } else {
                        self.dataSource.removeAll()
                    }
                    self.table.reloadData()
                } else {
                    debugPrint("没有网络")
                }
        }
    }
 */
}