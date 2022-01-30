//
//  ScrollWithImageVC.swift
//  prZoomScrollAndImage
//
//  Created by Miguel on 29/1/22.
//

import UIKit

class ScrollWithImageVC: UIViewController {

    @IBOutlet weak var scrollVw: UIScrollView!
    @IBOutlet weak var imgVw: UIImageView!

    var img: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollVw.contentInsetAdjustmentBehavior = .never
        scrollVw.contentInset = .zero
        scrollVw.contentSize = img.size
        scrollVw.delegate = self
                                                                                             
        imgVw.contentMode = .scaleToFill
        imgVw.frame = CGRect(origin: .zero, size: img.size)
        imgVw.image = img

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imgH != scrollH || imgW != scrollW {
            calculateMinZoom()
            calculateMaxZoom()
            scrollVw.zoom(to: imgVw.bounds, animated: true)
        }
        
        print("img.scale: ", img.scale)
        print("scrollVw.minimumZoomScale", scrollVw.minimumZoomScale)
        print("scrollVw.maximumZoomScale", scrollVw.maximumZoomScale)
        debug_printSizes()
    }
    
    private lazy var imgW = img.size.width
    private lazy var scrollW = scrollVw.bounds.width
    private lazy var imgH = img.size.height
    private lazy var scrollH = scrollVw.bounds.height

    func calculateMinZoom() {
        var minZoom: CGFloat = 1
        if imgW > scrollW {
            minZoom = scrollW / imgW
        }
        if imgH > scrollH {
            let newPosibleMinZoom = scrollH / imgH
            minZoom = (newPosibleMinZoom < minZoom ? newPosibleMinZoom : minZoom)
        }
        scrollVw.minimumZoomScale = minZoom
    }
    
    func calculateMaxZoom() {
        var maxZoom: CGFloat = 1
        if imgW < scrollW {
            maxZoom = scrollW / imgW
        }
        if imgH < scrollH {
            let newPosibleMaxZoom = scrollH / imgH
            maxZoom = (newPosibleMaxZoom > maxZoom ? newPosibleMaxZoom : maxZoom)
        }
        scrollVw.maximumZoomScale = maxZoom
    }

    @IBAction func onBtnBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - UIScrollViewDelegate
extension ScrollWithImageVC: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgVw
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print(Self.self, #function)
        
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print(Self.self, #function)

    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print(Self.self, #function)

        imgVw.frame = CGRect(origin: .zero,
                             size: CGSize(width: img.size.width * scrollVw.zoomScale,
                                          height: img.size.height * scrollVw.zoomScale))
//        centerScrollViewContents()
        debug_printSizes()
    
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollVw.bounds.size;
        var contentsFrame = imgVw.frame;

        if (contentsFrame.size.width < boundsSize.width) {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0;
        } else {
            contentsFrame.origin.x = 0.0;
        }

        if (contentsFrame.size.height < boundsSize.height) {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0;
        } else {
            contentsFrame.origin.y = 0.0;
        }

        imgVw.frame = contentsFrame;
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(Self.self, #function)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(Self.self, #function)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print(Self.self, #function)
        print("scrollVw.contentOffset.y: ", scrollVw.contentOffset.y)
        if scrollVw.contentOffset.y < 0 {
            scrollVw.setContentOffset(.zero, animated: true)
        }
    }
    
}

// MARK: - Debug
extension ScrollWithImageVC {
    
    private func debug_printSizes() {
        print("======================================================= ")
        print("UIScreen. .bounds.size: ", UIScreen.main.bounds.size)
        print("imgVw.bounds.size:      ", imgVw.bounds.size)
        print("scrollVw.bounds.size:   ", scrollVw.bounds.size)
        print("scrollVw.contentSize:   ", scrollVw.contentSize)
        print("scrollVw.contentOffset: ", scrollVw.contentOffset)
    }
}
