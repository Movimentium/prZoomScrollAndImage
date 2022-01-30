//
//  MainVC.swift
//  prZoomScrollAndImage
//
//  Created by Miguel on 29/1/22.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    private var theImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("UIScreen bounds: \(UIScreen.main.bounds)")
        segmentChanged(segment)
    }
    
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:  theImg = UIImage(named: "768_900")
        case 1:  theImg = UIImage(named: "1536_900")
        case 2:  theImg = UIImage(named: "600_1900")
        case 3:  theImg = UIImage(named: "600_300")
        case 4:  theImg = UIImage(named: "300_600")
        default:  theImg = UIImage(named: "768_900")
        }
    }
    
    @IBAction func onBtnGo() {
        performSegue(withIdentifier: "to\(ScrollWithImageVC.self)", sender: nil)
    }
    
    
    
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? ScrollWithImageVC {
            vc.img = theImg
        }
    }
 
}
