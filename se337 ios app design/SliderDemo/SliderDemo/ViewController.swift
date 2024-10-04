//
//  ViewController.swift
//  SliderDemo
//
//  Created by RamanLakshmanan on 10/5/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        slider.setThumbImage(getSliderThumbImage(imageName: "dollarsign.circle"), for: .normal)
        slider.setThumbImage(getSliderThumbImage(imageName: "dollarsign.circle.fill"), for: .highlighted)
    }

    @IBAction func sliderValueSet(_ sender: UISlider) {
        let fillValue = sender.value
        sliderValue.text = String (format: "%.2f", fillValue)
        
    }
    
    func getSliderThumbImage(imageName: String) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        return image!
        
    }
    
}

