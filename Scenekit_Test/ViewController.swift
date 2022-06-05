//
//  ViewController.swift
//  Scenekit_Test
//
//  Created by Haruo on 2022/05/31.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: SCNView!
    
    // Create a new scene
    let scene = SCNScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addScene()
        addLight()
        addCylinder()
        viewConfig()
    }
    
    /// Config
    func viewConfig() {
        sceneView.backgroundColor = .black
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.debugOptions = [
            .showLightExtents,
            .showCameras,
            .showLightInfluences,
            .showLightExtents
        ]
    }
    
    /// camera
    func addScene() {
        // Set the scene to the view
        sceneView.scene = scene
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 1)
        scene.rootNode.addChildNode(cameraNode)
    }
    
    /// Light
    func addLight() {
        let lightNode = SCNNode()
        let light1 = SCNLight()
        lightNode.light = light1
        light1.type = .ambient
        lightNode.position = SCNVector3(x: 0, y: 1, z: 1)
        
        scene.rootNode.addChildNode(lightNode)
    }
    
    /// Dot Cylinder
    func addCylinder() {
        let cylinder = SCNCylinder(radius: 0.01, height: 1, color1: .blue, color2: .clear)
        cylinder.heightSegmentCount = 10
//        let cylinderGeoSource = cylinder.sources
//        let cylinderGeoElement = cylinder.elements
////
//        let geoSo = cylinderGeoSource
//        let geoEl = cylinderGeoElement
////
//        let cylinderEX = SCNGeometry(sources: geoSo, elements: geoEl)
        
        let node = SCNNode(geometry: cylinder)
//        let node = SCNNode(geometry: cylinderEX)
        
//        let materialGreen = SCNMaterial()
//        materialGreen.diffuse.contents = UIColor.green
//        let materialYello = SCNMaterial()
//        materialYello.diffuse.contents = UIColor.yellow
//        let materialBlue = SCNMaterial()
//        materialBlue.diffuse.contents = UIColor.blue
//        let materialRed = SCNMaterial()
//        materialRed.diffuse.contents = UIColor.red
        
//        guard let _colorImage = makeTwinImage(color1: .green,
//                                              color2: .clear,
//                                              size: .init(width: 1, height: (cylinder.height / 2 * 100))) else { return }
        
//        let imageMat = SCNMaterial()
//        imageMat.diffuse.contents = _colorImage
//        node.geometry?.firstMaterial = material1
//        node.geometry?.firstMaterial = material2
        
//        node.geometry?.materials = [imageMat, materialGreen, materialGreen]
//        cylinder.firstMaterial = imageMat
//        let mated = cylinder.materials
        
        node.position = SCNVector3(x: 0, y: 0, z: -0.5)
        node.simdRotate(by: simd_quatf(angle: .pi * 0.5,
                                       axis: simd_normalize(SIMD3(0, 0, 1))),
                        aroundTarget: SIMD3(0, 0, 0))
        scene.rootNode.addChildNode(node)
        
//        let _element = cylinder.elements
//        let _source = cylinder.sources
//        let geoElement = _element[0]
//        let geoSource = _source[0]
//        let geoElementData = geoElement.data
//        let geoSourceData = geoSource.data
//        let unGeoElementData: [Float] = geoElementData.withUnsafeBytes {
//            let _ary = UnsafeBufferPointer(start: $0.baseAddress?.assumingMemoryBound(to: Float.self),
//                                           count: $0.count / MemoryLayout<Float>.size)
//            return Array(_ary)
//        }
//        let unGeoSourceData: [Float] = geoSourceData.withUnsafeBytes {
//            let _ary = UnsafeBufferPointer(start: $0.baseAddress?.assumingMemoryBound(to: Float.self),
//                                           count: $0.count / MemoryLayout<Float>.size)
//            return Array(_ary)
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
//        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
//        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
//        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
