//
// Created by Joseph Daniels on 12/26/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import UIKit
import Cartography
import MagicalRecord
import ReactiveCocoa
 


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var recentsProducer = SignalProducer<[AudioBody], NoError>({
        s, d in
        let recentBooks = AudioBody.MR_findAllSortedBy("lastPlayed", ascending: true) as! [AudioBody]
        s.sendNext(Array(recentBooks.prefix(4)))
    }).startOn(QueueScheduler(qos: QOS_CLASS_USER_INITIATED))
    .observeOn(QueueScheduler.mainQueueScheduler)
    .map {
        $0.map {
            $0.MR_inThreadContext()
        }
    }

    var recents: MutableProperty<[AudioBody]> = MutableProperty([])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true;

    }

    @IBAction func addButtonPressed(sender: AnyObject) {
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("ImportViewController"), animated: true);

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = HomeTableSection(rawValue: section) {
            switch (section) {
            case .Recent:
                return recents.value.count
//            case .Audiobooks:
//                return 1
//            case .Podcasts:
//                return 1
//            case .Settings:
//                return 1
            }
        } else {
            fatalError("not a valid section")
        }
    }

    @available(iOS 6.0, *) func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? AudioBodyTableViewCell {
            cell.vc!.removeFromParentViewController()
            cell.vc!.view.removeFromSuperview()
        }
    }

    @available(iOS 2.0, *) func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableSection = HomeTableSection(rawValue: section) else {
            fatalError("indexPath section")
        }
        return tableSection.headerTitle
    }

    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return HomeTableSection.sections
    }

    @available(iOS 2.0, *) func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let section = HomeTableSection(rawValue: indexPath.section) else {
            fatalError("indexPath section")
        }
        switch (section) {
        case .Recent:
            let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(AudioBodyTableViewCell)) as! AudioBodyTableViewCell
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier(NSStringFromClass(AudioBodyCellViewController)) as! AudioBodyCellViewController
            cell.vc = vc
            vc.model.value = recents.value[indexPath.row]
            self.addChildViewController(cell.vc!)
            cell.addSubview(cell.vc!.view)
            constrain(cell.vc!.view) {
                view in view.size == view.superview!.size; view.center == view.superview!.center
            }
            return cell
        case .Audiobooks: fallthrough
        case .Podcasts: fallthrough
        case .Settings:
            let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell))!
            cell.textLabel!.text = section.headerTitle
            return cell
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        guard let section = HomeTableSection(rawValue: indexPath.section) else {
            fatalError("indexPath section")
        }
        switch (section) {
        case .Recent:
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier(NSStringFromClass()))
        case .Library:
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier(NSStringFromClass(LibraryViewController)))
        case .Library: break


        }

    }


}
