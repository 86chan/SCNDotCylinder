//
//  Ex.swift
//  Scenekit_Test
//
//  Created by Haruo on 2022/05/31.
//

import Foundation
import SceneKit

extension SCNGeometry {
    
}

extension UIImage {
    convenience init?(color: UIColor, size: CGSize) {
        guard let cgImage = UIGraphicsImageRenderer(size: size).image(actions: { rendererContext in
            rendererContext.cgContext.setFillColor(color.cgColor)
            rendererContext.fill(.init(origin: .zero, size: size))
        }).cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

extension ViewController {
    func makeTwinImage(color1: UIColor, color2: UIColor, size: CGSize) -> UIImage? {
        
        /// １つ目の画像
        guard let image1 = UIImage(color: color1, size: .init(width: 10, height: 10)) else { return nil }
        /// ２つ目の画像
        guard let image2 = UIImage(color: color2, size: .init(width: 10, height: 10)) else { return nil }
        
        /// ベースの画像
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        /// サイズに応じて繰り返す
        for _height in stride(from: 0, to: Int(size.height), by: 3) {
            let image1Rect = CGRect(x: 0.0, y: Double(_height), width: 1.0, height: 1.0)
            image1.draw(in: image1Rect, blendMode: .normal, alpha: 1)
            let image2Rect = CGRect(x: 0.0, y: Double(_height + 1), width: 1.0, height: 2.0)
            image2.draw(in: image2Rect, blendMode: .normal, alpha: 1)
        }
        
        let retImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return retImage
    }
}

extension SCNCylinder {
    convenience init(radius: Double, height: Double, color1: UIColor, color2: UIColor) {
        self.init(radius: radius, height: height)
        if let _image = makeTwinImage(color1: color1, color2: color2) {
            let _radialMat = toMaterial(image: _image)
            let _othMat = SCNMaterial()
            _othMat.diffuse.contents = color1
            self.materials = [_radialMat, _othMat, _othMat]
        }
    }
    
    private func makeTwinImage(color1: UIColor, color2: UIColor) -> UIImage? {
        let _size = CGSize(width: 1, height: (self.height / 2 * 100))
        /// １つ目の画像
        guard let image1 = UIImage(color: color1, size: .init(width: 10, height: 10)) else { return nil }
        /// ２つ目の画像
        guard let image2 = UIImage(color: color2, size: .init(width: 10, height: 10)) else { return nil }
        /// ベースの画像
        UIGraphicsBeginImageContextWithOptions(_size, false, 0)
        /// サイズに応じて繰り返す
        for _height in stride(from: 0, to: Int(_size.height), by: 3) {
            let image1Rect = CGRect(x: 0.0, y: Double(_height), width: 1.0, height: 1.0)
            image1.draw(in: image1Rect, blendMode: .normal, alpha: 1)
            let image2Rect = CGRect(x: 0.0, y: Double(_height + 1), width: 1.0, height: 2.0)
            image2.draw(in: image2Rect, blendMode: .normal, alpha: 1)
        }
        /// 画像の生成
        let retImage = UIGraphicsGetImageFromCurrentImageContext()
        /// 終了
        UIGraphicsEndImageContext()
        
        return retImage
    }
    
    private func toMaterial(image: UIImage) -> SCNMaterial {
        let _mat = SCNMaterial()
        _mat.diffuse.contents = image
        return _mat
    }
}
