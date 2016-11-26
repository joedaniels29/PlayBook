//
// Created by Joseph Daniels on 12/26/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa

class AudioBodyCellViewController:UIViewController {
//    main thread?
    var model:MutableProperty<AudioBody?> = MutableProperty(nil)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressIndicator: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model => {[unowned self]  in
            if let model = $0{
                self.titleLabel.text = model.name
                self.authorLabel.text = model.author
//                self.coverView.image = model.coverPicture ? UIImage(data: model.coverPicture) : UIImage()
                self.durationLabel.text = NSDateFormatter.durationFormatter.stringFromDate(NSDate(timeIntervalSince1970: model.duration!.doubleValue))
//            progressLabel.text = NSDateFormatter.durationFormatter.stringFromDate(NSDate(timeIntervalSince1970: model.duration.doubleValue))
            } else{
                self.titleLabel.text = ""
                self.authorLabel.text = ""
//                self.coverView.text = UIImage()
                self.durationLabel.text = NSDateFormatter.durationFormatter.stringFromDate(NSDate(timeIntervalSince1970: 0))
//            progressLabel.text = NSDateFormatter.durationFormatter.stringFromDate(NSDate(timeIntervalSince1970: model.duration.doubleValue))
            }

        }
    }


}
