# NomadUI

A structural UIKit layer. You describe each view as typed attribute lists, then compose instances with stacks and layout helpers. There is no view-builder DSL and no declarative re-render loop.

## Install

```swift
dependencies: [
    .package(url: "https://github.com/anomaddev/NomadUI.git", branch: "main")
]
```

At launch, register bundled fonts you intend to use:

```swift
NomadUI.register(fonts: [.Raleway, .Rubik])
```

## Structural idea

Every `NMD*` element takes `[NMDAttributeCategory]`. Caller attributes override defaults by a string `value` key. Convenience inits compose those same attributes instead of setting UIKit properties on the side.

```swift
let title = NMDLabel("Welcome", style: .H2)
let field = NMDTextField([
    .textFieldAttributes([
        .placeholder("Email"),
        .keyboardType(.emailAddress)
    ])
])
let action = NMDButton([
    .buttonAttributes([.title("Continue")]),
    .labelAttributes([.textColor(.primary.onColor)]),
    .viewAttributes([.backgroundColor(.primary.color), .cornerRadius(8)])
])

let column = NMDColumn([
    .viewAttributes([
        .backgroundColor(.background.color),
        .cornerRadius(12),
        .subviews([])
    ]),
    .stackAttributes([
        .spacing(16),
        .arrangedSubviews([title, field, action])
    ])
])

column.fitTo(view, padding: .surrounding(vertical: 20, horizontal: 16))
```

`add(_:)` and `addArrangedSubviews(_:)` remain available when you want to compose after init.

## Elements

| Type | UIKit base | Category |
|---|---|---|
| `NMDView`, `Spacer` | `UIView` | `.viewAttributes` |
| `NMDLabel`, `Paragraph`, `SubHeader`, `List` | `UILabel` | `.labelAttributes` |
| `NMDButton` | `UIButton` | `.buttonAttributes` (label attrs style the title) |
| `NMDStack`, `NMDRow`, `NMDColumn` | `UIStackView` | `.stackAttributes` |
| `NMDImageView` | `UIImageView` | `.imageAttributes` |
| `NMDProgress` | custom track | `.progressAttributes` |
| `NMDScrollView` | `UIScrollView` | `.scrollAttributes` |
| `NMDTextField` | `UITextField` | `.textFieldAttributes` |
| `NMDTextView` | `UITextView` | `.textViewAttributes` |
| `NMDSwitch` | `UISwitch` | `.switchAttributes` |
| `NMDSlider` | `UISlider` | `.sliderAttributes` |
| `NMDSegmentedControl` | `UISegmentedControl` | `.segmentedAttributes` |
| `NMDStepper` | `UIStepper` | `.stepperAttributes` |
| `NMDActivityIndicator` | `UIActivityIndicatorView` | `.activityAttributes` |
| `NMDTableView`, `NMDCell`, `NMDHeaderFooter` | table types | `.tableAttributes` |
| `NMDCollectionView`, `NMDCollectionCell` | collection types | `.collectionAttributes` |

Shared view attributes (background, size, corners, shadows, accessibility, `subviews`) apply to every element.

## Theme

`NomadUI.main.theme` holds light and dark `UIPalette` tokens (primary, secondary, tertiary, success, warning, error, background, neutral). Resolve the active palette with semantic `UIColor` accessors:

```swift
view.backgroundColor = .background.color
title.textColor = .background.onColor
button.backgroundColor = .primary.color
```

`UIColor.forceSecondary(style:)` / `forceTertiary` / `forceNeutral` return that role from the light or dark palette. Set `NomadUI.main.overrideThemeStyle` to pin light or dark regardless of the persisted `Adaptive` setting.

## Extending

`NMDElement` is public. A custom view implements `defaultAttributes` and `apply(_:)`, then calls `setup(_:)` from `init`. New first-party controls add an attribute enum plus an `NMDAttributeCategory` case.

## Controllers

- `BasicController` — themed background, optional keyboard dismiss, `UITextFieldDelegate`
- `NavigationController` — hidden bar, `fadeTo(_:)`
- `RoutingController` — `FAPanels` side-menu host

## Migrating from earlier NomadUI

See [MIGRATION.md](MIGRATION.md) for breaking API replacements, exhaustive-switch updates, and behavior changes (theme colors, shadows, cells).

## Requirements

iOS 14+, Swift 5.9. Layout helpers use [Cartography](https://github.com/anomaddev/Cartography).
