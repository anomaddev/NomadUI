# NomadUI migration guide

Use this when updating an app from the pre-streamline package to this release. Most `NMDColumn([.viewAttributes, .stackAttributes])` call sites compile unchanged. The items below are the ones that will not.

Work top to bottom. Search the old name, apply the new form, then build.

## 1. Quick search list

| Search | Replace |
|---|---|
| `NMDView(view:` | `NMDView([.viewAttributes(` … `)])` |
| `.cornerRadi(` | `.cornerRadius(` |
| `.palatte` | `.palette` |
| `forceNeutral(style:` | same call; type is now `NeutralColor` (use `.outline`, not `.color`) |
| `style: nil` / `color: nil` / `align: nil` on `NMDLabel` | omit the argument or pass a real value |
| `padding: nil` on `fitTo` / `centerOn` / `alignLeft` / `alignRight` | omit or pass `.zero` / `0` |
| `appleIDStateDidRevoked` | move Sign in with Apple handling into the app |
| `import NVActivityIndicatorView` (via NomadUI) | add that package yourself, or use `NMDActivityIndicator` |

Deprecated aliases still compile for `.cornerRadi(_:)` (static helper) and `RoutingController.palatte`. Treat them as temporary.

## 2. Source-breaking APIs

### `NMDView.init(view:)` was removed

The unlabeled attribute-list init is the only structural initializer.

```swift
// Before
let box = NMDView(view: [.backgroundColor(.primary.color), .cornerRadius(8)])

// After
let box = NMDView([
    .viewAttributes([
        .backgroundColor(.primary.color),
        .cornerRadius(8)
    ])
])
```

`NMDView(_ color:)` and `NMDView(_ attributes:)` are unchanged.

### Progress corner radius

```swift
// Before
.progressAttributes([.cornerRadi(6)])

// After
.progressAttributes([.cornerRadius(6)])
```

`.cornerRadi(6)` still works as `NMDProgressAttribute.cornerRadi(_:)` but is deprecated.

### Routing controller palette

```swift
// Before
routing.palatte = .defaultDark

// After
routing.palette = .defaultDark
```

### `forceNeutral` return type

`UIColor.forceNeutral(style:)` now returns `NeutralColor`, not `PrimaryColor`.

```swift
// Before — compiled, but was wrongly the error palette
let ink = UIColor.forceNeutral(style: .light).color
let onInk = UIColor.forceNeutral(style: .light).onColor

// After
let outline = UIColor.forceNeutral(style: .light).outline
let surface = UIColor.forceNeutral(style: .light).surfaceColor
let onSurface = UIColor.forceNeutral(style: .light).onSurfaceColor
```

If you were using `.color` / `.onColor` / `.containerColor` on the result, those members are gone. Map:

| Old `PrimaryColor` field (incorrect) | New `NeutralColor` field |
|---|---|
| `.color` | `.surfaceColor` or `.outline` |
| `.onColor` | `.onSurfaceColor` |
| `.containerColor` | `.surfaceColor` |
| `.onContainerColor` | `.onSurfaceColor` |

### Implicitly unwrapped defaults no longer take `nil`

These parameters are normal types with defaults. Passing `nil` is now a compile error.

**Labels**

```swift
// Before
NMDLabel("Title", style: nil, color: nil, align: nil, numberOfLines: nil)
Paragraph("Body", size: nil)
List(description: "Intro", fontSize: nil, listItems: nil)

// After — omit to keep the default
NMDLabel("Title")
Paragraph("Body")
List(description: "Intro", listItems: [])
```

**Header / footer helpers**

```swift
// Before
header.defaultLayout(title: "Section", insets: nil, style: nil)
header.centeredLayout(title: "OR", color: nil, style: nil)

// After
header.defaultLayout(title: "Section")
header.centeredLayout(title: "OR")
```

**Layout helpers**

```swift
// Before
child.fitTo(parent, padding: nil)
child.centerOn(parent, axis: nil)
child.sameWidth(as: parent, padding: nil)
child.alignRight(spacing: nil, to: parent)
label.changeTo("Hi", duration: nil)
view.fadeIn(with: nil)
NMDProgress([]).setProgress(0.5, duration: nil)

// After
child.fitTo(parent)
child.centerOn(parent)
child.sameWidth(as: parent)
child.alignRight(to: parent)
label.changeTo("Hi")
view.fadeIn()
NMDProgress([]).setProgress(0.5)
```

**Fonts and registration**

```swift
// Before
Font.Bold.getFont(size: 16, alternative: nil)
NomadUI.register(fonts: nil)

// After
Font.Bold.getFont(size: 16)
NomadUI.register()
```

**Controller actions**

`BasicController.endEditing(_:)` and `goBack(_:)` now take `Any`, not `Any!`. Selector usage (`#selector`) is unchanged. Only explicit `nil` senders break.

### `BasicController.appleIDStateDidRevoked` was removed

It was an empty stub. If a subclass or notification observer pointed at it, handle Sign in with Apple revocation in the app:

```swift
NotificationCenter.default.addObserver(
    self,
    selector: #selector(handleAppleIDRevoked),
    name: ASAuthorizationAppleIDProvider.credentialRevokedNotification,
    object: nil
)
```

### Exhaustive switches on attribute enums

New cases were added. If you `switch` on these types without `default`, the build fails until you add the new cases (or `default`).

| Type | New / changed cases |
|---|---|
| `NMDAttributeCategory` | `.scrollAttributes`, `.textFieldAttributes`, `.textViewAttributes`, `.switchAttributes`, `.sliderAttributes`, `.segmentedAttributes`, `.stepperAttributes`, `.activityAttributes`, `.tableAttributes`, `.collectionAttributes` |
| `NMDViewAttribute` | `.subviews`, `.accessibilityLabel`, `.accessibilityHint`, `.isAccessibilityElement` |
| `NMDLabelAttribute` | `.style(NMDLabelStyle, alternative:)` |
| `NMDButtonAttribute` | `.isEnabled`, `.isSelected`, `.disabledTitle`, `.highlightedTitle`, `.disabledIcon`, `.highlightedIcon` |
| `NMDStackAttribute` | `.arrangedSubviews` |
| `NMDImageViewAttribute` | `.optionalImage`, `.highlightedImage`, `.tint` |
| `NMDProgressAttribute` | `.cornerRadi` **case removed** — use `.cornerRadius` |

## 3. Package.swift

NomadUI no longer re-exports `NVActivityIndicatorView`. If the app imported that module only because NomadUI pulled it in:

```swift
.package(url: "https://github.com/ninjaprox/NVActivityIndicatorView.git", branch: "master")
```

For a loading spinner that stays in NomadUI, use `NMDActivityIndicator` (UIKit `UIActivityIndicatorView`).

`Defaults` is now a direct NomadUI dependency. You do not need to add it unless the app uses `Defaults` itself.

Social login assets ship with the package (`Assets.xcassets`). `UIButton.Configuration.FacebookLogin` / `GoogleLogin` / `AppleLogin` (iOS 15+) keep the same names.

## 4. Behavior changes (compiles, looks different)

Fix these only if a screen regresses.

### Theme colors

`forceSecondary` and `forceTertiary` used to return the **error** palette. They now return secondary and tertiary. If a screen was written against the bug, it will change color — that is the intended fix.

`NomadUI.main.overrideThemeStyle` is now applied in `UITheme.active()`. Setting it in development actually pins light or dark.

### Fonts

`Font.getFont` no longer `fatalError`s when a family does not include that weight. It falls back to Helvetica Neue, then the system font. Invalid weights render instead of crashing.

### Shadows and corner radius

`.shadowColor` / `.shadowOffset` / `.shadowRadius` / `.shadowOpacity` now apply. If any shadow attribute is set, `masksToBounds` is turned **off** so the shadow is visible.

`.cornerRadius` still sets `masksToBounds = true` when no shadow was configured. Rounded clips plus a shadow on the **same** layer still conflict in UIKit — put the fill on a child and the shadow on the parent if you need both.

`.frame` is applied as `view.frame` after init (it used to be ignored except for `super.init(frame:)`).

### Label font keys

`.font`, `.altfont`, and `.style` share the merge key `"font"`. A default font is dropped when the caller supplies any of those three. Passing two of them in the **same** caller list still applies both in order; last one wins for the `UIFont`.

### Cells

`NMDCell`, `NMDCellSwipeable`, and `NMDHeaderFooter` adopt `NMDElement`. The table-view designated init now runs `setup(defaultAttributes)` and `layout()`.

`layout()` sets `selectionStyle = .none` and the default background is `.background.color`. Subclasses that used the old empty init and set their own selection style in `awakeFromNib` / `init` should call `super` first, then override.

```swift
open class AccountCell: NMDCell {
    override open func layout() {
        super.layout()
        selectionStyle = .default
    }
}
```

### Progress types

`.rightToLeft`, `.centerOut`, and `.centerIn` now lay out. `.centerIn` draws two fills from the edges. Existing `.leftToRight` behavior is unchanged.

`setProgress` clamps to `0...1`. Values outside that range no longer produce a bar wider than the track.

### `init(coder:)`

`NMDProgress`, `Paragraph`, `SubHeader`, and `List` no longer `fatalError` in `init(coder:)`. Storyboard / nib instantiation will attempt to decode instead of crash.

## 5. What you can leave alone

These keep working:

- `NMDView([.viewAttributes(...)])`
- `NMDLabel("Title", style: .H2)`
- `NMDButton([.buttonAttributes([.title("Go")]), .labelAttributes([.text("Go")])])` — `.text` remains a title alias
- `NMDRow` / `NMDColumn` / `NMDStack` attribute lists
- `add(_:)` and `addArrangedSubviews(_:)`
- Cartography helpers (`fitTo`, `centerOn`, …) when you pass real values or rely on defaults
- `UIColor.primary` / `.background` / `.error` and the other semantic tokens
- `RoutingController` panel API other than the `palatte` rename
- Social login `UIButton.Configuration` statics

Optional new form for trees you used to build after init:

```swift
// Still valid
column.addArrangedSubviews(title, field, action)

// Also valid
NMDColumn([
    .stackAttributes([
        .spacing(16),
        .arrangedSubviews([title, field, action])
    ])
])
```

## 6. Suggested update order

1. Replace `NMDView(view:)` and `.cornerRadi(`.
2. Fix `forceNeutral` call sites and any exhaustive attribute switches.
3. Delete explicit `nil`s on former IUO parameters.
4. Build. Resolve remaining compile errors from the search list.
5. Smoke-test themed screens (secondary/tertiary/neutral), any view that sets both corner radius and shadow, progress bars that were not left-to-right, and custom `NMDCell` subclasses.
6. Rename `palatte` when convenient; the alias can wait.

## 7. Subclassing `NMD*` types

`NMDElement` is public. `defaultAttributes` is `open`. Custom subclasses should implement `apply(_:)` and call `setup(_:)` from `init`. If you previously copied the merge loop, delete it and use `applyMerged(_:)`.

```swift
open class CardView: NMDView {
    override open var defaultAttributes: [NMDAttributeCategory] {
        get {
            [
                .viewAttributes([
                    .backgroundColor(.background.surface),
                    .cornerRadius(12)
                ])
            ]
        }
        set { }
    }
}
```
