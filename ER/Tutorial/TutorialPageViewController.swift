//
//  TutorialPageViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/26/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    var pageControl = UIPageControl()
    
    var backgroundStr:[String] = ["fondoER", "fondoER", "fondoER"]
    var imageStr = ["ticket", "pindos", "playAudio"]
    var titleStr = ["Consulta tus tickets", "Lugares relevantes", "Conoce más"]
    var subtitleStr = ["Ubica tu folio de ticket con la fecha programada", "Obten información interesante por donde pases", "Reproduce nuestras narrativas"]
    var vcArrays: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        // Do any additional setup after loading the view.
        
        for number in 0...(titleStr.count-1) {
            let vc = UIStoryboard(name: "Ruta", bundle: nil).instantiateViewController(withIdentifier: "TutorialDetalle") as! TutorialDetalleViewController
            vc.backgroundStr = self.backgroundStr[number]
            vc.imageStr = self.imageStr[number]
            vc.titleStr = self.titleStr[number]
            vc.subtitleStr = self.subtitleStr[number]
            
            vcArrays.append(vc)
        }
        
        if let firstVC = vcArrays.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        //Set up pagecontrol
        //its -50 because its height of navbar + -50 because height of page control + -20 because some stupid padding
        pageControl = UIPageControl(frame: CGRect(x: 0,y: self.view.frame.height-100-90,width: UIScreen.main.bounds.width,height: 100))
        self.pageControl.numberOfPages = titleStr.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        self.view.addSubview(pageControl)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TutorialPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vcIndex = vcArrays.index(of: viewController)
        if(vcIndex == 0){
            return vcArrays.last
        }
        else{
            let previousIndex = vcIndex! - 1
            return vcArrays[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vcIndex = vcArrays.index(of: viewController)
        if((vcIndex!+1) == vcArrays.count){
            return vcArrays.first
        }
        else{
            let afterIndex = vcIndex! + 1
            return vcArrays[afterIndex]
        }
    }
}

extension TutorialPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentVC = pageViewController.viewControllers![0]
        self.pageControl.currentPage = vcArrays.index(of: currentVC)!
    }
}
