import Foundation
import UIKit

typealias MessageGroupDictionary = [String: Array<MessageGroup>]
typealias SortDataSourceTuple = (keys: [String], data: MessageGroupDictionary)

let GroupCellIdentifier = "GroupCell"
let TitleDateFormatter = "yyyy MMM d"
let ShowGroupDetail = "ShowGroupDetail"

class ChatGroupViewController: UITableViewController {

    lazy var operationQueue: OperationQueue = OperationQueue()
    lazy var sessionManager: URLSessionManager = URLSessionManager()
    let searchController = UISearchController(searchResultsController: nil)
    var groups = [MessageGroup]()
    var sections = MessageGroupDictionary()
    var sortedSections = [String]()
    var filteredSections = MessageGroupDictionary()
    var filteredSortedSections = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        self.showAddFloatButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchData()
    }
    
    func fetchData() {
        let chatListOperation = ChatListOperation(sessionManager: sessionManager) {[weak self] (operationResult) in
            if let result = operationResult {
                self?.groups = result
                self?.updateUI(result)
            }
        }
        operationQueue.cancelAllOperations()
        operationQueue.addOperation(chatListOperation)
    }
        
    func updateUI(dataSource: [MessageGroup]) {
        dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
            if let dataSource = self?.sortDataSource(dataSource) {
                self!.sections = dataSource.data
                self!.sortedSections = dataSource.keys
                self!.tableView.reloadData()
            }
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.isSearchBarActived() ? filteredSections.count : sections.count
    
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isSearchBarActived() ? filteredSections[filteredSortedSections[section]]!.count : sections[sortedSections[section]]!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(GroupCellIdentifier, forIndexPath: indexPath) as! ChatGroupCell
        let tableSection = self.isSearchBarActived() ? filteredSections[filteredSortedSections[indexPath.section]] : sections[sortedSections[indexPath.section]]
        let group = tableSection![indexPath.row]
        cell.nameLabel.text = "\(group.name!) by \(group.masterMessage!.userName!)"
        cell.recentMessageLabel.text = group.lastMessage!.text! as String
        cell.timeLabel.text = group.masterMessage!.createdTime!.timeIntervalToString()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateSection = sortedSections[section]
        if dateSection.dateFromString(TitleDateFormatter).isToday() {
            return "Today"
        }
        return dateSection.substringFromIndex(dateSection.startIndex.advancedBy(5))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ShowGroupDetail {
            if let messageView = segue.destinationViewController as? ORAMessageViewController,
                indexPath = tableView.indexPathForSelectedRow {
                let tableSection = self.isSearchBarActived() ? filteredSections[filteredSortedSections[indexPath.section]] : sections[sortedSections[indexPath.section]]
                let group = tableSection![indexPath.row]
                messageView.chatGroupID = group.id!
            }
        }
    }
    
    func sortDataSource(dataSource: [MessageGroup]) -> SortDataSourceTuple {
        var sectionData:[String: Array<MessageGroup>] = [:]
        var sectionKeys:[String] = []
        for group:MessageGroup in dataSource {
            let key = group.createDate!.stringWithFormat(TitleDateFormatter)
            if sectionData.indexForKey(key) == nil {
                sectionData[key] = [group]
            } else {
                sectionData[key]!.append(group)
            }
            sectionKeys = sectionData.keys.sort(>)
        }
        return SortDataSourceTuple(keys: sectionKeys, data: sectionData)
    }
    
    func filterContentForSearchText(searchText: String) {
        guard searchText.characters.count != 0 else {
            self.tableView.reloadData()
            return
        }
        let filteredArray = self.groups.filter({( group : MessageGroup) -> Bool in
            let searchlowerText = searchText.lowercaseString
            return group.name!.lowercaseString.containsString(searchlowerText) ||
                   group.masterMessage!.text!.lowercaseString.containsString(searchlowerText) ||
                   group.masterMessage!.userName!.lowercaseString.containsString(searchlowerText) ||
                   group.lastMessage!.text!.lowercaseString.containsString(searchlowerText) ||
                   group.lastMessage!.userName!.lowercaseString.containsString(searchlowerText)
            
        })
        let dataSource = self.sortDataSource(filteredArray)
        self.filteredSections = dataSource.data
        self.filteredSortedSections = dataSource.keys
        self.tableView.reloadData()
    }
    
    func isSearchBarActived() -> Bool {
        return searchController.active && searchController.searchBar.text != ""
    }
    
    func showAddFloatButton() {
        let button = MEVFloatingButton()
        button.displayMode = MEVFloatingButtonDisplayMode.Always
        button.position = MEVFloatingButtonPosition.BottomRight
        button.image = UIImage(named: "add")
        button.imageColor = UIColor(colorLiteralRed: 245/255.0, green: 166/255.0, blue: 33/255.0, alpha: 1)
        button.backgroundColor = UIColor.whiteColor()
        button.outlineWidth = 0.0
        button.verticalOffset = -50.0
        self.tableView.setFloatingButtonView(button)
        self.tableView.floatingButtonDelegate = self
    }
}

extension ChatGroupViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension ChatGroupViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension ChatGroupViewController: MEVFloatingButtonDelegate {
    func floatingButton(scrollView: UIScrollView!, didTapButton button: UIButton!) {
        print("did tap add button")
    }
}