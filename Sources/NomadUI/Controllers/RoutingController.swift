//
//  RoutingController.swift
//
//
//  Created by Justin Ackermann on 3/26/24.
//

// Core iOS
import UIKit

// Utilities
import FAPanels
//import Cartography
//import NVActivityIndicatorView

open class RoutingController: FAPanelController {
    
    public static var defaultConfig: FAPanelConfigurations = {
        var configs = FAPanelConfigurations()
        configs.colorForTapView = UIColor.black.withAlphaComponent(0.1)
        configs.shouldAnimateWithPan = true
        configs.resizeLeftPanel = true
        configs.resizeRightPanel = true
        configs.canLeftSwipe = false
        configs.canRightSwipe = false
        configs.bounceOnLeftPanelOpen = false
        configs.bounceOnRightPanelOpen = true
        configs.maxAnimDuration = 0.25
        configs.centerPanelTransitionType = .crossDissolve
        configs.shadowColor = UIColor.clear.cgColor
        configs.unloadLeftPanel = false
        configs.unloadRightPanel = false
        configs.pusheSidePanels = false
        return configs
    }()
    
    open var leftMenuWidth: CGFloat {
        get { configs.leftPanelWidth }
        set { configs.leftPanelWidth = newValue }
    }

    open var rightMenuWidth: CGFloat {
        get { configs.rightPanelWidth }
        set { configs.rightPanelWidth = newValue }
    }
    
    public var palatte: UIPalette = NomadUI.main.theme.active()
    
    public var navigation: NavigationController?
    
    /// Override this method in subclasses to customize panel configurations before they're applied.
    /// This is called after copying from the default template but before applying default widths.
    open func configurePanelConfigs(_ configs: inout FAPanelConfigurations) {
        // Default implementation does nothing - subclasses can override to customize
    }
    
    init(withConfig configs: FAPanelConfigurations) {
        super.init()
        var configs = configs
        configurePanelConfigs(&configs)
        configs.leftPanelWidth = defaultLeftMenuWidth
        configs.rightPanelWidth = defaultRightMenuWidth
        self.configs = configs
        leftPanelPosition = .front
        rightPanelPosition = .back
    }
    
    override public init() {
        super.init()
        defaultSetup()
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = palatte.background.color
        
        
    }
    
    private func defaultSetup() {
        var configs = Self.defaultConfig
        configurePanelConfigs(&configs)
        configs.leftPanelWidth = defaultLeftMenuWidth
        configs.rightPanelWidth = defaultRightMenuWidth
        self.configs = configs
        leftPanelPosition = .front
        rightPanelPosition = .back
    }
    
    open var defaultLeftMenuWidth: CGFloat {
        return (UIScreen.main.bounds.width / 2) + 50
    }
    
    open var defaultRightMenuWidth: CGFloat {
        return UIScreen.main.bounds.width * 3/5
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

