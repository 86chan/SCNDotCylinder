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
    private weak var cTimer: Timer!
    private var texFlag: Bool = true
    private var cylinder = SCNCylinder()
    
    // Create a new scene
    let scene = SCNScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addScene()
        addLight()
        addCylinder()
        viewConfig()
        changeTimer()
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
        cylinder = SCNCylinder(radius: 0.01, height: 1, color1: .green, color2: .clear)
        cylinder.heightSegmentCount = 10
        
        let node = SCNNode(geometry: cylinder)
        
        node.position = SCNVector3(x: 0, y: 0, z: -0.5)
        node.simdRotate(by: simd_quatf(angle: .pi * 0.5,
                                       axis: simd_normalize(SIMD3(0, 0, 1))),
                        aroundTarget: SIMD3(0, 0, 0))
        
        scene.rootNode.addChildNode(node)
    }
    
    /// タイマーをセット
    func changeTimer() {
        cTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                      target:self,
                                      selector:#selector(textureChange),
                                      userInfo:nil,
                                      repeats:true)
    }
    
    /// シリンダーのテクスチャを切り替え
    @objc func textureChange() {
        if texFlag {
            cylinder.dotCylinder(color1: .green, color2: .clear)
            texFlag = false
        } else {
            cylinder.singleColorCylinder(color: .green)
            texFlag = true
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: - ARSCNViewDelegate
    
    
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
