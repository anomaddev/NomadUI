import XCTest
@testable import NomadUI
import UIKit

final class AttributeMergeTests: XCTestCase {
    
    func testGivenAttributesOverrideDefaultsByValue() {
        let view = NMDView([
            .viewAttributes([
                .backgroundColor(.red),
                .alpha(0.4)
            ])
        ])
        
        XCTAssertEqual(view.backgroundColor, .red)
        XCTAssertEqual(view.alpha, 0.4, accuracy: 0.001)
    }
    
    func testDefaultsApplyWhenKeyIsOmitted() {
        let view = NMDView([])
        XCTAssertEqual(view.backgroundColor, UIColor.primary.color)
    }
    
    func testMergedAttributesDropsDefaultWhenCallerSuppliesSameKey() {
        let view = NMDView([
            .viewAttributes([.backgroundColor(.blue)])
        ])
        let merged = view.mergedAttributes([
            .viewAttributes([.backgroundColor(.blue)])
        ])
        
        let backgrounds = merged.compactMap { $0 as? NMDViewAttribute }.filter { $0.value == "backgroundColor" }
        XCTAssertEqual(backgrounds.count, 1)
    }
    
    func testViewFrameHelperReadsFrameAttribute() {
        let rect = CGRect(x: 1, y: 2, width: 3, height: 4)
        let categories: [NMDAttributeCategory] = [
            .viewAttributes([.frame(rect), .alpha(1)])
        ]
        XCTAssertEqual(categories.viewFrame, rect)
    }
}

final class ThemeTests: XCTestCase {
    
    override func tearDown() {
        NomadUI.main.overrideThemeStyle = nil
        super.tearDown()
    }
    
    func testForceSecondaryUsesSecondaryPalette() {
        let light = UIColor.forceSecondary(style: .light)
        XCTAssertEqual(light.color, NomadUI.main.theme.light.secondary.color)
        
        let dark = UIColor.forceSecondary(style: .dark)
        XCTAssertEqual(dark.color, NomadUI.main.theme.dark.secondary.color)
    }
    
    func testForceTertiaryUsesTertiaryPalette() {
        let light = UIColor.forceTertiary(style: .light)
        XCTAssertEqual(light.color, NomadUI.main.theme.light.tertiary.color)
    }
    
    func testForceNeutralUsesNeutralPalette() {
        let light = UIColor.forceNeutral(style: .light)
        XCTAssertEqual(light.outline, NomadUI.main.theme.light.neutral.outline)
        
        let dark = UIColor.forceNeutral(style: .dark)
        XCTAssertEqual(dark.outline, NomadUI.main.theme.dark.neutral.outline)
    }
    
    func testThemeOverridePinsActivePalette() {
        NomadUI.main.overrideThemeStyle = .dark
        XCTAssertEqual(NomadUI.main.theme.active().adaptive, .dark)
        
        NomadUI.main.overrideThemeStyle = .light
        XCTAssertEqual(NomadUI.main.theme.active().adaptive, .light)
    }
}

final class StackAndChildrenTests: XCTestCase {
    
    func testColumnDefaults() {
        let column = NMDColumn([])
        XCTAssertEqual(column.axis, .vertical)
        XCTAssertEqual(column.distribution, .fill)
        XCTAssertEqual(column.alignment, .fill)
        XCTAssertEqual(column.spacing, 10)
    }
    
    func testRowForcesHorizontalAxis() {
        let row = NMDRow([])
        XCTAssertEqual(row.axis, .horizontal)
    }
    
    func testSubviewAttributeAddsChildren() {
        let child = UIView()
        let parent = NMDView([
            .viewAttributes([.subviews([child])])
        ])
        XCTAssertTrue(parent.subviews.contains(child))
    }
    
    func testArrangedSubviewsAttributeAddsChildren() {
        let child = UIView()
        let stack = NMDColumn([
            .stackAttributes([.arrangedSubviews([child])])
        ])
        XCTAssertEqual(stack.arrangedSubviews.count, 1)
        XCTAssertTrue(stack.arrangedSubviews.contains(child))
    }
}

final class ControlAttributeTests: XCTestCase {
    
    func testLabelConvenienceInit() {
        let label = NMDLabel("Hello", style: .H2, color: .red, align: .center)
        XCTAssertEqual(label.text, "Hello")
        XCTAssertEqual(label.textColor, .red)
        XCTAssertEqual(label.textAlignment, .center)
    }
    
    func testButtonTitleAndEnabled() {
        let button = NMDButton([
            .buttonAttributes([
                .title("Go"),
                .isEnabled(false),
                .disabledTitle("Wait")
            ])
        ])
        XCTAssertEqual(button.title(for: .normal), "Go")
        XCTAssertEqual(button.title(for: .disabled), "Wait")
        XCTAssertFalse(button.isEnabled)
    }
    
    func testButtonLabelTextIsTitleAlias() {
        let button = NMDButton([
            .labelAttributes([.text("Alias")])
        ])
        XCTAssertEqual(button.title(for: .normal), "Alias")
    }
    
    func testImageViewDefaultContentMode() {
        let image = NMDImageView([])
        XCTAssertEqual(image.contentMode, .scaleAspectFit)
    }
    
    func testTextFieldAttributes() {
        let field = NMDTextField([
            .textFieldAttributes([
                .placeholder("Email"),
                .keyboardType(.emailAddress),
                .isSecureTextEntry(true)
            ])
        ])
        XCTAssertEqual(field.placeholder, "Email")
        XCTAssertEqual(field.keyboardType, .emailAddress)
        XCTAssertTrue(field.isSecureTextEntry)
        XCTAssertEqual(field.borderStyle, .roundedRect)
    }
    
    func testTextViewAttributes() {
        let textView = NMDTextView([
            .textViewAttributes([
                .text("Notes"),
                .isEditable(false)
            ])
        ])
        XCTAssertEqual(textView.text, "Notes")
        XCTAssertFalse(textView.isEditable)
    }
    
    func testSwitchSliderStepper() {
        let toggle = NMDSwitch([
            .switchAttributes([.isOn(true)])
        ])
        XCTAssertTrue(toggle.isOn)
        
        let slider = NMDSlider([
            .sliderAttributes([.value(0.25), .minimumValue(0), .maximumValue(1)])
        ])
        XCTAssertEqual(slider.value, 0.25, accuracy: 0.001)
        
        let stepper = NMDStepper([
            .stepperAttributes([.value(5), .stepValue(2)])
        ])
        XCTAssertEqual(stepper.value, 5)
        XCTAssertEqual(stepper.stepValue, 2)
    }
    
    func testSegmentedControlItems() {
        let control = NMDSegmentedControl([
            .segmentedAttributes([
                .items(["One", "Two"]),
                .selectedIndex(1)
            ])
        ])
        XCTAssertEqual(control.numberOfSegments, 2)
        XCTAssertEqual(control.titleForSegment(at: 0), "One")
        XCTAssertEqual(control.selectedSegmentIndex, 1)
    }
    
    func testActivityIndicator() {
        let spinner = NMDActivityIndicator([
            .activityAttributes([
                .isAnimating(true),
                .hidesWhenStopped(true)
            ])
        ])
        XCTAssertTrue(spinner.isAnimating)
        XCTAssertTrue(spinner.hidesWhenStopped)
    }
    
    func testScrollViewAttributes() {
        let scroll = NMDScrollView([
            .scrollAttributes([
                .isPagingEnabled(true),
                .showsHorizontalScrollIndicator(false)
            ])
        ])
        XCTAssertTrue(scroll.isPagingEnabled)
        XCTAssertFalse(scroll.showsHorizontalScrollIndicator)
    }
    
    func testTableAndCollectionDefaults() {
        let table = NMDTableView([])
        XCTAssertEqual(table.estimatedRowHeight, 44)
        XCTAssertEqual(table.rowHeight, UITableView.automaticDimension)
        
        let collection = NMDCollectionView([
            .collectionAttributes([
                .itemSize(CGSize(width: 50, height: 50)),
                .scrollDirection(.horizontal)
            ])
        ])
        let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout
        XCTAssertEqual(layout?.itemSize, CGSize(width: 50, height: 50))
        XCTAssertEqual(layout?.scrollDirection, .horizontal)
    }
}

final class ViewChromeTests: XCTestCase {
    
    func testAccessibilityAttributes() {
        let view = NMDView([
            .viewAttributes([
                .accessibilityLabel("Box"),
                .accessibilityHint("Double tap"),
                .isAccessibilityElement(true)
            ])
        ])
        XCTAssertEqual(view.accessibilityLabel, "Box")
        XCTAssertEqual(view.accessibilityHint, "Double tap")
        XCTAssertTrue(view.isAccessibilityElement)
    }
    
    func testShadowDisablesMasksToBounds() {
        let view = NMDView([
            .viewAttributes([
                .cornerRadius(8),
                .shadowOpacity(0.4),
                .shadowRadius(6)
            ])
        ])
        XCTAssertEqual(view.layer.cornerRadius, 8)
        XCTAssertEqual(view.layer.shadowOpacity, 0.4)
        XCTAssertEqual(view.layer.shadowRadius, 6)
        XCTAssertFalse(view.layer.masksToBounds)
    }
    
    func testProgressAcceptsTypes() {
        let bar = NMDProgress([
            .progressAttributes([
                .type(.centerOut),
                .progress(0)
            ])
        ])
        XCTAssertNotNil(bar)
    }
}
