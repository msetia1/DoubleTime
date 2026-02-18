<!--
Downloaded via https://llm.codes by @steipete on February 18, 2026 at 11:08 AM
Source URL: https://developer.apple.com/documentation/SwiftUI
Total pages processed: 199
URLs filtered: Yes
Content de-duplicated: Yes
Availability strings filtered: Yes
Code blocks only: No
-->

# https://developer.apple.com/documentation/SwiftUI

Framework

# SwiftUI

Declare the user interface and behavior for your app on every platform.

## Overview

SwiftUI provides views, controls, and layout structures for declaring your app’s user interface. The framework provides event handlers for delivering taps, gestures, and other types of input to your app, and tools to manage the flow of data from your app’s models down to the views and controls that users see and interact with.

Define your app structure using the `App` protocol, and populate it with scenes that contain the views that make up your app’s user interface. Create your own custom views that conform to the `View` protocol, and compose them with SwiftUI views for displaying text, images, and custom shapes using stacks, lists, and more. Apply powerful modifiers to built-in views and your own views to customize their rendering and interactivity. Share code between apps on multiple platforms with views and controls that adapt to their context and presentation.

You can integrate SwiftUI views with objects from the UIKit, AppKit, and WatchKit frameworks to take further advantage of platform-specific functionality. You can also customize accessibility support in SwiftUI, and localize your app’s interface for different languages, countries, or cultural regions.

### Featured samples

![An image with a background of Mount Fuji, and in the foreground screenshots of the landmark detail view for Mount Fuji in the Landmarks app, in an iPad and iPhone.\\
\\
Landmarks: Building an app with Liquid Glass \\
\\
Enhance your app experience with system-provided and custom Liquid Glass.\\
\\
](https://developer.apple.com/documentation/swiftui/landmarks-building-an-app-with-liquid-glass)

![\\
\\
Destination Video \\
\\
Leverage SwiftUI to build an immersive media experience in a multiplatform app.\\
\\
](https://developer.apple.com/documentation/visionOS/destination-video)

![\\
\\
BOT-anist \\
\\
Build a multiplatform app that uses windows, volumes, and animations to create a robot botanist’s greenhouse.\\
\\
](https://developer.apple.com/documentation/visionOS/BOT-anist)

![A screenshot displaying the document launch experience on iPad with a robot and plant accessory to the left and right of the title view, respectively.\\
\\
Building a document-based app with SwiftUI \\
\\
Create, save, and open documents in a multiplatform app.\\
\\
](https://developer.apple.com/documentation/swiftui/building-a-document-based-app-with-swiftui)

## Topics

### Essentials

Adopting Liquid Glass

Find out how to bring the new material to your app.

Learning SwiftUI

Discover tips and techniques for building multiplatform apps with this set of conceptual articles and sample code.

Exploring SwiftUI Sample Apps

Explore these SwiftUI samples using Swift Playgrounds on iPad or in Xcode to learn about defining user interfaces, responding to user interactions, and managing data flow.

SwiftUI updates

Learn about important changes to SwiftUI.

Landmarks: Building an app with Liquid Glass

Enhance your app experience with system-provided and custom Liquid Glass.

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

### Data and storage

Manage the data that your app uses to drive its interface.

Share data throughout a view hierarchy using the environment.

Indicate configuration preferences from views to their container views.

Store data for use across sessions of your app.

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

### View layout

Arrange views inside built-in layout containers like stacks and grids.

Make fine adjustments to alignment, spacing, padding, and other layout parameters.

Place views in custom arrangements and create animated transitions between layout types.

Display a structured, scrollable column of information.

Display selectable, sortable data arranged in rows and columns.

Present views in different kinds of purpose-driven containers, like forms or control groups.

Enable people to scroll to content that doesn’t fit in the current display.

### Event handling

Define interactions from taps, clicks, and swipes to fine-grained gestures.

Respond to input from a hardware device, like a keyboard or a Touch Bar.

Enable people to move or duplicate items by issuing Copy and Paste commands.

Enable people to move or duplicate items by dragging them from one location to another.

Identify and control which visible object responds to user interaction.

React to system events, like opening a URL.

### Accessibility

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Enhance the legibility of content in your app’s interface.

Improve access to actions that your app can undertake.

Describe interface elements to help people understand what they represent.

Enable users to navigate to specific user interface elements using rotors.

### Framework integration

Add AppKit views to your SwiftUI app, or use SwiftUI views in your AppKit app.

Add UIKit views to your SwiftUI app, or use SwiftUI views in your UIKit app.

Add WatchKit views to your SwiftUI app, or use SwiftUI views in your WatchKit app.

Use SwiftUI views that other Apple frameworks provide.

### Tool support

Generate dynamic, interactive previews of your custom views.

Expose custom views and modifiers in the Xcode library.

Measure and improve your app’s responsiveness.

---

# https://developer.apple.com/documentation/swiftui/app

- SwiftUI
- App

Protocol

# App

A type that represents the structure and behavior of an app.

@MainActor @preconcurrency
protocol App

## Mentioned in

Migrating to the SwiftUI life cycle

## Overview

Create an app by declaring a structure that conforms to the `App` protocol. Implement the required `body` computed property to define the app’s content:

@main
struct MyApp: App {
var body: some Scene {
WindowGroup {
Text("Hello, world!")
}
}
}

Precede the structure’s declaration with the @main attribute to indicate that your custom `App` protocol conformer provides the entry point into your app. The protocol provides a default implementation of the `main()` method that the system calls to launch your app. You can have exactly one entry point among all of your app’s files.

Compose the app’s body from instances that conform to the `Scene` protocol. Each scene contains the root view of a view hierarchy and has a life cycle managed by the system. SwiftUI provides some concrete scene types to handle common scenarios, like for displaying documents or settings. You can also create custom scenes.

@main
struct Mail: App {
var body: some Scene {
WindowGroup {
MailViewer()
}
Settings {
SettingsView()
}
}
}

You can declare state in your app to share across all of its scenes. For example, you can use the `StateObject` attribute to initialize a data model, and then provide that model on a view input as an `ObservedObject` or through the environment as an `EnvironmentObject` to scenes in the app:

@main
struct Mail: App {
@StateObject private var model = MailModel()

var body: some Scene {
WindowGroup {
MailViewer()
.environmentObject(model) // Passed through the environment.
}
Settings {
SettingsView(model: model) // Passed as an observed object.
}
}
}

A type conforming to this protocol inherits `@preconcurrency @MainActor` isolation from the protocol if the conformance is included in the type’s base declaration:

struct MyCustomType: Transition {
// `@preconcurrency @MainActor` isolation by default
}

Isolation to the main actor is the default, but it’s not required. Declare the conformance in an extension to opt out of main actor isolation:

extension MyCustomType: Transition {
// `nonisolated` by default
}

## Topics

### Implementing an app

`var body: Self.Body`

The content and behavior of the app.

**Required**

`associatedtype Body : Scene`

The type of scene representing the content of the app.

### Running an app

`init()`

Creates an instance of the app using the body that you define for its content.

`static func main()`

Initializes and runs the app.

## See Also

### Creating an app

Destination Video

Leverage SwiftUI to build an immersive media experience in a multiplatform app.

Hello World

Use windows, volumes, and immersive spaces to teach people about the Earth.

Backyard Birds: Building an app with SwiftData and widgets

Create an app with persistent data, interactive widgets, and an all new in-app purchase experience.

Food Truck: Building a SwiftUI multiplatform app

Create a single codebase and app target for Mac, iPad, and iPhone.

Fruta: Building a feature-rich app with SwiftUI

Create a shared codebase to build a multiplatform app that offers widgets and an App Clip.

Use a scene-based life cycle in SwiftUI while keeping your existing codebase.

---

# https://developer.apple.com/documentation/swiftui/view

- SwiftUI
- View

Protocol

# View

A type that represents part of your app’s user interface and provides modifiers that you use to configure views.

@MainActor @preconcurrency
protocol View

## Mentioned in

Declaring a custom view

Configuring views

Reducing view modifier maintenance

Displaying data in lists

Migrating to the SwiftUI life cycle

## Overview

You create custom views by declaring types that conform to the `View` protocol. Implement the required `body` computed property to provide the content for your custom view.

struct MyView: View {
var body: some View {
Text("Hello, World!")
}
}

Assemble the view’s body by combining one or more of the built-in views provided by SwiftUI, like the `Text` instance in the example above, plus other custom views that you define, into a hierarchy of views. For more information about creating custom views, see Declaring a custom view.

The `View` protocol provides a set of modifiers — protocol methods with default implementations — that you use to configure views in the layout of your app. Modifiers work by wrapping the view instance on which you call them in another view with the specified characteristics, as described in Configuring views. For example, adding the `opacity(_:)` modifier to a text view returns a new view with some amount of transparency:

Text("Hello, World!")
.opacity(0.5) // Display partially transparent text.

The complete list of default modifiers provides a large set of controls for managing views. For example, you can fine tune Layout modifiers, add Accessibility modifiers information, and respond to Input and event modifiers. You can also collect groups of default modifiers into new, custom view modifiers for easy reuse.

A type conforming to this protocol inherits `@preconcurrency @MainActor` isolation from the protocol if the conformance is declared in its original declaration. Isolation to the main actor is the default, but it’s not required. Declare the conformance in an extension to opt-out the isolation.

## Topics

### Implementing a custom view

`var body: Self.Body`

The content and behavior of the view.

**Required** Default implementations provided.

`associatedtype Body : View`

The type of view representing the body of this view.

**Required**

Applies a modifier to a view and returns a new view.

Generate dynamic, interactive previews of your custom views.

### Configuring view elements

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Configure a view’s foreground and background styles, controls, and visibility.

Manage the rendering, selection, and entry of text in your view.

Add and configure supporting views, like toolbars and context menus.

Configure charts that you declare with Swift Charts.

### Drawing views

Apply built-in styles to different types of views.

Tell a view how to arrange itself within a view hierarchy by adjusting its size, position, alignment, padding, and so on.

Affect the way the system draws a view, for example by scaling or masking a view, or by applying graphical effects.

### Providing interactivity

Supply actions for a view to perform in response to user input and system events.

Enable people to search for content in your app.

Define additional views for the view to present under specified conditions.

Access storage and provide child views with configuration data.

### Deprecated modifiers

Review unsupported modifiers and their replacements.

### Instance Methods

Adds multiple accessibility actions to the view with a specific category. Actions allow assistive technologies, such as VoiceOver, to interact with the view by invoking the action and are grouped by their category. When multiple action modifiers with an equal category are applied to the view, the actions are combined together.

Defines a region in which default accessibility focus is evaluated by assigning a value to a given accessibility focus state binding.

`func accessibilityScrollStatus(_:isEnabled:)`

Changes the announcement provided by accessibility technologies when a user scrolls a scroll view within this view.

Sets the button’s style.

Sets the style to be used by the button. (see `PKAddPassButtonStyle`).

Configures gestures in this view hierarchy to handle events that activate the containing window.

Constrains this view’s dimensions to the specified 3D aspect ratio.

Configures the view’s icon for purposes of navigation.

`func attributedTextFormattingDefinition(_:)`

Apply a text formatting definition to nested views.

Presents a modal view that enables users to add devices to their organization.

Adds the background extension effect to the view. The view will be duplicated into mirrored copies which will be placed around the view on any edge with available safe area. Additionally, a blur effect will be applied on top to blur out the copies.

Ensures that the view is always visible to the user, even when other content is occluding it, like 3D models.

The preferred sizing behavior of buttons in the view hierarchy.

Displays a certificate sheet using the provided certificate trust.

`func chart3DPose(_:)`

Associates a binding to be updated when the 3D chart’s pose is changed by an interaction.

Sets the visibility of the z axis.

Configures the z-axis for 3D charts in the view.

`func chartZAxisLabel(_:position:alignment:spacing:)`

Adds z axis label for charts in the view. It effects 3D charts only.

Configures the z scale for 3D charts.

Modally present UI which allows the user to select which contacts your app has access to.

Adjusts the view’s layout to avoid the container view’s corner insets for the specified edges.

Sets a particular container value of a view.

`func contentToolbar(for:content:)`

Populates the toolbar of the specified content view type with the views you provide.

A `continuityDevicePicker` should be used to discover and connect nearby continuity device through a button interface or other form of activation. On tvOS, this presents a fullscreen continuity device picker experience when selected. The modal view covers as much the screen of `self` as possible when a given condition is true.

`func controlWidgetActionHint(_:)`

The action hint of the control described by the modified label.

`func controlWidgetStatus(_:)`

The status of the control described by the modified label.

Declares the view as dependent on the entitlement of an In-App Purchase product, and returns a modified view.

Whether the alert or confirmation dialog prevents the app from being quit/terminated by the system or app termination menu item.

Adds to a `DocumentLaunchView` actions that accept a list of selected files as their parameter.

Configures a drag session.

`func dragContainer(for:in:_:)`

A container with draggable views where the drag payload is based on multiple identifiers of dragged items.

`func dragContainer(for:itemID:in:_:)`

A container with draggable views.

Provides multiple item selection support for drag containers.

Describes the way dragged previews are visually composed.

Activates this view as the source of a drag and drop operation, allowing to provide optional identifiable payload and specify the namespace of the drag container this view belongs to.

Activates this view as the source of a drag and drop operation, allowing to provide optional payload and specify the namespace of the drag container this view belongs to.

Inside a drag container, activates this view as the source of a drag and drop operation. Supports lazy drag containers.

Configures a drop session.

Defines the destination of a drag and drop operation that provides a drop operation proposal and handles the dropped content with a closure that you specify.

Describes the way previews for a drop are composed.

Present an activity picker sheet for selecting apps and websites to manage.

Sets the style for forms in a view hierarchy.

Presents a modal view while the game synced directory loads.

Fills the view’s background with a custom glass background effect and container-relative rounded rectangle shape.

Fills the view’s background with a custom glass background effect and a shape that you specify.

Applies the Liquid Glass effect to a view.

Associates an identity value to Liquid Glass effects defined within this view.

Associates a glass effect transition with any glass effects defined within this view.

Associates any Liquid Glass effects defined within this view to a union with the provided identifier.

Specifies how a view should be associated with the current SharePlay group activity.

Assigns a hand gesture shortcut to the modified control.

Sets the behavior of the hand pointer while the user is interacting with the view.

Specifies the game controllers events which should be delivered through the GameController framework when the view, or one of its descendants has focus.

Specifies the game controllers events which should be delivered through the GameController framework when the view or one of its descendants has focus.

Asynchronously requests permission to read a data type that requires per-object authorization (such as vision prescriptions).

Requests permission to read the specified HealthKit data types.

Requests permission to save and read the specified HealthKit data types.

Sets the generation style for an image playground.

Policy determining whether to support the usage of people in the playground or not.

Presents the system sheet to create images from the specified input.

Add menu items to open immersive spaces from a media player’s environment picker.

Add a function to call before initiating a purchase from StoreKit view within this view, providing a set of options for the purchase.

Presents a visual picker interface that contains events and images that a person can select to retrieve more information.

Set the spacing between the icon and title in labels.

Set the width reserved for icons in labels.

Sets a style for labeled content.

Controls the visibility of labels of any controls contained within this view.

A modifier for the default line height in the view hierarchy.

Sets the insets of rows in a list on the specified edges.

Changes the visibility of the list section index.

Set the section margins for the specific edges.

Applies a managed content style to the view.

Allows this view to be manipulated using common hand gestures.

Applies the given 3D affine transform to the view and allows it to be manipulated using common hand gestures.

Allows the view to be manipulated using a manipulation gesture attached to a different view.

Adds a manipulation gesture to this view without allowing this view to be manipulable itself.

Uses the given keyframes to animate the camera of a `Map` when the given trigger value changes.

Configures all Map controls in the environment to have the specified visibility

Configures all `Map` views in the associated environment to have standard size and position controls

Specifies the selection accessory to display for a `MapFeature`

Specifies a custom presentation for the currently selected feature.

Specifies which map features should have selection disabled.

Presents a map item detail popover.

Presents a map item detail sheet.

Creates a mapScope that SwiftUI uses to connect map controls to an associated map.

Specifies the map style to be used.

Identifies this view as the source of a navigation transition, such as a zoom transition.

Sets an explicit active appearance for materials in this view.

A modifier for the default text alignment strategy in the view hierarchy.

Configures whether navigation links show a disclosure indicator.

Sets the navigation transition style for this view.

Registers a handler to invoke in response to the specified app intent that your app receives.

Called when a user has entered or updated a coupon code. This is required if the user is being asked to provide a coupon code.

Called when a payment method has changed and asks for an update payment request. If this modifier isn’t provided Wallet will assume the payment method is valid.

Called when a user selected a shipping address. This is required if the user is being asked to provide a shipping contact.

Called when a user selected a shipping method. This is required if the user is being asked to provide a shipping method.

`func onCameraCaptureEvent(isEnabled:defaultSoundDisabled:action:)`

Used to register an action triggered by system capture events.

`func onCameraCaptureEvent(isEnabled:defaultSoundDisabled:primaryAction:secondaryAction:)`

Used to register actions triggered by system capture events.

Specifies an action to perform on each update of an ongoing dragging operation activated by `draggable(_:)` or anther drag modifiers.

Specifies an action to perform on each update of an ongoing drop operation activated by `dropDestination(_:)` or other drop modifiers.

`func onGeometryChange3D(for:of:action:)`

Returns a new view that arranges to call `action(value)` whenever the value computed by `transform(proxy)` changes, where `proxy` provides access to the view’s 3D geometry properties.

Add an action to perform when a purchase initiated from a StoreKit view within this view completes.

Add an action to perform when a user triggers the purchase button on a StoreKit view within this view.

Adds an action to perform when the enclosing window is being interactively resized.

`func onMapCameraChange(frequency:_:)`

Performs an action when Map camera framing changes

Sets an `OpenURLAction` that prefers opening URL with an in-app browser. It’s equivalent to calling `.onOpenURL(_:)`

`func onWorldRecenter(action:)`

Adds an action to perform when recentering the view with the digital crown.

Sets the action on the PayLaterView. See `PKPayLaterAction`.

Sets the display style on the PayLaterView. See `PKPayLaterDisplayStyle`.

Sets the features that should be allowed to show on the payment buttons.

Sets the style to be used by the button. (see `PayWithApplePayButtonStyle`).

Presents a popover tip on the modified view.

`func postToPhotosSharedAlbumSheet(isPresented:items:photoLibrary:defaultAlbumIdentifier:completion:)`

Presents an “Add to Shared Album” sheet that allows the user to post the given items to a shared album.

Selects a subscription offer to apply to a purchase that a customer makes from a subscription store view, a store view, or a product view.

`func preferredWindowClippingMargins(_:_:)`

Requests additional margins for drawing beyond the bounds of the window.

Changes the way the enclosing presentation breaks through content occluding it.

Whether a presentation prevents the app from being terminated/quit by the system or app termination menu item.

Configure the visibility of labels displaying an in-app purchase product description within the view.

Adds a standard border to an in-app purchase product’s icon .

Sets the style for In-App Purchase product views within a view.

Adds gestures that control the position and direction of a virtual camera.

A view modifier that controls the frame sizing and content alignment behavior for `RealityView`

Rotates a view with impacts to its frame in a containing layout

`func rotation3DLayout(_:axis:)`

`func safeAreaBar(edge:alignment:spacing:content:)`

Shows the specified content as a custom bar beside the modified view.

Scales this view to fill its parent.

Scales this view to fit its parent.

Hides any scroll edge effects for scroll views within this hierarchy.

Configures the scroll edge effect style for scroll views within this hierarchy.

Enables or disables scrolling in scrollable views when using particular inputs.

Binds the selection of the search field associated with the nearest searchable modifier to the given `TextSelection` value.

Configures the behavior for search in the toolbar.

`func sectionIndexLabel(_:)`

Sets the label that is used in a section index to point to this section, typically only a single character long.

Sets the style used for displaying the control (see `SignInWithAppleButton.Style`).

Sets the thumb visibility for `Slider`s within this view.

Adds secondary views within the 3D bounds of this view.

Uses the specified preference value from the view to produce another view occupying the same 3D space of the first view.

Specifies the visibility of auxiliary buttons that store view and subscription store view instances may use.

Declares the view as dependent on an In-App Purchase product and returns a modified view.

Declares the view as dependent on a collection of In-App Purchase products and returns a modified view.

Selects the introductory offer eligibility preference to apply to a purchase a customer makes from a subscription store view.

Selects a promotional offer to apply to a purchase a customer makes from a subscription store view.

Deprecated

Declares the view as dependent on the status of an auto-renewable subscription group, and returns a modified view.

Configures subscription store view instances within a view to use the provided button label.

`func subscriptionStoreControlBackground(_:)`

Set a standard effect to use for the background of subscription store view controls within the view.

Sets a view to use to decorate individual subscription options within a subscription store view.

Sets the control style for subscription store views within a view.

Sets the control style and control placement for subscription store views within a view.

Sets the style subscription store views within this view use to display groups of subscription options.

Sets the background style for picker items of the subscription store view instances within a view.

Sets the background shape and style for subscription store view picker items within a view.

Configures a view as the destination for a policy button action in subscription store views.

Configures a URL as the destination for a policy button action in subscription store views.

Sets the style for the and buttons within a subscription store view.

Sets the primary and secondary style for the and buttons within a subscription store view.

Adds an action to perform when a person uses the sign-in button on a subscription store view within a view.

Sets the color rendering mode for symbol images.

Sets the variable value mode mode for symbol images within this view.

Sets the behavior for tab bar minimization.

Places a view as the bottom accessory of the tab view.

Places a view as the bottom accessory of the tab view. Use this modifier to dynamically show and hide the accessory view.

Configures the activation and deactivation behavior of search in the search tab.

Adds a tabletop game to a view.

Supplies a closure which returns a new interaction whenever needed.

Adds a task to perform before this view appears or when a specified value changes.

`func textContentType(_:)`

Sets the text content type for this view, which the system uses to offer suggestions while the user enters text on macOS.

Define which system text formatting controls are available.

Returns a new view such that any text views within it will use `renderer` to draw themselves.

Sets the direction of a selection or cursor relative to a text character.

Sets a value for the specified tip anchor to be used to anchor a tip view to the `.bounds` of the view.

Sets the tip’s view background to a style. Currently this only applies to inline tips, not popover tips.

Controls whether people can interact with the view behind a presented tip.

Sets the corner radius for an inline tip view.

Sets the size for a tip’s image.

Sets the style for a tip’s image.

Sets the given style for TipView within the view hierarchy.

Hides an individual view within a control group toolbar item.

Presents a picker that selects a collection of transactions.

Provides a task to perform before this view appears

Presents a translation popover when a given condition is true.

Adds a task to perform before this view appears or when the translation configuration changes.

Adds a task to perform before this view appears or when the specified source or target languages change.

Sets the style to be used by the button. (see `PKIdentityButtonStyle`).

Determines whether horizontal swipe gestures trigger backward and forward page navigation.

Specifies the visibility of the webpage’s natural background color within this view.

Adds an item-based context menu to a WebView, replacing the default set of context menu items.

Determines whether a web view can display content full screen.

Determines whether pressing a link displays a preview of the destination for the link.

Determines whether magnify gestures change the view’s magnification.

Adds an action to be performed when a value, created from a scroll geometry, changes.

Enables or disables scrolling in web views when using particular inputs.

Associates a binding to a scroll position with the web view.

Determines whether to allow people to select or otherwise interact with text.

Sets the window anchor point used when the size of the view changes such that the window must resize.

Configures the visibility of the window toolbar when the window enters full screen mode.

Presents a preview of the workout contents as a modal sheet

A modifier for the default text writing direction strategy in the view hierarchy.

Specifies whether the system should show the Writing Tools affordance for text input views affected by the environment.

Specifies the Writing Tools behavior for text and text input in the environment.

## Relationships

### Inherited By

- `DynamicViewContent`
- `InsettableShape`
- `NSViewControllerRepresentable`
- `NSViewRepresentable`
- `RoundedRectangularShape`
- `Shape`
- `ShapeView`
- `UIViewControllerRepresentable`
- `UIViewRepresentable`
- `WKInterfaceObjectRepresentable`

### Conforming Types

- `AngularGradient`
- `AnyShape`
- `AnyView`
- `AsyncImage`
- `Button`
- `ButtonBorderShape`
- `ButtonStyleConfiguration.Label`
- `Canvas`
Conforms when `Symbols` conforms to `View`.

- `Capsule`
- `Circle`
- `Color`
- `ColorPicker`
- `ConcentricRectangle`
- `ContainerRelativeShape`
- `ContentUnavailableView`
- `ControlGroup`
- `ControlGroupStyleConfiguration.Content`
- `ControlGroupStyleConfiguration.Label`
- `DatePicker`
- `DatePickerStyleConfiguration.Label`
- `DebugReplaceableView`
- `DefaultButtonLabel`
- `DefaultDateProgressLabel`
- `DefaultDocumentGroupLaunchActions`
- `DefaultGlassEffectShape`
- `DefaultSettingsLinkLabel`
- `DefaultShareLinkLabel`
- `DefaultTabLabel`
- `DefaultWindowVisibilityToggleLabel`
- `DisclosureGroup`
- `DisclosureGroupStyleConfiguration.Content`
- `DisclosureGroupStyleConfiguration.Label`
- `Divider`
- `DocumentLaunchView`
- `EditButton`
- `EditableCollectionContent`
Conforms when `Content` conforms to `View`, `Data` conforms to `Copyable`, and `Data` conforms to `Escapable`.

- `Ellipse`
- `EllipticalGradient`
- `EmptyView`
- `EquatableView`
- `FillShapeView`
- `ForEach`
Conforms when `Data` conforms to `RandomAccessCollection`, `ID` conforms to `Hashable`, and `Content` conforms to `View`.

- `Form`
- `FormStyleConfiguration.Content`
- `Gauge`
- `GaugeStyleConfiguration.CurrentValueLabel`
- `GaugeStyleConfiguration.Label`
- `GaugeStyleConfiguration.MarkedValueLabel`
- `GaugeStyleConfiguration.MaximumValueLabel`
- `GaugeStyleConfiguration.MinimumValueLabel`
- `GeometryReader`
- `GeometryReader3D`
- `GlassBackgroundEffectConfiguration.Content`
- `GlassEffectContainer`
- `Grid`
Conforms when `Content` conforms to `View`.

- `GridRow`
Conforms when `Content` conforms to `View`.

- `Group`
Conforms when `Content` conforms to `View`.

- `GroupBox`
- `GroupBoxStyleConfiguration.Content`
- `GroupBoxStyleConfiguration.Label`
- `GroupElementsOfContent`
- `GroupSectionsOfContent`
- `HSplitView`
- `HStack`
- `HelpLink`
- `Image`
- `KeyframeAnimator`
- `Label`
- `LabelStyleConfiguration.Icon`
- `LabelStyleConfiguration.Title`
- `LabeledContent`
Conforms when `Label` conforms to `View` and `Content` conforms to `View`.

- `LabeledContentStyleConfiguration.Content`
- `LabeledContentStyleConfiguration.Label`
- `LabeledControlGroupContent`
- `LabeledToolbarItemGroupContent`
- `LazyHGrid`
- `LazyHStack`
- `LazyVGrid`
- `LazyVStack`
- `LinearGradient`
- `Link`
- `List`
- `Menu`
- `MenuButton`
- `MenuStyleConfiguration.Content`
- `MenuStyleConfiguration.Label`
- `MeshGradient`
- `ModifiedContent`
Conforms when `Content` conforms to `View` and `Modifier` conforms to `ViewModifier`.

- `MultiDatePicker`
- `NavigationLink`
- `NavigationSplitView`
- `NavigationStack`
- `NavigationView`
- `NewDocumentButton`
- `OffsetShape`
- `OutlineGroup`
Conforms when `Data` conforms to `RandomAccessCollection`, `ID` conforms to `Hashable`, `Parent` conforms to `View`, `Leaf` conforms to `View`, and `Subgroup` conforms to `View`.

- `OutlineSubgroupChildren`
- `PasteButton`
- `Path`
- `PhaseAnimator`
- `Picker`
- `PlaceholderContentView`
- `PresentedWindowContent`
- `PreviewModifierContent`
- `PrimitiveButtonStyleConfiguration.Label`
- `ProgressView`
- `ProgressViewStyleConfiguration.CurrentValueLabel`
- `ProgressViewStyleConfiguration.Label`
- `RadialGradient`
- `Rectangle`
- `RenameButton`
- `RotatedShape`
- `RoundedRectangle`
- `ScaledShape`
- `ScrollView`
- `ScrollViewReader`
- `SearchUnavailableContent.Actions`
- `SearchUnavailableContent.Description`
- `SearchUnavailableContent.Label`
- `Section`
Conforms when `Parent` conforms to `View`, `Content` conforms to `View`, and `Footer` conforms to `View`.

- `SectionConfiguration.Actions`
- `SecureField`
- `SettingsLink`
- `ShareLink`
- `Slider`
- `Spacer`
- `Stepper`
- `StrokeBorderShapeView`
- `StrokeShapeView`
- `SubscriptionView`
- `Subview`
- `SubviewsCollection`
- `SubviewsCollectionSlice`
- `TabContentBuilder.Content`
- `TabView`
- `Table`
- `Text`
- `TextEditor`
- `TextField`
- `TextFieldLink`
- `TimelineView`
Conforms when `Schedule` conforms to `TimelineSchedule` and `Content` conforms to `View`.

- `Toggle`
- `ToggleStyleConfiguration.Label`
- `TransformedShape`
- `TupleView`
- `UnevenRoundedRectangle`
- `VSplitView`
- `VStack`
- `ViewThatFits`
- `WindowVisibilityToggle`
- `ZStack`
- `ZStackContent3D`
Conforms when `Content` conforms to `View`.

## See Also

### Creating a view

Define views and assemble them into a view hierarchy.

`struct ViewBuilder`

A custom parameter attribute that constructs views from closures.

---

# https://developer.apple.com/documentation/swiftui/landmarks-building-an-app-with-liquid-glass

- SwiftUI
- Landmarks: Building an app with Liquid Glass

Sample Code

# Landmarks: Building an app with Liquid Glass

Enhance your app experience with system-provided and custom Liquid Glass.

Download

Xcode 26.0+

## Overview

Landmarks is a SwifUI app that demonstrates how to use the new dynamic and expressive design feature, Liquid Glass. The Landmarks app lets people explore interesting sites around the world. Whether it’s a national park near their home or a far-flung location on a different continent, the app provides a way for people to organize and mark their adventures and receive custom activity badges along the way. Landmarks runs on iPad, iPhone, and Mac.

Landmarks uses a `NavigationSplitView` to organize and navigate to content in the app, and demonstrates several key concepts to optimize the use of Liquid Glass:

- Stretching content behind the sidebar and inspector with the background extension effect.

- Extending horizontal scroll views under a sidebar or inspector.

- Leveraging the system-provided glass effect in toolbars.

- Applying Liquid Glass effects to custom interface elements and animations.

- Building a new app icon with Icon Composer.

The sample also demonstrates several techniques to use when changing window sizes, and for adding global search.

## Apply a background extension effect

The sample applies a background extension effect to the featured landmark header in the top view, and the main image in the landmark detail view. This effect extends and blurs the image under the sidebar and inspector when they’re open, creating a full edge-to-edge experience.

To achieve this effect, the sample creates and configures an `Image` that extends to both the leading and trailing edges of the containing view, and applies the `backgroundExtensionEffect()` modifier to the image. For the featured image, the sample adds an overlay with a headline and button after the modifier, so that only the image extends under the sidebar and inspector.

For more information, see Landmarks: Applying a background extension effect.

## Extend horizontal scrolling under the sidebar

Within each continent section in `LandmarksView`, an instance of `LandmarkHorizontalListView` shows a horizontally scrolling list of landmark views. When open, the landmark views can scroll underneath the sidebar or inspector.

To achieve this effect, the app aligns the scroll views next to the leading and trailing edges of the containing view.

For more information, see Landmarks: Extending horizontal scrolling under a sidebar or inspector.

## Refine the Liquid Glass in the toolbar

In `LandmarkDetailView`, the sample adds toolbar items for:

- sharing a landmark

- adding or removing a landmark from a list of Favorites

- adding or removing a landmark from Collections

- showing or hiding the inspector

The system applies Liquid Glass to toolbar items automatically:

The sample also organizes the toolbar into related groups, instead of having all the buttons in one group. For more information, see Landmarks: Refining the system provided Liquid Glass effect in toolbars.

## Display badges with Liquid Glass

Badges provide people with a visual indicator of the activities they’ve recorded in the Landmarks app. When a person completes all four activities for a landmark, they earn that landmark’s badge. The sample uses custom Liquid Glass elements with badges, and shows how to coordinate animations with Liquid Glass.

To create a custom Liquid Glass badge, Landmarks uses a view with an `Image` to display a system symbol image for the badge. The badge has a background hexagon `Image` filled with a custom color. The badge view uses the `glassEffect(_:in:)` modifier to apply Liquid Glass to the badge.

To demonstrate the morphing effect that the system provides with Liquid Glass animations, the sample organizes the badges and the toggle button into a `GlassEffectContainer`, and assigns each badge a unique `glassEffectID(_:in:)`.

For more information, see Landmarks: Displaying custom activity badges. For information about building custom views with Liquid Glass, see Applying Liquid Glass to custom views.

## Create the app icon with Icon Composer

Landmarks includes a dynamic and expressive app icon composed in Icon Composer. You build app icons with four layers that the system uses to produce specular highlights when a person moves their device, so that the icon responds as if light was reflecting off the glass. The Settings app allows people to personalize the icon by selecting light, dark, clear, or tinted variants of your app icon as well.

For more information on creating a new app icon, see Creating your app icon using Icon Composer.

## Topics

### App features

Landmarks: Applying a background extension effect

Configure an image to blur and extend under a sidebar or inspector panel.

Landmarks: Extending horizontal scrolling under a sidebar or inspector

Improve your horizontal scrollbar’s appearance by extending it under a sidebar or inspector.

Landmarks: Refining the system provided Liquid Glass effect in toolbars

Organize toolbars into related groupings to improve their appearance and utility.

Landmarks: Displaying custom activity badges

Provide people with a way to mark their adventures by displaying animated custom activity badges.

## See Also

### Essentials

Adopting Liquid Glass

Find out how to bring the new material to your app.

Learning SwiftUI

Discover tips and techniques for building multiplatform apps with this set of conceptual articles and sample code.

Exploring SwiftUI Sample Apps

Explore these SwiftUI samples using Swift Playgrounds on iPad or in Xcode to learn about defining user interfaces, responding to user interactions, and managing data flow.

SwiftUI updates

Learn about important changes to SwiftUI.

---

# https://developer.apple.com/documentation/swiftui/app-organization

Collection

- SwiftUI
- App organization

API Collection

# App organization

Define the entry point and top-level structure of your app.

## Overview

Describe your app’s structure declaratively, much like you declare a view’s appearance. Create a type that conforms to the `App` protocol and use it to enumerate the Scenes that represent aspects of your app’s user interface.

SwiftUI enables you to write code that works across all of Apple’s platforms. However, it also enables you to tailor your app to the specific capabilities of each platform. For example, if you need to respond to the callbacks that the system traditionally makes on a UIKit, AppKit, or WatchKit app’s delegate, define a delegate object and instantiate it in your app structure using an appropriate delegate adaptor property wrapper, like `UIApplicationDelegateAdaptor`.

For platform-specific design guidance, see Getting started in the Human Interface Guidelines.

## Topics

### Creating an app

Destination Video

Leverage SwiftUI to build an immersive media experience in a multiplatform app.

Hello World

Use windows, volumes, and immersive spaces to teach people about the Earth.

Backyard Birds: Building an app with SwiftData and widgets

Create an app with persistent data, interactive widgets, and an all new in-app purchase experience.

Food Truck: Building a SwiftUI multiplatform app

Create a single codebase and app target for Mac, iPad, and iPhone.

Fruta: Building a feature-rich app with SwiftUI

Create a shared codebase to build a multiplatform app that offers widgets and an App Clip.

Migrating to the SwiftUI life cycle

Use a scene-based life cycle in SwiftUI while keeping your existing codebase.

`protocol App`

A type that represents the structure and behavior of an app.

### Targeting iOS and iPadOS

`UILaunchScreen`

The user interface to show while an app launches.

`UILaunchScreens`

The user interfaces to show while an app launches in response to different URL schemes.

`struct UIApplicationDelegateAdaptor`

A property wrapper type that you use to create a UIKit app delegate.

### Targeting macOS

`struct NSApplicationDelegateAdaptor`

A property wrapper type that you use to create an AppKit app delegate.

### Targeting watchOS

`struct WKApplicationDelegateAdaptor`

A property wrapper that is used in `App` to provide a delegate from WatchKit.

`struct WKExtensionDelegateAdaptor`

A property wrapper type that you use to create a WatchKit extension delegate.

### Targeting tvOS

Creating a tvOS media catalog app in SwiftUI

Build standard content lockups and rows of content shelves for your tvOS app.

### Handling system recenter events

`enum WorldRecenterPhase`

A type that represents information associated with a phase of a system recenter event. Values of this type are passed to the closure specified in View.onWorldRecenter(action:).

## See Also

### App structure

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

---

# https://developer.apple.com/documentation/swiftui/scenes

Collection

- SwiftUI
- Scenes

API Collection

# Scenes

Declare the user interface groupings that make up the parts of your app.

## Overview

A scene represents a part of your app’s user interface that has a life cycle that the system manages. An `App` instance presents the scenes it contains, while each `Scene` acts as the root element of a `View` hierarchy.

The system presents scenes in different ways depending on the type of scene, the platform, and the context. A scene might fill the entire display, part of the display, a window, a tab in a window, or something else. In some cases, your app might also be able to display more than one instance of the scene at a time, like when a user simultaneously opens multiple windows based on a single `WindowGroup` declaration in your app. For more information about the primary built-in scene types, see Windows and Documents.

You configure scenes using modifiers, similar to how you configure views. For example, you can adjust the appearance of the window that contains a scene — if the scene happens to appear in a window — using the `windowStyle(_:)` modifier. Similarly, you can add menu commands that become available when the scene is in the foreground on certain platforms using the `commands(content:)` modifier.

## Topics

### Creating scenes

`protocol Scene`

A part of an app’s user interface with a life cycle managed by the system.

`struct SceneBuilder`

A result builder for composing a collection of scenes into a single composite scene.

### Monitoring scene life cycle

`var scenePhase: ScenePhase`

The current phase of the scene.

`enum ScenePhase`

An indication of a scene’s operational state.

### Managing a settings window

`struct Settings`

A scene that presents an interface for viewing and modifying an app’s settings.

`struct SettingsLink`

A view that opens the Settings scene defined by an app.

`struct OpenSettingsAction`

An action that presents the settings scene for an app.

`var openSettings: OpenSettingsAction`

A Settings presentation action stored in a view’s environment.

### Building a menu bar

Building and customizing the menu bar with SwiftUI

Provide a seamless, cross-platform user experience by building a native menu bar for iPadOS and macOS.

### Creating a menu bar extra

`struct MenuBarExtra`

A scene that renders itself as a persistent control in the system menu bar.

Sets the style for menu bar extra created by this scene.

`protocol MenuBarExtraStyle`

A specification for the appearance and behavior of a menu bar extra scene.

### Creating watch notifications

`struct WKNotificationScene`

A scene which appears in response to receiving the specified category of remote or local notifications.

## See Also

### App structure

Define the entry point and top-level structure of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

---

# https://developer.apple.com/documentation/swiftui/windows

Collection

- SwiftUI
- Windows

API Collection

# Windows

Display user interface content in a window or a collection of windows.

## Overview

The most common way to present a view hierarchy in your app’s interface is with a `WindowGroup`, which produces a platform-specific behavior and appearance.

On platforms that support it, people can open multiple windows from the group simultaneously. Each window relies on the same root view definition, but retains its own view state. On some platforms, you can also supplement your app’s user interface with a single-instance window using the `Window` scene type.

Configure windows using scene modifiers that you add to the window declaration, like `windowStyle(_:)` or `defaultPosition(_:)`. You can also indicate how to configure new windows that you present from a view hierarchy by adding the `presentedWindowStyle(_:)` view modifier to a view in the hierarchy.

For design guidance, see Windows in the Human Interface Guidelines.

## Topics

### Essentials

Customizing window styles and state-restoration behavior in macOS

Configure how your app’s windows look and function in macOS to provide an engaging and more coherent experience.

Bringing multiple windows to your SwiftUI app

Compose rich views by reacting to state changes and customize your app’s scene presentation and behavior on iPadOS and macOS.

### Creating windows

`struct WindowGroup`

A scene that presents a group of identically structured windows.

`struct Window`

A scene that presents its content in a single, unique window.

`struct UtilityWindow`

A specialized window scene that provides secondary utility to the content of the main scenes of an application.

`protocol WindowStyle`

A specification for the appearance and interaction of a window.

Sets the style for windows created by this scene.

### Styling the associated toolbar

Sets the style for the toolbar defined within this scene.

Sets the label style of items in a toolbar and enables user customization.

Sets the label style of items in a toolbar.

`protocol WindowToolbarStyle`

A specification for the appearance and behavior of a window’s toolbar.

### Opening windows

Presenting windows and spaces

Open and close the scenes that make up your app’s interface.

`var supportsMultipleWindows: Bool`

A Boolean value that indicates whether the current platform supports opening multiple windows.

`var openWindow: OpenWindowAction`

A window presentation action stored in a view’s environment.

`struct OpenWindowAction`

An action that presents a window.

`struct PushWindowAction`

An action that opens the requested window in place of the window the action is called from.

### Closing windows

`var dismissWindow: DismissWindowAction`

A window dismissal action stored in a view’s environment.

`struct DismissWindowAction`

An action that dismisses a window associated to a particular scene.

`var dismiss: DismissAction`

An action that dismisses the current presentation.

`struct DismissAction`

An action that dismisses a presentation.

`struct DismissBehavior`

Programmatic window dismissal behaviors.

### Sizing a window

Positioning and sizing windows

Influence the initial geometry of windows that your app presents.

`func defaultSize(_:)`

Sets a default size for a window.

Sets a default width and height for a window.

Sets a default size for a volumetric window.

Sets the kind of resizability to use for a window.

`struct WindowResizability`

The resizability of a window.

Specifies how windows derived form this scene should determine their size when zooming.

`struct WindowIdealSize`

A type which defines the size a window should use when zooming.

### Positioning a window

Sets a default position for a window.

`struct WindowLevel`

The level of a window.

Sets the window level of this scene.

`struct WindowLayoutRoot`

A proxy which represents the root contents of a window.

`struct WindowPlacement`

A type which represents a preferred size and position for a window.

Defines a function used for determining the default placement of windows.

Provides a function which determines a placement to use when windows of a scene zoom.

`struct WindowPlacementContext`

A type which represents contextual information used for sizing and positioning windows.

`struct WindowProxy`

The proxy for an open window in the app.

`struct DisplayProxy`

A type which provides information about display hardware.

### Configuring window visibility

`struct WindowVisibilityToggle`

A specialized button for toggling the visibility of a window.

Sets the default launch behavior for this scene.

Sets the restoration behavior for this scene.

`struct SceneLaunchBehavior`

The launch behavior for a scene.

`struct SceneRestorationBehavior`

The restoration behavior for a scene.

Sets the preferred visibility of the non-transient system views overlaying the app.

Configures the visibility of the window toolbar when the window enters full screen mode.

`struct WindowToolbarFullScreenVisibility`

The visibility of the window toolbar with respect to full screen mode.

### Managing window behavior

`struct WindowManagerRole`

Options for defining how a scene’s windows behave when used within a managed window context, such as full screen mode and Stage Manager.

Configures the role for windows derived from `self` when participating in a managed window context, such as full screen or Stage Manager.

`struct WindowInteractionBehavior`

Options for enabling and disabling window interaction behaviors.

Configures the dismiss functionality for the window enclosing `self`.

Configures the full screen functionality for the window enclosing `self`.

Configures the minimize functionality for the window enclosing `self`.

Configures the resize functionality for the window enclosing `self`.

Configures the behavior of dragging a window by its background.

### Interacting with volumes

Adds an action to perform when the viewpoint of the volume changes.

Specifies which viewpoints are supported for the window bar and ornaments in a volume.

`struct VolumeViewpointUpdateStrategy`

A type describing when the action provided to `onVolumeViewpointChange(updateStrategy:initial:_:)` should be called.

`struct Viewpoint3D`

A type describing what direction something is being viewed from.

`enum SquareAzimuth`

A type describing what direction something is being viewed from along the horizontal plane and snapped to 4 directions.

`struct WorldAlignmentBehavior`

A type representing the world alignment behavior for a scene.

Specifies how a volume should be aligned when moved in the world.

`struct WorldScalingBehavior`

Specifies the scaling behavior a window should have within the world.

Specify the world scaling behavior for the window.

`struct WorldScalingCompensation`

Indicates whether returned metrics will take dynamic scaling into account.

The current limitations of the device tracking the user’s surroundings.

`struct WorldTrackingLimitation`

A structure to represent limitations of tracking the user’s surroundings.

`struct SurfaceSnappingInfo`

A type representing information about the window scenes snap state.

### Deprecated Types

`enum ControlActiveState`

The active appearance expected of controls in a window.

Deprecated

## See Also

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

---

# https://developer.apple.com/documentation/swiftui/immersive-spaces

Collection

- SwiftUI
- Immersive spaces

API Collection

# Immersive spaces

Display unbounded content in a person’s surroundings.

## Overview

Use an immersive space in visionOS to present SwiftUI views outside of any containers. You can include any views in a space, although you typically use a `RealityView` to present RealityKit content.

You can request one of three styles of spaces with the `immersionStyle(selection:in:)` scene modifier:

- The `mixed` style blends your content with passthrough. This enables you to place virtual objects in a person’s surroundings.

- The `full` style displays only your content, with passthrough turned off. This enables you to completely control the visual experience, like when you want to transport people to a new world.

- The `progressive` style completely replaces passthrough in a portion of the display. You might use this style to keep people grounded in the real world while displaying a view into another world.

When you open an immersive space, the system continues to display all of your app’s windows, but hides windows from other apps. The system supports displaying only one space at a time across all apps, so your app can only open a space if one isn’t already open.

## Topics

### Creating an immersive space

`struct ImmersiveSpace`

A scene that presents its content in an unbounded space.

`struct ImmersiveSpaceContentBuilder`

A result builder for composing a collection of immersive space elements.

Sets the style for an immersive space.

`protocol ImmersionStyle`

The styles that an immersive space can have.

`var immersiveSpaceDisplacement: Pose3D`

The displacement that the system applies to the immersive space when moving the space away from its default position, in meters.

`struct ImmersiveEnvironmentBehavior`

The behavior of the system-provided immersive environments when a scene is opened by your app.

`struct ProgressiveImmersionAspectRatio`

### Opening an immersive space

`var openImmersiveSpace: OpenImmersiveSpaceAction`

An action that presents an immersive space.

`struct OpenImmersiveSpaceAction`

### Closing the immersive space

`var dismissImmersiveSpace: DismissImmersiveSpaceAction`

An immersive space dismissal action stored in a view’s environment.

`struct DismissImmersiveSpaceAction`

An action that dismisses an immersive space.

### Hiding upper limbs during immersion

Sets the preferred visibility of the user’s upper limbs, while an `ImmersiveSpace` scene is presented.

### Adjusting content brightness

Sets the content brightness of an immersive space.

`struct ImmersiveContentBrightness`

The content brightness of an immersive space.

### Responding to immersion changes

Performs an action when the immersion state of your app changes.

`struct ImmersionChangeContext`

A structure that represents a state of immersion of your app.

### Adding menu items to an immersive space

Add menu items to open immersive spaces from a media player’s environment picker.

### Handling remote immersive spaces

`struct RemoteImmersiveSpace`

A scene that presents its content in an unbounded space on a remote device.

`struct RemoteDeviceIdentifier`

An opaque type that identifies a remote device displaying scene content in a `RemoteImmersiveSpace`.

## See Also

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

---

# https://developer.apple.com/documentation/swiftui/documents

Collection

- SwiftUI
- Documents

API Collection

# Documents

Enable people to open and manage documents.

## Overview

Create a user interface for opening and editing documents using the `DocumentGroup` scene type.

You initialize the scene with a model that describes the organization of the document’s data, and a view hierarchy that SwiftUI uses to display the document’s contents to the user. You can use either a value type model, which you typically store as a structure, that conforms to the `FileDocument` protocol, or a reference type model you store in a class instance that conforms to the `ReferenceFileDocument` protocol. You can also use SwiftData-backed documents using an initializer like `init(editing:contentType:editor:prepareDocument:)`.

SwiftUI supports standard behaviors that users expect from a document-based app, appropriate for each platform, like multiwindow support, open and save panels, drag and drop, and so on. For related design guidance, see Patterns in the Human Interface Guidelines.

## Topics

### Creating a document

Building a document-based app with SwiftUI

Create, save, and open documents in a multiplatform app.

Building a document-based app using SwiftData

Code along with the WWDC presenter to transform an app with SwiftData.

`struct DocumentGroup`

A scene that enables support for opening, creating, and saving documents.

### Storing document data in a structure instance

`protocol FileDocument`

A type that you use to serialize documents to and from file.

`struct FileDocumentConfiguration`

The properties of an open file document.

### Storing document data in a class instance

`protocol ReferenceFileDocument`

A type that you use to serialize reference type documents to and from file.

`struct ReferenceFileDocumentConfiguration`

The properties of an open reference file document.

`var undoManager: UndoManager?`

The undo manager used to register a view’s undo operations.

### Accessing document configuration

`var documentConfiguration: DocumentConfiguration?`

The configuration of a document in a `DocumentGroup`.

`struct DocumentConfiguration`

### Reading and writing documents

`struct FileDocumentReadConfiguration`

The configuration for reading file contents.

`struct FileDocumentWriteConfiguration`

The configuration for serializing file contents.

### Opening a document programmatically

`var newDocument: NewDocumentAction`

An action in the environment that presents a new document.

`struct NewDocumentAction`

An action that presents a new document.

`var openDocument: OpenDocumentAction`

An action in the environment that presents an existing document.

`struct OpenDocumentAction`

An action that presents an existing document.

### Configuring the document launch experience

`struct DocumentGroupLaunchScene`

A launch scene for document-based applications.

`struct DocumentLaunchView`

A view to present when launching document-related user experience.

`struct DocumentLaunchGeometryProxy`

A proxy for access to the frame of the scene and its title view.

`struct DefaultDocumentGroupLaunchActions`

The default actions for the document group launch scene and the document launch view.

`struct NewDocumentButton`

A button that creates and opens new documents.

`protocol DocumentBaseBox`

A Box that allows setting its Document base not requiring the caller to know the exact types of the box and its base.

### Renaming a document

`struct RenameButton`

A button that triggers a standard rename action.

`func renameAction(_:)`

Sets a closure to run for the rename action.

`var rename: RenameAction?`

An action that activates the standard rename interaction.

`struct RenameAction`

An action that activates a standard rename interaction.

## See Also

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

---

# https://developer.apple.com/documentation/swiftui/navigation

Collection

- SwiftUI
- Navigation

API Collection

# Navigation

Enable people to move between different parts of your app’s view hierarchy within a scene.

## Overview

Use navigation containers to provide structure to your app’s user interface, enabling people to easily move among the parts of your app.

For example, people can move forward and backward through a stack of views using a `NavigationStack`, or choose which view to display from a tab bar using a `TabView`.

Configure navigation containers by adding view modifiers like `navigationSplitViewStyle(_:)` to the container. Use other modifiers on the views inside the container to affect the container’s behavior when showing that view. For example, you can use `navigationTitle(_:)` on a view to provide a toolbar title to display when showing that view.

## Topics

### Essentials

Understanding the navigation stack

Learn about the navigation stack, links, and how to manage navigation types in your app’s structure.

### Presenting views in columns

Bringing robust navigation structure to your SwiftUI app

Use navigation links, stacks, destinations, and paths to provide a streamlined experience for all platforms, as well as behaviors such as deep linking and state restoration.

Migrating to new navigation types

Improve navigation behavior in your app by replacing navigation views with navigation stacks and navigation split views.

`struct NavigationSplitView`

A view that presents views in two or three columns, where selections in leading columns control presentations in subsequent columns.

Sets the style for navigation split views within this view.

Sets a fixed, preferred width for the column containing this view.

Sets a flexible, preferred width for the column containing this view.

`struct NavigationSplitViewVisibility`

The visibility of the leading columns in a navigation split view.

`struct NavigationLink`

A view that controls a navigation presentation.

### Stacking views in one column

`struct NavigationStack`

A view that displays a root view and enables you to present additional views over the root view.

`struct NavigationPath`

A type-erased list of data representing the content of a navigation stack.

Associates a destination view with a presented data type for use within a navigation stack.

Associates a destination view with a binding that can be used to push the view onto a `NavigationStack`.

`func navigationDestination<D, C>(item: Binding<Optional<D>>, destination: (D) -> C) -> some View`

Associates a destination view with a bound value for use within a navigation stack or navigation split view

### Managing column collapse

`struct NavigationSplitViewColumn`

A view that represents a column in a navigation split view.

### Setting titles for navigation content

`func navigationTitle(_:)`

Configures the view’s title for purposes of navigation, using a string binding.

`func navigationSubtitle(_:)`

Configures the view’s subtitle for purposes of navigation.

`func navigationDocument(_:)`

Configures the view’s document for purposes of navigation.

`func navigationDocument(_:preview:)`

### Configuring the navigation bar

Hides the navigation bar back button for the view.

Configures the title display mode for this view.

`struct NavigationBarItem`

A configuration for a navigation bar that represents a view at the top of a navigation stack.

### Configuring the sidebar

`var sidebarRowSize: SidebarRowSize`

The current size of sidebar rows.

`enum SidebarRowSize`

The standard sizes of sidebar rows.

### Presenting views in tabs

Enhancing your app’s content with tab navigation

Keep your app content front and center while providing quick access to navigation using the tab bar.

`struct TabView`

A view that switches between multiple child views using interactive user interface elements.

`struct Tab`

The content for a tab and the tab’s associated tab item in a tab view.

`struct TabRole`

A value that defines the purpose of the tab.

`struct TabSection`

A container that you can use to add hierarchy within a tab view.

Sets the style for the tab view within the current environment.

### Configuring a tab bar

Specifies the default placement for the tabs in a tab view using the adaptable sidebar style.

Adds a custom header to the sidebar of a tab view.

Adds a custom footer to the sidebar of a tab view.

Adds a custom bottom bar to the sidebar of a tab view.

`struct AdaptableTabBarPlacement`

A placement for tabs in a tab view using the adaptable sidebar style.

`var tabBarPlacement: TabBarPlacement?`

The current placement of the tab bar.

`struct TabBarPlacement`

A placement for tabs in a tab view.

`var isTabBarShowingSections: Bool`

A Boolean value that determines whether a tab view shows the expanded contents of a tab section.

`struct TabBarMinimizeBehavior`

`enum TabViewBottomAccessoryPlacement`

A placement of the bottom accessory in a tab view. You can use this to adjust the content of the accessory view based on the placement.

### Configuring a tab

Adds custom actions to a section.

`struct TabPlacement`

A place that a tab can appear.

`struct TabContentBuilder`

A result builder that constructs tabs for a tab view that supports programmatic selection. This builder requires that all tabs in the tab view have the same selection type.

`protocol TabContent`

A type that provides content for programmatically selectable tabs in a tab view.

`struct AnyTabContent`

Type erased tab content.

### Enabling tab customization

Specifies the customizations to apply to the sidebar representation of the tab view.

`struct TabViewCustomization`

The customizations a person makes to an adaptable sidebar tab view.

`struct TabCustomizationBehavior`

The customization behavior of customizable tab view content.

### Displaying views in multiple panes

`struct HSplitView`

A layout container that arranges its children in a horizontal line and allows the user to resize them using dividers placed between them.

`struct VSplitView`

A layout container that arranges its children in a vertical line and allows the user to resize them using dividers placed between them.

### Deprecated Types

`struct NavigationView`

A view for presenting a stack of views that represents a visible path in a navigation hierarchy.

Deprecated

Sets the tab bar item associated with this view.

## See Also

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

---

# https://developer.apple.com/documentation/swiftui/modal-presentations

Collection

- SwiftUI
- Modal presentations

API Collection

# Modal presentations

Present content in a separate view that offers focused interaction.

## Overview

To draw attention to an important, narrowly scoped task, you display a modal presentation, like an alert, popover, sheet, or confirmation dialog.

In SwiftUI, you create a modal presentation using a view modifier that defines how the presentation looks and the condition under which SwiftUI presents it. SwiftUI detects when the condition changes and makes the presentation for you. Because you provide a `Binding` to the condition that initiates the presentation, SwiftUI can reset the underlying value when the user dismisses the presentation.

For design guidance, see Modality in the Human Interface Guidelines.

## Topics

### Configuring a dialog

`struct DialogSeverity`

The severity of an alert or confirmation dialog.

### Showing a sheet, cover, or popover

Presents a sheet when a binding to a Boolean value that you provide is true.

Presents a sheet using the given item as a data source for the sheet’s content.

Presents a modal view that covers as much of the screen as possible when binding to a Boolean value you provide is true.

Presents a modal view that covers as much of the screen as possible using the binding you provide as a data source for the sheet’s content.

Presents a popover using the given item as a data source for the popover’s content.

Presents a popover when a given condition is true.

`enum PopoverAttachmentAnchor`

An attachment anchor for a popover.

### Adapting a presentation size

Specifies how to adapt a presentation to horizontally and vertically compact size classes.

Specifies how to adapt a presentation to compact size classes.

`struct PresentationAdaptation`

Strategies for adapting a presentation to a different size class.

Sets the sizing of the containing presentation.

`protocol PresentationSizing`

A type that defines the size of the presentation content and how the presentation size adjusts to its content’s size changing.

`struct PresentationSizingRoot`

A proxy to a view provided to the presentation with a defined presentation size.

`struct PresentationSizingContext`

Contextual information about a presentation.

### Configuring a sheet’s height

Sets the available detents for the enclosing sheet.

Sets the available detents for the enclosing sheet, giving you programmatic control of the currently selected detent.

Configures the behavior of swipe gestures on a presentation.

Sets the visibility of the drag indicator on top of a sheet.

`struct PresentationDetent`

A type that represents a height where a sheet naturally rests.

`protocol CustomPresentationDetent`

The definition of a custom detent with a calculated height.

`struct PresentationContentInteraction`

A behavior that you can use to influence how a presentation responds to swipe gestures.

### Styling a sheet and its background

Requests that the presentation have a specific corner radius.

Sets the presentation background of the enclosing sheet using a shape style.

Sets the presentation background of the enclosing sheet to a custom view.

Controls whether people can interact with the view behind a presentation.

`struct PresentationBackgroundInteraction`

The kinds of interaction available to views behind a presentation.

### Presenting an alert

`struct AlertScene`

A scene that renders itself as a standalone alert dialog.

`func alert(_:isPresented:actions:)`

Presents an alert when a given condition is true, using a text view for the title.

`func alert(_:isPresented:presenting:actions:)`

Presents an alert using the given data to produce the alert’s content and a text view as a title.

Presents an alert when an error is present.

`func alert(_:isPresented:actions:message:)`

Presents an alert with a message when a given condition is true using a text view as a title.

`func alert(_:isPresented:presenting:actions:message:)`

Presents an alert with a message using the given data to produce the alert’s content and a text view for a title.

Presents an alert with a message when an error is present.

### Getting confirmation for an action

`func confirmationDialog(_:isPresented:titleVisibility:actions:)`

Presents a confirmation dialog when a given condition is true, using a text view for the title.

`func confirmationDialog(_:isPresented:titleVisibility:presenting:actions:)`

Presents a confirmation dialog using data to produce the dialog’s content and a text view for the title.

`func dismissalConfirmationDialog(_:shouldPresent:actions:)`

Presents a confirmation dialog when a dismiss action has been triggered.

### Showing a confirmation dialog with a message

`func confirmationDialog(_:isPresented:titleVisibility:actions:message:)`

Presents a confirmation dialog with a message when a given condition is true, using a text view for the title.

`func confirmationDialog(_:isPresented:titleVisibility:presenting:actions:message:)`

Presents a confirmation dialog with a message using data to produce the dialog’s content and a text view for the message.

`func dismissalConfirmationDialog(_:shouldPresent:actions:message:)`

### Configuring a dialog

Configures the icon used by dialogs within this view.

Configures the icon used by alerts.

Sets the severity for alerts.

Enables user suppression of dialogs and alerts presented within `self`, with a default suppression message on macOS. Unused on other platforms.

Enables user suppression of an alert with a custom suppression message.

`func dialogSuppressionToggle(_:isSuppressed:)`

Enables user suppression of dialogs and alerts presented within `self`, with a custom suppression message on macOS. Unused on other platforms.

### Exporting to file

`func fileExporter(isPresented:document:contentType:defaultFilename:onCompletion:)`

Presents a system interface for exporting a document that’s stored in a value type, like a structure, to a file on disk.

`func fileExporter(isPresented:documents:contentType:onCompletion:)`

Presents a system interface for exporting a collection of value type documents to files on disk.

`func fileExporter(isPresented:document:contentTypes:defaultFilename:onCompletion:onCancellation:)`

Presents a system interface for allowing the user to export a `FileDocument` to a file on disk.

`func fileExporter(isPresented:documents:contentTypes:onCompletion:onCancellation:)`

Presents a system dialog for allowing the user to export a collection of documents that conform to `FileDocument` to files on disk.

Presents a system interface allowing the user to export a `Transferable` item to file on disk.

Presents a system interface allowing the user to export a collection of items to files on disk.

`func fileExporterFilenameLabel(_:)`

On macOS, configures the `fileExporter` with a label for the file name field.

### Importing from file

Presents a system interface for allowing the user to import multiple files.

Presents a system interface for allowing the user to import an existing file.

Presents a system dialog for allowing the user to import multiple files.

### Moving a file

Presents a system interface for allowing the user to move an existing file to a new location.

Presents a system interface for allowing the user to move a collection of existing files to a new location.

Presents a system dialog for allowing the user to move an existing file to a new location.

Presents a system dialog for allowing the user to move a collection of existing files to a new location.

### Configuring a file dialog

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` to provide a refined URL search experience: include or exclude hidden files, allow searching by tag, etc.

`func fileDialogConfirmationLabel(_:)`

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` with a custom confirmation button label.

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` to persist and restore the file dialog configuration.

Configures the `fileExporter`, `fileImporter`, or `fileMover` to open with the specified default directory.

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` behavior when a user chooses an alias.

`func fileDialogMessage(_:)`

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` with a custom text that is presented to the user, similar to a title.

On macOS, configures the `fileImporter` or `fileMover` to conditionally disable presented URLs.

`struct FileDialogBrowserOptions`

The way that file dialogs present the file system.

### Presenting an inspector

Inserts an inspector at the applied position in the view hierarchy.

Sets a fixed, preferred width for the inspector containing this view when presented as a trailing column.

Sets a flexible, preferred width for the inspector in a trailing-column presentation.

### Dismissing a presentation

`var isPresented: Bool`

A Boolean value that indicates whether the view associated with this environment is currently presented.

`var dismiss: DismissAction`

An action that dismisses the current presentation.

`struct DismissAction`

An action that dismisses a presentation.

Conditionally prevents interactive dismissal of presentations like popovers, sheets, and inspectors.

### Deprecated modal presentations

`struct Alert`

A representation of an alert presentation.

Deprecated

`struct ActionSheet`

A representation of an action sheet presentation.

## See Also

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

---

# https://developer.apple.com/documentation/swiftui/toolbars

Collection

- SwiftUI
- Toolbars

API Collection

# Toolbars

Provide immediate access to frequently used commands and controls.

## Overview

The system might present toolbars above or below your app’s content, depending on the platform and the context.

Add items to a toolbar by applying the `toolbar(content:)` view modifier to a view in your app. You can also configure the toolbar using view modifiers. For example, you can set the visibility of a toolbar with the `toolbar(_:for:)` modifier.

For design guidance, see Toolbars in the Human Interface Guidelines.

## Topics

### Populating a toolbar

`func toolbar(content:)`

Populates the toolbar or navigation bar with the specified items.

`struct ToolbarItem`

A model that represents an item which can be placed in the toolbar or navigation bar.

`struct ToolbarItemGroup`

A model that represents a group of `ToolbarItem`s which can be placed in the toolbar or navigation bar.

`struct ToolbarItemPlacement`

A structure that defines the placement of a toolbar item.

`protocol ToolbarContent`

Conforming types represent items that can be placed in various locations in a toolbar.

`struct ToolbarContentBuilder`

Constructs a toolbar item set from multi-expression closures.

`struct ToolbarSpacer`

A standard space item in toolbars.

`struct DefaultToolbarItem`

A toolbar item that represents a system component.

### Populating a customizable toolbar

Populates the toolbar or navigation bar with the specified items, allowing for user customization.

`protocol CustomizableToolbarContent`

Conforming types represent items that can be placed in various locations in a customizable toolbar.

`struct ToolbarCustomizationBehavior`

The customization behavior of customizable toolbar content.

`struct ToolbarCustomizationOptions`

Options that influence the default customization behavior of customizable toolbar content.

`struct SearchToolbarBehavior`

The behavior of a search field in a toolbar.

### Removing default items

Remove a toolbar item present by default

`struct ToolbarDefaultItemKind`

A kind of toolbar item a `View` adds by default.

### Setting toolbar visibility

Specifies the visibility of a bar managed by SwiftUI.

Specifies the preferred visibility of backgrounds on a bar managed by SwiftUI.

`struct ToolbarPlacement`

The placement of a toolbar.

`struct ContentToolbarPlacement`

### Specifying the role of toolbar content

Configures the semantic role for the content populating the toolbar.

`struct ToolbarRole`

The purpose of content that populates the toolbar.

### Styling a toolbar

`func toolbarBackground(_:for:)`

Specifies the preferred shape style of the background of a bar managed by SwiftUI.

Specifies the preferred color scheme of a bar managed by SwiftUI.

Specifies the preferred foreground style of bars managed by SwiftUI.

Sets the style for the toolbar defined within this scene.

`protocol WindowToolbarStyle`

A specification for the appearance and behavior of a window’s toolbar.

`var toolbarLabelStyle: ToolbarLabelStyle?`

The label style to apply to controls within a toolbar.

`struct ToolbarLabelStyle`

The label style of a toolbar.

`struct SpacerSizing`

A type which defines how spacers should size themselves.

### Configuring the toolbar title display mode

Configures the toolbar title display mode for this view.

`struct ToolbarTitleDisplayMode`

A type that defines the behavior of title of a toolbar.

### Setting the toolbar title menu

Configure the title menu of a toolbar.

`struct ToolbarTitleMenu`

The title menu of a toolbar.

### Creating an ornament

`func ornament(visibility:attachmentAnchor:contentAlignment:ornament:)`

Presents an ornament.

`struct OrnamentAttachmentAnchor`

An attachment anchor for an ornament.

## See Also

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

---

# https://developer.apple.com/documentation/swiftui/search

Collection

- SwiftUI
- Search

API Collection

# Search

Enable people to search for text or other content within your app.

## Overview

To present a search field in your app, create and manage storage for search text and optionally for discrete search terms known as _tokens_. Then bind the storage to the search field by applying the searchable view modifier to a view in your app.

As people interact with the field, they implicitly modify the underlying storage and, thereby, the search parameters. Your app correspondingly updates other parts of its interface. To enhance the search interaction, you can also:

- Offer suggestions during search, for both text and tokens.

- Implement search scopes that help people to narrow the search space.

- Detect when people activate the search field, and programmatically dismiss the search field using environment values.

For design guidance, see Searching in the Human Interface Guidelines.

## Topics

### Searching your app’s data model

Adding a search interface to your app

Present an interface that people can use to search for content in your app.

Performing a search operation

Update search results based on search text and optional tokens that you store.

`func searchable(text:placement:prompt:)`

Marks this view as searchable, which configures the display of a search field.

`func searchable(text:tokens:placement:prompt:token:)`

Marks this view as searchable with text and tokens.

`func searchable(text:editableTokens:placement:prompt:token:)`

`struct SearchFieldPlacement`

The placement of a search field in a view hierarchy.

### Making search suggestions

Suggesting search terms

Provide suggestions to people searching for content in your app.

Configures the search suggestions for this view.

Configures how to display search suggestions within this view.

`func searchCompletion(_:)`

Associates a fully formed string with the value of this view when used as a search suggestion.

`func searchable(text:tokens:suggestedTokens:placement:prompt:token:)`

Marks this view as searchable with text, tokens, and suggestions.

`struct SearchSuggestionsPlacement`

The ways that SwiftUI displays search suggestions.

### Limiting search scope

Scoping a search operation

Divide the search space into a few broad categories.

Configures the search scopes for this view.

Configures the search scopes for this view with the specified activation strategy.

`struct SearchScopeActivation`

The ways that searchable modifiers can show or hide search scopes.

### Detecting, activating, and dismissing search

Managing search interface activation

Programmatically detect and dismiss a search field.

`var isSearching: Bool`

A Boolean value that indicates when the user is searching.

`var dismissSearch: DismissSearchAction`

An action that ends the current search interaction.

`struct DismissSearchAction`

An action that can end a search interaction.

`func searchable(text:isPresented:placement:prompt:)`

Marks this view as searchable with programmatic presentation of the search field.

`func searchable(text:tokens:isPresented:placement:prompt:token:)`

Marks this view as searchable with text and tokens, as well as programmatic presentation.

`func searchable(text:editableTokens:isPresented:placement:prompt:token:)`

`func searchable(text:tokens:suggestedTokens:isPresented:placement:prompt:token:)`

Marks this view as searchable with text, tokens, and suggestions, as well as programmatic presentation.

### Displaying toolbar content during search

Configures the search toolbar presentation behavior for any searchable modifiers within this view.

`struct SearchPresentationToolbarBehavior`

A type that defines how the toolbar behaves when presenting search.

### Searching for text in a view

Programmatically presents the find and replace interface for text editor views.

Prevents find and replace operations in a text editor.

Prevents replace operations in a text editor.

`struct FindContext`

The status of the find navigator for views which support text editing.

## See Also

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

---

# https://developer.apple.com/documentation/swiftui/app-extensions

Collection

- SwiftUI
- App extensions

API Collection

# App extensions

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

## Overview

Use SwiftUI along with WidgetKit to add widgets to your app.

Widgets provide quick access to relevant content from your app. Define a structure that conforms to the `Widget` protocol, and declare a view hierarchy for the widget. Configure the views inside the widget as you do other SwiftUI views, using view modifiers, including a few widget-specific modifiers.

For design guidance, see Widgets in the Human Interface Guidelines.

## Topics

### Creating widgets

Building Widgets Using WidgetKit and SwiftUI

Create widgets to show your app’s content on the Home screen, with custom intents for user-customizable settings.

Creating a widget extension

Display your app’s content in a convenient, informative widget on various devices.

Keeping a widget up to date

Plan your widget’s timeline to show timely, relevant information using dynamic views, and update the timeline when things change.

Making a configurable widget

Give people the option to customize their widgets by adding a custom app intent to your project.

`protocol Widget`

The configuration and content of a widget to display on the Home screen or in Notification Center.

`protocol WidgetBundle`

A container used to expose multiple widgets from a single widget extension.

`struct LimitedAvailabilityConfiguration`

A type-erased widget configuration.

`protocol WidgetConfiguration`

A type that describes a widget’s content.

`struct EmptyWidgetConfiguration`

An empty widget configuration.

### Composing control widgets

`protocol ControlWidget`

The configuration and content of a control widget to display in system spaces such as Control Center, the Lock Screen, and the Action Button.

`protocol ControlWidgetConfiguration`

A type that describes a control widget’s content.

`struct EmptyControlWidgetConfiguration`

An empty control widget configuration.

`struct ControlWidgetConfigurationBuilder`

A custom attribute that constructs a control widget’s body.

`protocol ControlWidgetTemplate`

`struct EmptyControlWidgetTemplate`

An empty control widget template.

`struct ControlWidgetTemplateBuilder`

A custom attribute that constructs a control widget template’s body.

`func controlWidgetActionHint(_:)`

The action hint of the control described by the modified label.

`func controlWidgetStatus(_:)`

The status of the control described by the modified label.

### Labeling a widget

`func widgetLabel(_:)`

Returns a localized text label that displays additional content outside the accessory family widget’s main SwiftUI view.

Creates a label for displaying additional content outside an accessory family widget’s main SwiftUI view.

### Styling a widget group

The view modifier that can be applied to `AccessoryWidgetGroup` to specify the shape the three content views will be masked with. The value of `style` is set to `.automatic`, which is `.circular` by default.

### Controlling the accented group

Adds the view and all of its subviews to the accented group.

### Managing placement in the Dynamic Island

Specifies the vertical placement for a view of an expanded Live Activity that appears in the Dynamic Island.

## See Also

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

---

# https://developer.apple.com/documentation/swiftui/model-data

Collection

- SwiftUI
- Model data

API Collection

# Model data

Manage the data that your app uses to drive its interface.

## Overview

SwiftUI offers a declarative approach to user interface design. As you compose a hierarchy of views, you also indicate data dependencies for the views. When the data changes, either due to an external event or because of an action that the user performs, SwiftUI automatically updates the affected parts of the interface. As a result, the framework automatically performs most of the work that view controllers traditionally do.

The framework provides tools, like state variables and bindings, for connecting your app’s data to the user interface. These tools help you maintain a single source of truth for every piece of data in your app, in part by reducing the amount of glue logic you write. Select the tool that best suits the task you need to perform:

- Manage transient UI state locally within a view by wrapping value types as `State` properties.

- Share a reference to a source of truth, like local state, using the `Binding` property wrapper.

- Connect to and observe reference model data in views by applying the `Observable()` macro to the model data type. Instantiate an observable model data type directly in a view using a `State` property. Share the observable model data with other views in the hierarchy without passing a reference using the `Environment` property wrapper.

### Leveraging property wrappers

SwiftUI implements many data management types, like `State` and `Binding`, as Swift property wrappers. Apply a property wrapper by adding an attribute with the wrapper’s name to a property’s declaration.

@State private var isVisible = true // Declares isVisible as a state variable.

The property gains the behavior that the wrapper specifies. The state and data flow property wrappers in SwiftUI watch for changes in your data, and automatically update affected views as necessary. When you refer directly to the property in your code, you access the wrapped value, which for the `isVisible` state property in the example above is the stored Boolean.

if isVisible == true {
Text("Hello") // Only renders when isVisible is true.
}

Alternatively, you can access a property wrapper’s projected value by prefixing the property name with the dollar sign (`$`). SwiftUI state and data flow property wrappers project a `Binding`, which is a two-way connection to the wrapped value, allowing another view to access and mutate a single source of truth.

Toggle("Visible", isOn: $isVisible) // The toggle can update the stored value.

For more information about property wrappers, see Property Wrappers in The Swift Programming Language.

## Topics

### Creating and sharing view state

Managing user interface state

Encapsulate view-specific data within your app’s view hierarchy to make your views reusable.

`struct State`

A property wrapper type that can read and write a value managed by SwiftUI.

`struct Bindable`

A property wrapper type that supports creating bindings to the mutable properties of observable objects.

`struct Binding`

A property wrapper type that can read and write a value owned by a source of truth.

### Creating model data

Managing model data in your app

Create connections between your app’s data model and views.

Migrating from the Observable Object protocol to the Observable macro

Update your existing app to leverage the benefits of Observation in Swift.

`macro Observable()`

Defines and implements conformance of the Observable protocol.

Monitoring data changes in your app

Show changes to data in your app’s user interface by using observable objects.

`struct StateObject`

A property wrapper type that instantiates an observable object.

`struct ObservedObject`

A property wrapper type that subscribes to an observable object and invalidates a view whenever the observable object changes.

`protocol ObservableObject`

A type of object with a publisher that emits before the object has changed.

### Responding to data changes

`func onChange(of:initial:_:)`

Adds a modifier for this view that fires an action when a specific value changes.

Adds an action to perform when this view detects data emitted by the given publisher.

### Distributing model data throughout your app

Supplies an observable object to a view’s hierarchy.

Supplies an `ObservableObject` to a view subhierarchy.

`struct EnvironmentObject`

A property wrapper type for an observable object that a parent or ancestor view supplies.

### Managing dynamic data

`protocol DynamicProperty`

An interface for a stored variable that updates an external property of a view.

## See Also

### Data and storage

Share data throughout a view hierarchy using the environment.

Indicate configuration preferences from views to their container views.

Store data for use across sessions of your app.

---

# https://developer.apple.com/documentation/swiftui/environment-values

Collection

- SwiftUI
- Environment values

API Collection

# Environment values

Share data throughout a view hierarchy using the environment.

## Overview

Views in SwiftUI can react to configuration information that they read from the environment using an `Environment` property wrapper.

A view inherits its environment from its container view, subject to explicit changes from an `environment(_:_:)` view modifier, or by implicit changes from one of the many modifiers that operate on environment values. As a result, you can configure a entire hierarchy of views by modifying the environment of the group’s container.

You can find many built-in environment values in the `EnvironmentValues` structure. You can also create a custom `EnvironmentValues` property by defining a new property in an extension to the environment values structure and applying the `Entry()` macro to the variable declaration.

## Topics

### Accessing environment values

`struct Environment`

A property wrapper that reads a value from a view’s environment.

`struct EnvironmentValues`

A collection of environment values propagated through a view hierarchy.

### Creating custom environment values

`macro Entry()`

Creates an environment values, transaction, container values, or focused values entry.

`protocol EnvironmentKey`

A key for accessing values in the environment.

### Modifying the environment of a view

Places an observable object in the view’s environment.

Sets the environment value of the specified key path to the given value.

Transforms the environment value of the specified key path with the given function.

### Modifying the environment of a scene

Places an observable object in the scene’s environment.

## See Also

### Data and storage

Manage the data that your app uses to drive its interface.

Indicate configuration preferences from views to their container views.

Store data for use across sessions of your app.

---

# https://developer.apple.com/documentation/swiftui/preferences

Collection

- SwiftUI
- Preferences

API Collection

# Preferences

Indicate configuration preferences from views to their container views.

## Overview

Whereas you use the environment to configure the subviews of a view, you use preferences to send configuration information from subviews toward their container. However, unlike configuration information that flows down a view hierarchy from one container to many subviews, a single container needs to reconcile potentially conflicting preferences flowing up from its many subviews.

When you use the `PreferenceKey` protocol to define a custom preference, you indicate how to merge preferences from multiple subviews. You can then set a value for the preference on a view using the `preference(key:value:)` view modifier. Many built-in modifiers, like `navigationTitle(_:)`, rely on preferences to send configuration information to their container.

## Topics

### Setting preferences

Sets a value for the given preference.

Applies a transformation to a preference value.

### Creating custom preferences

`protocol PreferenceKey`

A named value produced by a view.

### Setting preferences based on geometry

Sets a value for the specified preference key, the value is a function of a geometry value tied to the current coordinate space, allowing readers of the value to convert the geometry to their local coordinates.

Sets a value for the specified preference key, the value is a function of the key’s current value and a geometry value tied to the current coordinate space, allowing readers of the value to convert the geometry to their local coordinates.

### Responding to changes in preferences

Adds an action to perform when the specified preference key’s value changes.

### Generating backgrounds and overlays from preferences

Reads the specified preference value from the view, using it to produce a second view that is applied as the background of the original view.

Reads the specified preference value from the view, using it to produce a second view that is applied as an overlay to the original view.

## See Also

### Data and storage

Manage the data that your app uses to drive its interface.

Share data throughout a view hierarchy using the environment.

Store data for use across sessions of your app.

---

# https://developer.apple.com/documentation/swiftui/persistent-storage

Collection

- SwiftUI
- Persistent storage

API Collection

# Persistent storage

Store data for use across sessions of your app.

## Overview

The operating system provides ways to store data when your app closes, so that when people open your app again later, they can continue working without interruption. The mechanism that you use depends on factors like what and how much you need to store, whether you need serialized or random access to the data, and so on.

You use the same kinds of storage in a SwiftUI app that you use in any other app. For example, you can access files on disk using the `FileManager` interface. However, SwiftUI also provides conveniences that make it easier to use certain kinds of persistent storage in a declarative environment. For example, you can use `FetchRequest` and `FetchedResults` to interact with a Core Data model.

## Topics

### Saving state across app launches

Restoring your app’s state with SwiftUI

Provide app continuity for users by preserving their current activities.

The default store used by `AppStorage` contained within the view.

`struct AppStorage`

A property wrapper type that reflects a value from `UserDefaults` and invalidates a view on a change in value in that user default.

`struct SceneStorage`

A property wrapper type that reads and writes to persisted, per-scene storage.

### Accessing Core Data

Loading and displaying a large data feed

Consume data in the background, and lower memory use by batching imports and preventing duplicate records.

`var managedObjectContext: NSManagedObjectContext`

`struct FetchRequest`

A property wrapper type that retrieves entities from a Core Data persistent store.

`struct FetchedResults`

A collection of results retrieved from a Core Data store.

`struct SectionedFetchRequest`

A property wrapper type that retrieves entities, grouped into sections, from a Core Data persistent store.

`struct SectionedFetchResults`

A collection of results retrieved from a Core Data persistent store, grouped into sections.

## See Also

### Data and storage

Manage the data that your app uses to drive its interface.

Share data throughout a view hierarchy using the environment.

Indicate configuration preferences from views to their container views.

---

# https://developer.apple.com/documentation/swiftui/view-fundamentals

Collection

- SwiftUI
- View fundamentals

API Collection

# View fundamentals

Define the visual elements of your app using a hierarchy of views.

## Overview

Views are the building blocks that you use to declare your app’s user interface. Each view contains a description of what to display for a given state. Every bit of your app that’s visible to the user derives from the description in a view, and any type that conforms to the `View` protocol can act as a view in your app.

Compose a custom view by combining built-in views that SwiftUI provides with other custom views that you create in your view’s `body` computed property. Configure views using the view modifiers that SwiftUI provides, or by defining your own view modifiers using the `ViewModifier` protocol and the `modifier(_:)` method.

## Topics

### Creating a view

Declaring a custom view

Define views and assemble them into a view hierarchy.

`protocol View`

A type that represents part of your app’s user interface and provides modifiers that you use to configure views.

`struct ViewBuilder`

A custom parameter attribute that constructs views from closures.

### Modifying a view

Configuring views

Adjust the characteristics of a view by applying view modifiers.

Reducing view modifier maintenance

Bundle view modifiers that you regularly reuse into a custom view modifier.

Applies a modifier to a view and returns a new view.

`protocol ViewModifier`

A modifier that you apply to a view or another view modifier, producing a different version of the original value.

`struct EmptyModifier`

An empty, or identity, modifier, used during development to switch modifiers at compile time.

`struct ModifiedContent`

A value with a modifier applied to it.

`protocol EnvironmentalModifier`

A modifier that must resolve to a concrete modifier in an environment before use.

`struct ManipulableModifier`

`struct ManipulableResponderModifier`

`struct ManipulableTransformBindingModifier`

`struct ManipulationGeometryModifier`

`struct ManipulationGestureModifier`

`struct ManipulationUsingGestureStateModifier`

`enum Manipulable`

A namespace for various manipulable related types.

### Responding to view life cycle updates

Adds an action to perform before this view appears.

Adds an action to perform after this view disappears.

Adds an asynchronous task to perform before this view appears.

Adds a task to perform before this view appears or when a specified value changes.

### Managing the view hierarchy

Binds a view’s identity to the given proxy value.

Sets the unique tag value of this view.

Prevents the view from updating its child view when its new value is the same as its old value.

### Supporting view types

`struct AnyView`

A type-erased view.

`struct EmptyView`

A view that doesn’t contain any content.

`struct EquatableView`

A view type that compares itself against its previous value and prevents its child updating if its new value is the same as its old value.

`struct SubscriptionView`

A view that subscribes to a publisher with an action.

`struct TupleView`

A View created from a swift tuple of View values.

## See Also

### Views

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

---

# https://developer.apple.com/documentation/swiftui/view-configuration

Collection

- SwiftUI
- View configuration

API Collection

# View configuration

Adjust the characteristics of views in a hierarchy.

## Overview

SwiftUI enables you to tune the appearance and behavior of views using view modifiers.

Many modifiers apply to specific kinds of views or behaviors, but some apply more generally. For example, you can conditionally hide any view by dynamically setting its opacity, display contextual help when people hover over a view, or request the light or dark appearance for a view.

## Topics

### Hiding views

Sets the transparency of this view.

Hides this view unconditionally.

### Hiding system elements

Hides the labels of any controls contained within this view.

Controls the visibility of labels of any controls contained within this view.

`var labelsVisibility: Visibility`

The labels visibility set by `labelsVisibility(_:)`.

Sets the menu indicator visibility for controls within this view.

Sets the visibility of the status bar.

Sets the preferred visibility of the non-transient system views overlaying the app.

`enum Visibility`

The visibility of a UI element, chosen automatically based on the platform, current context, and other factors.

### Managing view interaction

Adds a condition that controls whether users can interact with this view.

`var isEnabled: Bool`

A Boolean value that indicates whether the view associated with this environment allows user interaction.

Sets a tag that you use for tracking interactivity.

Mark the receiver as their content might be invalidated.

### Providing contextual help

`func help(_:)`

Adds help text to a view using a text view that you provide.

### Detecting and requesting the light or dark appearance

Sets the preferred color scheme for this presentation.

`var colorScheme: ColorScheme`

The color scheme of this environment.

`enum ColorScheme`

The possible color schemes, corresponding to the light and dark appearances.

### Getting the color scheme contrast

`var colorSchemeContrast: ColorSchemeContrast`

The contrast associated with the color scheme of this environment.

`enum ColorSchemeContrast`

The contrast between the app’s foreground and background colors.

### Configuring passthrough

Applies an effect to passthrough video.

`struct SurroundingsEffect`

Effects that the system can apply to passthrough video.

`struct BreakthroughEffect`

### Redacting private content

Designing your app for the Always On state

Customize your watchOS app’s user interface for continuous display.

Marks the view as containing sensitive, private user data.

Adds a reason to apply a redaction to this view hierarchy.

Removes any reason to apply a redaction to this view hierarchy.

`var redactionReasons: RedactionReasons`

The current redaction reasons applied to the view hierarchy.

`var isSceneCaptured: Bool`

The current capture state.

`struct RedactionReasons`

The reasons to apply a redaction to data displayed on screen.

## See Also

### Views

Define the visual elements of your app using a hierarchy of views.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

---

# https://developer.apple.com/documentation/swiftui/view-styles

Collection

- SwiftUI
- View styles

API Collection

# View styles

Apply built-in and custom appearances and behaviors to different types of views.

## Overview

SwiftUI defines built-in styles for certain kinds of views and automatically selects the appropriate style for a particular presentation context. For example, a `Label` might appear as an icon, a string title, or both, depending on factors like the platform, whether the view appears in a toolbar, and so on.

You can override the automatic style by using one of the style view modifiers. These modifiers typically propagate throughout a container view, so that you can wrap a view hierarchy in a style modifier to affect all the views of the given type within the hierarchy.

Any of the style protocols that define a `makeBody(configuration:)` method, like `ToggleStyle`, also enable you to define custom styles. Create a type that conforms to the corresponding style protocol and implement its `makeBody(configuration:)` method. Then apply the new style using a style view modifier exactly like a built-in style.

## Topics

### Styling views with Liquid Glass

Applying Liquid Glass to custom views

Configure, combine, and morph views using Liquid Glass effects.

Landmarks: Building an app with Liquid Glass

Enhance your app experience with system-provided and custom Liquid Glass.

Applies the Liquid Glass effect to a view.

Returns a copy of the structure configured to be interactive.

`struct GlassEffectContainer`

A view that combines multiple Liquid Glass shapes into a single shape that can morph individual shapes into one another.

`struct GlassEffectTransition`

A structure that describes changes to apply when a glass effect is added or removed from the view hierarchy.

`struct GlassButtonStyle`

A button style that applies glass border artwork based on the button’s context.

`struct GlassProminentButtonStyle`

A button style that applies prominent glass border artwork based on the button’s context.

`struct DefaultGlassEffectShape`

The default shape applied by glass effects, a capsule.

### Styling buttons

`func buttonStyle(_:)`

Sets the style for buttons within this view to a button style with a custom appearance and standard interaction behavior.

`protocol ButtonStyle`

A type that applies standard interaction behavior and a custom appearance to all buttons within a view hierarchy.

`struct ButtonStyleConfiguration`

The properties of a button.

`protocol PrimitiveButtonStyle`

A type that applies custom interaction behavior and a custom appearance to all buttons within a view hierarchy.

`struct PrimitiveButtonStyleConfiguration`

Sets the style used for displaying the control (see `SignInWithAppleButton.Style`).

### Styling pickers

Sets the style for pickers within this view.

`protocol PickerStyle`

A type that specifies the appearance and interaction of all pickers within a view hierarchy.

Sets the style for date pickers within this view.

`protocol DatePickerStyle`

A type that specifies the appearance and interaction of all date pickers within a view hierarchy.

### Styling menus

Sets the style for menus within this view.

`protocol MenuStyle`

A type that applies standard interaction behavior and a custom appearance to all menus within a view hierarchy.

`struct MenuStyleConfiguration`

A configuration of a menu.

### Styling toggles

Sets the style for toggles in a view hierarchy.

`protocol ToggleStyle`

The appearance and behavior of a toggle.

`struct ToggleStyleConfiguration`

The properties of a toggle instance.

### Styling indicators

Sets the style for gauges within this view.

`protocol GaugeStyle`

Defines the implementation of all gauge instances within a view hierarchy.

`struct GaugeStyleConfiguration`

The properties of a gauge instance.

Sets the style for progress views in this view.

`protocol ProgressViewStyle`

A type that applies standard interaction behavior to all progress views within a view hierarchy.

`struct ProgressViewStyleConfiguration`

The properties of a progress view instance.

### Styling views that display text

Sets the style for labels within this view.

`protocol LabelStyle`

A type that applies a custom appearance to all labels within a view.

`struct LabelStyleConfiguration`

The properties of a label.

Sets the style for text fields within this view.

`protocol TextFieldStyle`

A specification for the appearance and interaction of a text field.

Sets the style for text editors within this view.

`protocol TextEditorStyle`

A specification for the appearance and interaction of a text editor.

`struct TextEditorStyleConfiguration`

The properties of a text editor.

### Styling collection views

Sets the style for lists within this view.

`protocol ListStyle`

A protocol that describes the behavior and appearance of a list.

Sets the style for tables within this view.

`protocol TableStyle`

A type that applies a custom appearance to all tables within a view.

`struct TableStyleConfiguration`

The properties of a table.

Sets the style for disclosure groups within this view.

`protocol DisclosureGroupStyle`

A type that specifies the appearance and interaction of disclosure groups within a view hierarchy.

### Styling navigation views

Sets the style for navigation split views within this view.

`protocol NavigationSplitViewStyle`

A type that specifies the appearance and interaction of navigation split views within a view hierarchy.

Sets the style for the tab view within the current environment.

`protocol TabViewStyle`

A specification for the appearance and interaction of a tab view.

### Styling groups

Sets the style for control groups within this view.

`protocol ControlGroupStyle`

Defines the implementation of all control groups within a view hierarchy.

`struct ControlGroupStyleConfiguration`

The properties of a control group.

Sets the style for forms in a view hierarchy.

`protocol FormStyle`

The appearance and behavior of a form.

`struct FormStyleConfiguration`

The properties of a form instance.

Sets the style for group boxes within this view.

`protocol GroupBoxStyle`

A type that specifies the appearance and interaction of all group boxes within a view hierarchy.

`struct GroupBoxStyleConfiguration`

The properties of a group box instance.

Sets the style for the index view within the current environment.

`protocol IndexViewStyle`

Defines the implementation of all `IndexView` instances within a view hierarchy.

Sets a style for labeled content.

`protocol LabeledContentStyle`

The appearance and behavior of a labeled content instance..

`struct LabeledContentStyleConfiguration`

The properties of a labeled content instance.

### Styling windows from a view inside the window

Sets the style for windows created by interacting with this view.

Sets the style for the toolbar in windows created by interacting with this view.

### Adding a glass background on views in visionOS

Fills the view’s background with an automatic glass background effect and container-relative rounded rectangle shape.

Fills the view’s background with an automatic glass background effect and a shape that you specify.

`enum GlassBackgroundDisplayMode`

The display mode of a glass background.

`protocol GlassBackgroundEffect`

A specification for the appearance of a glass background.

`struct AutomaticGlassBackgroundEffect`

The automatic glass background effect.

`struct GlassBackgroundEffectConfiguration`

A configuration used to build a custom effect.

`struct FeatheredGlassBackgroundEffect`

The feathered glass background effect.

`struct PlateGlassBackgroundEffect`

The plate glass background effect.

## See Also

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

---

# https://developer.apple.com/documentation/swiftui/animations

Collection

- SwiftUI
- Animations

API Collection

# Animations

Create smooth visual updates in response to state changes.

## Overview

You tell SwiftUI how to draw your app’s user interface for different states, and then rely on SwiftUI to make interface updates when the state changes.

To avoid abrupt visual transitions when the state changes, add animation in one of the following ways:

- Animate all of the visual changes for a state change by changing the state inside a call to the `withAnimation(_:_:)` global function.

- Add animation to a particular view when a specific value changes by applying the `animation(_:value:)` view modifier to the view.

- Animate changes to a `Binding` by using the binding’s `animation(_:)` method.

SwiftUI animates the effects that many built-in view modifiers produce, like those that set a scale or opacity value. You can animate other values by making your custom views conform to the `Animatable` protocol, and telling SwiftUI about the value you want to animate.

When an animated state change results in adding or removing a view to or from the view hierarchy, you can tell SwiftUI how to transition the view into or out of place using built-in transitions that `AnyTransition` defines, like `slide` or `scale`. You can also create custom transitions.

For design guidance, see Motion in the Human Interface Guidelines.

## Topics

### Adding state-based animation to an action

Returns the result of recomputing the view’s body with the provided animation.

Returns the result of recomputing the view’s body with the provided animation, and runs the completion when all animations are complete.

`struct AnimationCompletionCriteria`

The criteria that determines when an animation is considered finished.

`struct Animation`

The way a view changes over time to create a smooth visual transition from one state to another.

### Adding state-based animation to a view

`func animation(_:)`

Applies the given animation to this view when this view changes.

Applies the given animation to this view when the specified value changes.

Applies the given animation to all animatable values within the `body` closure.

### Creating phase-based animation

Controlling the timing and movements of your animations

Build sophisticated animations that you control using phase and keyframe animators.

Animates effects that you apply to a view over a sequence of phases that change continuously.

Animates effects that you apply to a view over a sequence of phases that change based on a trigger.

`struct PhaseAnimator`

A container that animates its content by automatically cycling through a collection of phases that you provide, each defining a discrete step within an animation.

### Creating keyframe-based animation

Loops the given keyframes continuously, updating the view using the modifiers you apply in `body`.

Plays the given keyframes when the given trigger value changes, updating the view using the modifiers you apply in `body`.

`struct KeyframeAnimator`

A container that animates its content with keyframes.

`protocol Keyframes`

A type that defines changes to a value over time.

`struct KeyframeTimeline`

A description of how a value changes over time, modeled using keyframes.

`struct KeyframeTrack`

A sequence of keyframes animating a single property of a root type.

`struct KeyframeTrackContentBuilder`

The builder that creates keyframe track content from the keyframes that you define within a closure.

`struct KeyframesBuilder`

A builder that combines keyframe content values into a single value.

`protocol KeyframeTrackContent`

A group of keyframes that define an interpolation curve of an animatable value.

`struct CubicKeyframe`

A keyframe that uses a cubic curve to smoothly interpolate between values.

`struct LinearKeyframe`

A keyframe that uses simple linear interpolation.

`struct MoveKeyframe`

A keyframe that immediately moves to the given value without interpolating.

`struct SpringKeyframe`

A keyframe that uses a spring function to interpolate to the given value.

### Creating custom animations

`protocol CustomAnimation`

A type that defines how an animatable value changes over time.

`struct AnimationContext`

Contextual values that a custom animation can use to manage state and access a view’s environment.

`struct AnimationState`

A container that stores the state for a custom animation.

`protocol AnimationStateKey`

A key for accessing animation state values.

`struct UnitCurve`

A function defined by a two-dimensional curve that maps an input progress in the range \[0,1\] to an output progress that is also in the range \[0,1\]. By changing the shape of the curve, the effective speed of an animation or other interpolation can be changed.

`struct Spring`

A representation of a spring’s motion.

### Making data animatable

`protocol Animatable`

A type that describes how to animate a property of a view.

`struct AnimatableValues`

`struct AnimatablePair`

A pair of animatable values, which is itself animatable.

`protocol VectorArithmetic`

A type that can serve as the animatable data of an animatable type.

`struct EmptyAnimatableData`

An empty type for animatable data.

### Updating a view on a schedule

Updating watchOS apps with timelines

Seamlessly schedule updates to your user interface, even while it’s inactive.

`struct TimelineView`

A view that updates according to a schedule that you provide.

`protocol TimelineSchedule`

A type that provides a sequence of dates for use as a schedule.

`typealias TimelineViewDefaultContext`

Information passed to a timeline view’s content callback.

### Synchronizing geometries

Defines a group of views with synchronized geometry using an identifier and namespace that you provide.

`struct MatchedGeometryProperties`

A set of view properties that may be synchronized between views using the `View.matchedGeometryEffect()` function.

`protocol GeometryEffect`

An effect that changes the visual appearance of a view, largely without changing its ancestors or descendants.

`struct Namespace`

A dynamic property type that allows access to a namespace defined by the persistent identity of the object containing the property (e.g. a view).

Isolates the geometry (e.g. position and size) of the view from its parent view.

### Defining transitions

`func transition(_:)`

Associates a transition with the view.

`protocol Transition`

A description of view changes to apply when a view is added to and removed from the view hierarchy.

`struct TransitionProperties`

The properties a `Transition` can have.

`enum TransitionPhase`

An indication of which the current stage of a transition.

`struct AsymmetricTransition`

A composite `Transition` that uses a different transition for insertion versus removal.

`struct AnyTransition`

A type-erased transition.

Modifies the view to use a given transition as its method of animating changes to the contents of its views.

`var contentTransition: ContentTransition`

The current method of animating the contents of views.

`var contentTransitionAddsDrawingGroup: Bool`

A Boolean value that controls whether views that render content transitions use GPU-accelerated rendering.

`struct ContentTransition`

A kind of transition that applies to the content within a single view, rather than to the insertion or removal of a view.

`struct PlaceholderContentView`

A placeholder used to construct an inline modifier, transition, or other helper type.

Sets the navigation transition style for this view.

`protocol NavigationTransition`

A type that defines the transition to use when navigating to a view.

Identifies this view as the source of a navigation transition, such as a zoom transition.

`protocol MatchedTransitionSourceConfiguration`

A configuration that defines the appearance of a matched transition source.

`struct EmptyMatchedTransitionSourceConfiguration`

An unstyled matched transition source configuration.

### Moving an animation to another view

Executes a closure with the specified transaction and returns the result.

Executes a closure with the specified transaction key path and value and returns the result.

Applies the given transaction mutation function to all animations used within the view.

Applies the given transaction mutation function to all animations used within the `body` closure.

`struct Transaction`

The context of the current state-processing update.

`macro Entry()`

Creates an environment values, transaction, container values, or focused values entry.

`protocol TransactionKey`

A key for accessing values in a transaction.

### Deprecated types

`protocol AnimatableModifier`

A modifier that can create another modifier with animation.

Deprecated

## See Also

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

---

# https://developer.apple.com/documentation/swiftui/text-input-and-output

Collection

- SwiftUI
- Text input and output

API Collection

# Text input and output

Display formatted text and get text input from the user.

## Overview

To display read-only text, or read-only text paired with an image, use the built-in `Text` or `Label` views, respectively. When you need to collect text input from the user, use an appropriate text input view, like `TextField` or `TextEditor`.

You add view modifiers to control the text’s font, selectability, alignment, layout direction, and so on. These modifiers also affect other views that display text, like the labels on controls, even if you don’t define an explicit `Text` view.

For design guidance, see Typography in the Human Interface Guidelines.

## Topics

### Displaying text

`struct Text`

A view that displays one or more lines of read-only text.

`struct Label`

A standard label for user interface items, consisting of an icon with a title.

Sets the style for labels within this view.

### Getting text input

Building rich SwiftUI text experiences

Build an editor for formatted text using SwiftUI text editor views and attributed strings.

`struct TextField`

A control that displays an editable text interface.

Sets the style for text fields within this view.

`struct SecureField`

A control into which people securely enter private text.

`struct TextEditor`

A view that can display and edit long-form text.

### Selecting text

Controls whether people can select text within this view.

`protocol TextSelectability`

A type that describes the ability to select text.

`struct TextSelection`

Represents a selection of text.

Sets the direction of a selection or cursor relative to a text character.

`var textSelectionAffinity: TextSelectionAffinity`

A representation of the direction or association of a selection or cursor relative to a text character. This concept becomes much more prominent when dealing with bidirectional text (text that contains both LTR and RTL scripts, like English and Arabic combined).

`enum TextSelectionAffinity`

`struct AttributedTextSelection`

Represents a selection of attributed text.

### Setting a font

Applying custom fonts to text

Add and use a font in your app that scales with Dynamic Type.

Sets the default font for text in this view.

Sets the font design of the text in this view.

Sets the font weight of the text in this view.

Sets the font width of the text in this view.

`var font: Font?`

The default font of this environment.

`struct Font`

An environment-dependent font.

### Adjusting text size

Applies a text scale to text in the view.

`func dynamicTypeSize(_:)`

Sets the Dynamic Type size within the view to the given value.

`var dynamicTypeSize: DynamicTypeSize`

The current Dynamic Type size.

`enum DynamicTypeSize`

A Dynamic Type size, which specifies how large scalable content should be.

`struct ScaledMetric`

A dynamic property that scales a numeric value.

`protocol TextVariantPreference`

A protocol for controlling the size variant of text views.

`struct FixedTextVariant`

The default text variant preference that chooses the largest available variant.

`struct SizeDependentTextVariant`

The size dependent variant preference allows the text to take the available space into account when choosing the variant to display.

### Controlling text style

Applies a bold font weight to the text in this view.

Applies italics to the text in this view.

Applies an underline to the text in this view.

Applies a strikethrough to the text in this view.

Sets a transform for the case of the text contained in this view when displayed.

`var textCase: Text.Case?`

A stylistic override to transform the case of `Text` when displayed, using the environment’s locale.

Modifies the fonts of all child views to use the fixed-width variant of the current font, if possible.

Modifies the fonts of all child views to use fixed-width digits, if possible, while leaving other characters proportionally spaced.

`protocol AttributedTextFormattingDefinition`

A protocol for defining how text can be styled in a view.

`protocol AttributedTextValueConstraint`

A protocol for defining a constraint on the value of a certain attribute.

`enum AttributedTextFormatting`

A namespace for types related to attributed text formatting definitions.

### Managing text layout

Sets the truncation mode for lines of text that are too long to fit in the available space.

`var truncationMode: Text.TruncationMode`

A value that indicates how the layout truncates the last line of text to fit into the available space.

Sets whether text in this view can compress the space between characters when necessary to fit text in a line.

`var allowsTightening: Bool`

A Boolean value that indicates whether inter-character spacing should tighten to fit the text into the available space.

Sets the minimum amount that text in this view scales down to fit in the available space.

`var minimumScaleFactor: CGFloat`

The minimum permissible proportion to shrink the font size to fit the text into the available space.

Sets the vertical offset for the text relative to its baseline in this view.

Sets the spacing, or kerning, between characters for the text in this view.

Sets the tracking for the text in this view.

Sets whether this view mirrors its contents horizontally when the layout direction is right-to-left.

`enum TextAlignment`

An alignment position for text along the horizontal axis.

### Rendering text

Creating visual effects with SwiftUI

Add scroll effects, rich color treatments, custom transitions, and advanced effects using shaders and a text renderer.

`protocol TextAttribute`

A value that you can attach to text views and that text renderers can query.

Returns a new view such that any text views within it will use `renderer` to draw themselves.

`protocol TextRenderer`

A value that can replace the default text view rendering behavior.

`struct TextProxy`

A proxy for a text view that custom text renderers use.

### Limiting line count for multiline text

`func lineLimit(_:)`

Sets to a closed range the number of lines that text can occupy in this view.

Sets a limit for the number of lines text can occupy in this view.

`var lineLimit: Int?`

The maximum number of lines that text can occupy in a view.

### Formatting multiline text

Sets the amount of space between lines of text in this view.

`var lineSpacing: CGFloat`

The distance in points between the bottom of one line fragment and the top of the next.

Sets the alignment of a text view that contains multiple lines of text.

`var multilineTextAlignment: TextAlignment`

An environment value that indicates how a text view aligns its lines when the content wraps or contains newlines.

### Formatting date and time

`enum SystemFormatStyle`

A namespace for format styles that implement designs used across Apple’s platformes.

`struct TimeDataSource`

A source of time related data.

### Managing text entry

Sets whether to disable autocorrection for this view.

`var autocorrectionDisabled: Bool`

A Boolean value that determines whether the view hierarchy has auto-correction enabled.

Sets the keyboard type for this view.

Configures the behavior in which scrollable content interacts with the software keyboard.

`func textContentType(_:)`

Sets the text content type for this view, which the system uses to offer suggestions while the user enters text on macOS.

Sets how often the shift key in the keyboard is automatically enabled.

`struct TextInputAutocapitalization`

The kind of autocapitalization behavior applied during text input.

Associates a fully formed string with the value of this view when used as a text input suggestion

Configures the text input suggestions for this view.

Sets the text content type for this view, which the system uses to offer suggestions while the user enters text on a watchOS device.

Sets the text content type for this view, which the system uses to offer suggestions while the user enters text on an iOS or tvOS device.

`struct TextInputFormattingControlPlacement`

A structure defining the system text formatting controls available on each platform.

### Dictating text

Configures the dictation behavior for any search fields configured by the searchable modifier.

`struct TextInputDictationActivation`

`struct TextInputDictationBehavior`

### Configuring the Writing Tools behavior

Specifies the Writing Tools behavior for text and text input in the environment.

`struct WritingToolsBehavior`

The Writing Tools editing experience for text and text input.

### Specifying text equivalents

`func typeSelectEquivalent(_:)`

Sets an explicit type select equivalent text in a collection, such as a list or table.

### Localizing text

Preparing views for localization

Specify hints and add strings to localize your SwiftUI views.

`struct LocalizedStringKey`

The key used to look up an entry in a strings file or strings dictionary file.

`var locale: Locale`

The current locale that views should use.

`func typesettingLanguage(_:isEnabled:)`

Specifies the language for typesetting.

`struct TypesettingLanguage`

Defines how typesetting language is determined for text.

### Deprecated types

`enum ContentSizeCategory`

The sizes that you can specify for content.

Deprecated

## See Also

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

---

# https://developer.apple.com/documentation/swiftui/images

Collection

- SwiftUI
- Images

API Collection

# Images

Add images and symbols to your app’s user interface.

## Overview

Display images, including SF Symbols, images that you store in an asset catalog, and images that you store on disk, using an `Image` view.

For images that take time to retrieve — for example, when you load an image from a network endpoint — load the image asynchronously using `AsyncImage`. You can instruct that view to display a placeholder during the load operation.

For design guidance, see Images in the Human Interface Guidelines.

## Topics

### Creating an image

`struct Image`

A view that displays an image.

### Configuring an image

Fitting images into available space

Adjust the size and shape of images in your app’s user interface by applying view modifiers.

Scales images within the view according to one of the relative sizes available including small, medium, and large images sizes.

`var imageScale: Image.Scale`

The image scale for this environment.

`enum Scale`

A scale to apply to vector images relative to text.

`enum Orientation`

The orientation of an image.

`enum ResizingMode`

The modes that SwiftUI uses to resize an image to fit within its containing view.

### Loading images asynchronously

`struct AsyncImage`

A view that asynchronously loads and displays an image.

`enum AsyncImagePhase`

The current phase of the asynchronous image loading operation.

### Setting a symbol variant

Makes symbols within the view show a particular variant.

`var symbolVariants: SymbolVariants`

The symbol variant to use in this environment.

`struct SymbolVariants`

A variant of a symbol.

### Managing symbol effects

Returns a new view with a symbol effect added to it.

Returns a new view with its inherited symbol image effects either removed or left unchanged.

`struct SymbolEffectTransition`

Creates a transition that applies the Appear, Disappear, DrawOn or DrawOff symbol animation to symbol images within the inserted or removed view hierarchy.

### Setting symbol rendering modes

Sets the rendering mode for symbol images within this view.

`var symbolRenderingMode: SymbolRenderingMode?`

The current symbol rendering mode, or `nil` denoting that the mode is picked automatically using the current image and foreground style as parameters.

`struct SymbolRenderingMode`

A symbol rendering mode.

`struct SymbolColorRenderingMode`

A method of filling a layer in a symbol image.

`struct SymbolVariableValueMode`

A method of rendering the variable value of a symbol image.

### Rendering images from views

`class ImageRenderer`

An object that creates images from SwiftUI views.

## See Also

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

---

# https://developer.apple.com/documentation/swiftui/controls-and-indicators

Collection

- SwiftUI
- Controls and indicators

API Collection

# Controls and indicators

Display values and get user selections.

## Overview

SwiftUI provides controls that enable user interaction specific to each platform and context. For example, people can initiate events with buttons and links, or choose among a set of discrete values with different kinds of pickers. You can also display information to the user with indicators like progress views and gauges.

Use these built-in controls and indicators when composing custom views, and style them to match the needs of your app’s user interface. For design guidance, see Menus and actions, Selection and input, and Status in the Human Interface Guidelines.

## Topics

### Creating buttons

`struct Button`

A control that initiates an action.

`func buttonStyle(_:)`

Sets the style for buttons within this view to a button style with a custom appearance and standard interaction behavior.

Sets the border shape for buttons in this view.

Sets whether buttons in this view should repeatedly trigger their actions on prolonged interactions.

`var buttonRepeatBehavior: ButtonRepeatBehavior`

Whether buttons with this associated environment should repeatedly trigger their actions on prolonged interactions.

`struct ButtonBorderShape`

A shape used to draw a button’s border.

`struct ButtonRole`

A value that describes the purpose of a button.

`struct ButtonRepeatBehavior`

The options for controlling the repeatability of button actions.

`struct ButtonSizing`

The sizing behavior of `Button`s and other button-like controls.

### Creating special-purpose buttons

`struct EditButton`

A button that toggles the edit mode environment value.

`struct PasteButton`

A system button that reads items from the pasteboard and delivers it to a closure.

`struct RenameButton`

A button that triggers a standard rename action.

### Linking to other content

`struct Link`

A control for navigating to a URL.

`struct ShareLink`

A view that controls a sharing presentation.

`struct SharePreview`

A representation of a type to display in a share preview.

`struct TextFieldLink`

A control that requests text input from the user when pressed.

`struct HelpLink`

A button with a standard appearance that opens app-specific help documentation.

### Getting numeric inputs

`struct Slider`

A control for selecting a value from a bounded linear range of values.

`struct Stepper`

A control that performs increment and decrement actions.

`struct Toggle`

A control that toggles between on and off states.

Sets the style for toggles in a view hierarchy.

### Choosing from a set of options

`struct Picker`

A control for selecting from a set of mutually exclusive values.

Sets the style for pickers within this view.

Sets the style for radio group style pickers within this view to be horizontally positioned with the radio buttons inside the layout.

Sets the default wheel-style picker item height.

`var defaultWheelPickerItemHeight: CGFloat`

The default height of an item in a wheel-style picker, such as a date picker.

Specifies the selection effect to apply to a palette item.

`struct PaletteSelectionEffect`

The selection effect to apply to a palette item.

### Choosing dates

`struct DatePicker`

A control for selecting an absolute date.

Sets the style for date pickers within this view.

`struct MultiDatePicker`

A control for picking multiple dates.

`var calendar: Calendar`

The current calendar that views should use when handling dates.

`var timeZone: TimeZone`

The current time zone that views should use when handling dates.

### Choosing a color

`struct ColorPicker`

A control used to select a color from the system color picker UI.

### Indicating a value

`struct Gauge`

A view that shows a value within a range.

Sets the style for gauges within this view.

`struct ProgressView`

A view that shows the progress toward completion of a task.

Sets the style for progress views in this view.

`struct DefaultDateProgressLabel`

The default type of the current value label when used by a date-relative progress view.

`struct DefaultButtonLabel`

The default label to use for a button.

### Indicating missing content

`struct ContentUnavailableView`

An interface, consisting of a label and additional content, that you display when the content of your app is unavailable to users.

### Providing haptic feedback

Plays the specified `feedback` when the provided `trigger` value changes.

`func sensoryFeedback(trigger:_:)`

Plays feedback when returned from the `feedback` closure after the provided `trigger` value changes.

Plays the specified `feedback` when the provided `trigger` value changes and the `condition` closure returns `true`.

`struct SensoryFeedback`

Represents a type of haptic and/or audio feedback that can be played.

### Sizing controls

`func controlSize(_:)`

Sets the size for controls within this view.

`var controlSize: ControlSize`

The size to apply to controls within a view.

`enum ControlSize`

The size classes, like regular or small, that you can apply to controls within a view.

## See Also

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

---

# https://developer.apple.com/documentation/swiftui/menus-and-commands

Collection

- SwiftUI
- Menus and commands

API Collection

# Menus and commands

Provide space-efficient, context-dependent access to commands and controls.

## Overview

Use a menu to provide people with easy access to common commands. You can add items to a macOS or iPadOS app’s menu bar using the `commands(content:)` scene modifier, or create context menus that people reveal near their current task using the `contextMenu(menuItems:)` view modifier.

Create submenus by nesting `Menu` instances inside others. Use a `Divider` view to create a separator between menu elements.

For design guidance, see Menus in the Human Interface Guidelines.

## Topics

### Building a menu bar

Building and customizing the menu bar with SwiftUI

Provide a seamless, cross-platform user experience by building a native menu bar for iPadOS and macOS.

### Creating a menu

Populating SwiftUI menus with adaptive controls

Improve your app by populating menus with controls and organizing your content intuitively.

`struct Menu`

A control for presenting a menu of actions.

Sets the style for menus within this view.

### Creating context menus

Adds a context menu to a view.

Adds a context menu with a custom preview to a view.

Adds an item-based context menu to a view.

### Defining commands

Adds commands to the scene.

Removes all commands defined by the modified scene.

Replaces all commands defined by the modified scene with the commands from the builder.

`protocol Commands`

Conforming types represent a group of related commands that can be exposed to the user via the main menu on macOS and key commands on iOS.

`struct CommandMenu`

Command menus are stand-alone, top-level containers for controls that perform related, app-specific commands.

`struct CommandGroup`

Groups of controls that you can add to existing command menus.

`struct CommandsBuilder`

Constructs command sets from multi-expression closures. Like `ViewBuilder`, it supports up to ten expressions in the closure body.

`struct CommandGroupPlacement`

The standard locations that you can place new command groups relative to.

### Getting built-in command groups

`struct SidebarCommands`

A built-in set of commands for manipulating window sidebars.

`struct TextEditingCommands`

A built-in group of commands for searching, editing, and transforming selections of text.

`struct TextFormattingCommands`

A built-in set of commands for transforming the styles applied to selections of text.

`struct ToolbarCommands`

A built-in set of commands for manipulating window toolbars.

`struct ImportFromDevicesCommands`

A built-in set of commands that enables importing content from nearby devices.

`struct InspectorCommands`

A built-in set of commands for manipulating inspectors.

`struct EmptyCommands`

An empty group of commands.

### Showing a menu indicator

Sets the menu indicator visibility for controls within this view.

`var menuIndicatorVisibility: Visibility`

The menu indicator visibility to apply to controls within a view.

### Configuring menu dismissal

Tells a menu whether to dismiss after performing an action.

`struct MenuActionDismissBehavior`

The set of menu dismissal behavior options.

### Setting a preferred order

Sets the preferred order of items for menus presented from this view.

`var menuOrder: MenuOrder`

The preferred order of items for menus presented from this view.

`struct MenuOrder`

The order in which a menu presents its content.

### Deprecated types

`struct MenuButton`

A button that displays a menu containing a list of choices when pressed.

Deprecated

`typealias PullDownButton` Deprecated

`struct ContextMenu`

A container for views that you present as menu items in a context menu.

## See Also

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

---

# https://developer.apple.com/documentation/swiftui/shapes

Collection

- SwiftUI
- Shapes

API Collection

# Shapes

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

## Overview

Draw shapes like circles and rectangles, as well as custom paths that define shapes of your own design. Apply styles that include environment-aware colors, rich gradients, and material effects to the foreground, background, and outline of your shapes.

If you need the efficiency or flexibility of immediate mode drawing — for example, to create particle effects — use a `Canvas` view instead.

## Topics

### Creating rectangular shapes

`struct Rectangle`

A rectangular shape aligned inside the frame of the view containing it.

`struct RoundedRectangle`

A rectangular shape with rounded corners, aligned inside the frame of the view containing it.

`enum RoundedCornerStyle`

Defines the shape of a rounded rectangle’s corners.

`protocol RoundedRectangularShape`

A protocol of `InsettableShape` that describes a rounded rectangular shape.

`struct RoundedRectangularShapeCorners`

A type describing the corner styles of a `RoundedRectangularShape`.

`struct UnevenRoundedRectangle`

A rectangular shape with rounded corners with different values, aligned inside the frame of the view containing it.

`struct RectangleCornerRadii`

Describes the corner radius values of a rounded rectangle with uneven corners.

`struct RectangleCornerInsets`

The inset sizes for the corners of a rectangle.

`struct ConcentricRectangle`

A shape that is replaced by a concentric version of the current container shape. If the container shape is a rectangle derived shape with four corners, this shape could choose to respect corners individually.

### Creating circular shapes

`struct Circle`

A circle centered on the frame of the view containing it.

`struct Ellipse`

An ellipse aligned inside the frame of the view containing it.

`struct Capsule`

A capsule shape aligned inside the frame of the view containing it.

### Drawing custom shapes

`struct Path`

The outline of a 2D shape.

### Defining shape behavior

`protocol ShapeView`

A view that provides a shape that you can use for drawing operations.

`protocol Shape`

A 2D shape that you can use when drawing a view.

`struct AnyShape`

A type-erased shape value.

`enum ShapeRole`

Ways of styling a shape.

`struct StrokeStyle`

The characteristics of a stroke that traces a path.

`struct StrokeShapeView`

A shape provider that strokes its shape.

`struct StrokeBorderShapeView`

A shape provider that strokes the border of its shape.

`struct FillStyle`

A style for rasterizing vector shapes.

`struct FillShapeView`

A shape provider that fills its shape.

### Transforming a shape

`struct ScaledShape`

A shape with a scale transform applied to it.

`struct RotatedShape`

A shape with a rotation transform applied to it.

`struct OffsetShape`

A shape with a translation offset transform applied to it.

`struct TransformedShape`

A shape with an affine transform applied to it.

### Setting a container shape

`func containerShape(_:)`

Sets the container shape to use for any container relative shape or concentric rectangle within this view.

`protocol InsettableShape`

A shape type that is able to inset itself to produce another shape.

`struct ContainerRelativeShape`

A shape that is replaced by an inset version of the current container shape. If no container shape was defined, is replaced by a rectangle.

## See Also

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Enhance your views with graphical effects and customized drawings.

---

# https://developer.apple.com/documentation/swiftui/drawing-and-graphics

Collection

- SwiftUI
- Drawing and graphics

API Collection

# Drawing and graphics

Enhance your views with graphical effects and customized drawings.

## Overview

You create rich, dynamic user interfaces with the built-in views and Shapes that SwiftUI provides. To enhance any view, you can apply many of the graphical effects typically associated with a graphics context, like setting colors, adding masks, and creating composites.

When you need the flexibility of immediate mode drawing in a graphics context, use a `Canvas` view. This can be particularly helpful when you want to draw an extremely large number of dynamic shapes — for example, to create particle effects.

For design guidance, see Materials and Color in the Human Interface Guidelines.

## Topics

### Immediate mode drawing

Add rich graphics to your SwiftUI app

Make your apps stand out by adding background materials, vibrancy, custom graphics, and animations.

`struct Canvas`

A view type that supports immediate mode drawing.

`struct GraphicsContext`

An immediate mode drawing destination, and its current state.

### Setting a color

`func tint(_:)`

Sets the tint color within this view.

`struct Color`

A representation of a color that adapts to a given context.

### Styling content

Adds a border to this view with the specified style and width.

Sets a view’s foreground elements to use a given style.

Sets the primary and secondary levels of the foreground style in the child view.

Sets the primary, secondary, and tertiary levels of the foreground style.

Sets the specified style to render backgrounds within the view.

`var backgroundStyle: AnyShapeStyle?`

An optional style that overrides the default system background style when set.

`protocol ShapeStyle`

A color or pattern to use when rendering a shape.

`struct AnyShapeStyle`

A type-erased ShapeStyle value.

`struct Gradient`

A color gradient represented as an array of color stops, each having a parametric location value.

`struct MeshGradient`

A two-dimensional gradient defined by a 2D grid of positioned colors.

`struct AnyGradient`

A color gradient.

`struct ShadowStyle`

A style to use when rendering shadows.

`struct Glass`

A structure that defines the configuration of the Liquid Glass material.

### Transforming colors

Brightens this view by the specified amount.

Sets the contrast and separation between similar colors in this view.

Inverts the colors in this view.

Adds a color multiplication effect to this view.

Adjusts the color saturation of this view.

Adds a grayscale effect to this view.

Applies a hue rotation effect to this view.

Adds a luminance to alpha effect to this view.

Sets an explicit active appearance for materials in this view.

`var materialActiveAppearance: MaterialActiveAppearance`

The behavior materials should use for their active state, defaulting to `automatic`.

`struct MaterialActiveAppearance`

The behavior for how materials appear active and inactive.

### Scaling, rotating, or transforming a view

Scales this view to fill its parent.

Scales this view to fit its parent.

`func scaleEffect(_:anchor:)`

Scales this view’s rendered output by the given amount in both the horizontal and vertical directions, relative to an anchor point.

Scales this view’s rendered output by the given horizontal and vertical amounts, relative to an anchor point.

Scales this view by the specified horizontal, vertical, and depth factors, relative to an anchor point.

`func aspectRatio(_:contentMode:)`

Constrains this view’s dimensions to the specified aspect ratio.

Rotates a view’s rendered output in two dimensions around the specified point.

Renders a view’s content as if it’s rotated in three dimensions around the specified axis.

Rotates the view’s content by the specified 3D rotation value.

`func rotation3DEffect(_:axis:anchor:)`

Rotates the view’s content by an angle about an axis that you specify as a tuple of elements.

Applies an affine transformation to this view’s rendered output.

Applies a 3D transformation to this view’s rendered output.

Applies a projection transformation to this view’s rendered output.

`struct ProjectionTransform`

`enum ContentMode`

Constants that define how a view’s content fills the available space.

### Masking and clipping

Masks this view using the alpha channel of the given view.

Clips this view to its bounding rectangular frame.

Sets a clipping shape for this view.

### Applying blur and shadows

Applies a Gaussian blur to this view.

Adds a shadow to this view.

`struct ColorMatrix`

A matrix to use in an RGBA color transformation.

### Applying effects based on geometry

Applies effects to this view, while providing access to layout information through a geometry proxy.

Applies effects to this view, while providing access to layout information through a 3D geometry proxy.

`protocol VisualEffect`

Visual Effects change the visual appearance of a view without changing its ancestors or descendents.

`struct EmptyVisualEffect`

The base visual effect that you apply additional effect to.

### Compositing views

Sets the blend mode for compositing this view with overlapping views.

Wraps this view in a compositing group.

Composites this view’s contents into an offscreen image before final display.

`enum BlendMode`

Modes for compositing a view with overlapping content.

`enum ColorRenderingMode`

The set of possible working color spaces for color-compositing operations.

`protocol CompositorContent`

`struct CompositorContentBuilder`

A result builder for composing a collection of `CompositorContent` elements.

`struct AnyCompositorContent`

Type erased compositor content.

### Measuring a view

`struct GeometryReader`

A container view that defines its content as a function of its own size and coordinate space.

`struct GeometryReader3D`

`struct GeometryProxy`

A proxy for access to the size and coordinate space (for anchor resolution) of the container view.

`struct GeometryProxy3D`

A proxy for access to the size and coordinate space of the container view.

Assigns a name to the view’s coordinate space, so other code can operate on dimensions like points and sizes relative to the named space.

`enum CoordinateSpace`

A resolved coordinate space created by the coordinate space protocol.

`protocol CoordinateSpaceProtocol`

A frame of reference within the layout system.

`struct PhysicalMetric`

Provides access to a value in points that corresponds to the specified physical measurement.

`struct PhysicalMetricsConverter`

A physical metrics converter provides conversion between point values and their extent in 3D space, in the form of physical length measurements.

### Responding to a geometry change

`func onGeometryChange(for:of:action:)`

Adds an action to be performed when a value, created from a geometry proxy, changes.

### Accessing Metal shaders

Returns a new view that applies `shader` to `self` as a filter effect on the color of each pixel.

Returns a new view that applies `shader` to `self` as a geometric distortion effect on the location of each pixel.

Returns a new view that applies `shader` to `self` as a filter on the raster layer created from `self`.

`struct Shader`

A reference to a function in a Metal shader library, along with its bound uniform argument values.

`struct ShaderFunction`

A reference to a function in a Metal shader library.

`struct ShaderLibrary`

A Metal shader library.

### Accessing geometric constructs

`enum Axis`

The horizontal or vertical dimension in a 2D coordinate system.

`struct Angle`

A geometric angle whose value you access in either radians or degrees.

`struct UnitPoint`

A normalized 2D point in a view’s coordinate space.

`struct UnitPoint3D`

A normalized 3D point in a view’s coordinate space.

`struct Anchor`

An opaque value derived from an anchor source and a particular view.

`protocol DepthAlignmentID`

`struct Alignment3D`

An alignment in all three axes.

`struct GeometryProxyCoordinateSpace3D`

A representation of a `GeometryProxy3D` which can be used for `CoordinateSpace3D` based conversions.

## See Also

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

---

# https://developer.apple.com/documentation/swiftui/layout-fundamentals

Collection

- SwiftUI
- Layout fundamentals

API Collection

# Layout fundamentals

Arrange views inside built-in layout containers like stacks and grids.

## Overview

Use layout containers to arrange the elements of your user interface. Stacks and grids update and adjust the positions of the subviews they contain in response to changes in content or interface dimensions. You can nest layout containers inside other layout containers to any depth to achieve complex layout effects.

To finetune the position, alignment, and other elements of a layout that you build with layout container views, see Layout adjustments. To define custom layout containers, see Custom layout. For design guidance, see Layout in the Human Interface Guidelines.

## Topics

### Choosing a layout

Picking container views for your content

Build flexible user interfaces by using stacks, grids, lists, and forms.

### Statically arranging views in one dimension

Building layouts with stack views

Compose complex layouts from primitive container views.

`struct HStack`

A view that arranges its subviews in a horizontal line.

`struct VStack`

A view that arranges its subviews in a vertical line.

### Dynamically arranging views in one dimension

Grouping data with lazy stack views

Split content into logical sections inside lazy stack views.

Creating performant scrollable stacks

Display large numbers of repeated views efficiently with scroll views, stack views, and lazy stacks.

`struct LazyHStack`

A view that arranges its children in a line that grows horizontally, creating items only as needed.

`struct LazyVStack`

A view that arranges its children in a line that grows vertically, creating items only as needed.

`struct PinnedScrollableViews`

A set of view types that may be pinned to the bounds of a scroll view.

### Statically arranging views in two dimensions

`struct Grid`

A container view that arranges other views in a two dimensional layout.

`struct GridRow`

A horizontal row in a two dimensional grid container.

Tells a view that acts as a cell in a grid to span the specified number of columns.

Specifies a custom alignment anchor for a view that acts as a grid cell.

Asks grid layouts not to offer the view extra size in the specified axes.

Overrides the default horizontal alignment of the grid column that the view appears in.

### Dynamically arranging views in two dimensions

`struct LazyHGrid`

A container view that arranges its child views in a grid that grows horizontally, creating items only as needed.

`struct LazyVGrid`

A container view that arranges its child views in a grid that grows vertically, creating items only as needed.

`struct GridItem`

A description of a row or a column in a lazy grid.

### Layering views

Adding a background to your view

Compose a background behind your view and extend it beyond the safe area insets.

`struct ZStack`

A view that overlays its subviews, aligning them in both axes.

Controls the display order of overlapping views.

Layers the views that you specify behind this view.

Sets the view’s background to a style.

Sets the view’s background to the default background style.

`func background(_:in:fillStyle:)`

Sets the view’s background to an insettable shape filled with a style.

`func background(in:fillStyle:)`

Sets the view’s background to an insettable shape filled with the default background style.

Layers the views that you specify in front of this view.

Layers the specified style in front of this view.

Layers a shape that you specify in front of this view.

`var backgroundMaterial: Material?`

The material underneath the current view.

Sets the container background of the enclosing container using a view.

`struct ContainerBackgroundPlacement`

The placement of a container background.

### Automatically choosing the layout that fits

`struct ViewThatFits`

A view that adapts to the available space by providing the first child view that fits.

### Separators

`struct Spacer`

A flexible space that expands along the major axis of its containing stack layout, or on both axes if not contained in a stack.

`struct Divider`

A visual element that can be used to separate other content.

## See Also

### View layout

Make fine adjustments to alignment, spacing, padding, and other layout parameters.

Place views in custom arrangements and create animated transitions between layout types.

Display a structured, scrollable column of information.

Display selectable, sortable data arranged in rows and columns.

Present views in different kinds of purpose-driven containers, like forms or control groups.

Enable people to scroll to content that doesn’t fit in the current display.

---

# https://developer.apple.com/documentation/swiftui/layout-adjustments

Collection

- SwiftUI
- Layout adjustments

API Collection

# Layout adjustments

Make fine adjustments to alignment, spacing, padding, and other layout parameters.

## Overview

Layout containers like stacks and grids provide a great starting point for arranging views in your app’s user interface. When you need to make fine adjustments, use layout view modifiers. You can adjust or constrain the size, position, and alignment of a view. You can also add padding around a view, and indicate how the view interacts with system-defined safe areas.

To get started with a basic layout, see Layout fundamentals. For design guidance, see Layout in the Human Interface Guidelines.

## Topics

### Finetuning a layout

Laying out a simple view

Create a view layout by adjusting the size of views.

Inspecting view layout

Determine the position and extent of a view using Xcode previews or by adding temporary borders.

### Adding padding around a view

`func padding(_:)`

Adds a different padding amount to each edge of this view.

Adds an equal padding amount to specific edges of this view.

`func padding3D(_:)`

Pads this view using the edge insets you specify.

Adds padding to the specified edges of this view using an amount that’s appropriate for the current scene.

Adds a specified kind of padding to the specified edges of this view using an amount that’s appropriate for the current scene.

`struct ScenePadding`

The padding used to space a view from its containing scene.

### Influencing a view’s size

Positions this view within an invisible frame with the specified size.

Positions this view within an invisible frame with the specified depth.

Positions this view within an invisible frame having the specified size constraints.

Positions this view within an invisible frame having the specified depth constraints.

Positions this view within an invisible frame with a size relative to the nearest container.

Fixes this view at its ideal size.

Fixes this view at its ideal size in the specified dimensions.

Sets the priority by which a parent layout should apportion space to this child.

### Adjusting a view’s position

Making fine adjustments to a view’s position

Shift the position of a view by applying the offset or position modifier.

Positions the center of this view at the specified point in its parent’s coordinate space.

Positions the center of this view at the specified coordinates in its parent’s coordinate space.

Offset this view by the horizontal and vertical amount specified in the offset parameter.

Offset this view by the specified horizontal and vertical distances.

Brings a view forward in Z by the provided distance in points.

### Aligning views

Aligning views within a stack

Position views inside a stack using alignment guides.

Aligning views across stacks

Create a custom alignment and use it to align views across multiple stacks.

`func alignmentGuide(_:computeValue:)`

Sets the view’s horizontal alignment.

`struct Alignment`

An alignment in both axes.

`struct HorizontalAlignment`

An alignment position along the horizontal axis.

`struct VerticalAlignment`

An alignment position along the vertical axis.

`struct DepthAlignment`

An alignment position along the depth axis.

`protocol AlignmentID`

A type that you use to create custom alignment guides.

`struct ViewDimensions`

A view’s size and alignment guides in its own coordinate space.

`struct ViewDimensions3D`

A view’s 3D size and alignment guides in its own coordinate space.

`struct SpatialContainer`

A layout container that aligns overlapping content in 3D space.

### Setting margins

Configures the content margin for a provided placement.

`func contentMargins(_:_:for:)`

`struct ContentMarginPlacement`

The placement of margins.

### Staying in the safe areas

Expands the safe area of a view.

`func safeAreaInset(edge:alignment:spacing:content:)`

Shows the specified content beside the modified view.

`func safeAreaPadding(_:)`

Adds the provided insets into the safe area of this view.

`struct SafeAreaRegions`

A set of symbolic safe area regions.

### Setting a layout direction

Sets the behavior of this view for different layout directions.

`enum LayoutDirectionBehavior`

A description of what should happen when the layout direction changes.

`var layoutDirection: LayoutDirection`

The layout direction associated with the current environment.

`enum LayoutDirection`

A direction in which SwiftUI can lay out content.

`struct LayoutRotationUnaryLayout`

### Reacting to interface characteristics

`var isLuminanceReduced: Bool`

A Boolean value that indicates whether the display or environment currently requires reduced luminance.

`var displayScale: CGFloat`

The display scale of this environment.

`var pixelLength: CGFloat`

The size of a pixel on the screen.

`var horizontalSizeClass: UserInterfaceSizeClass?`

The horizontal size class of this environment.

`var verticalSizeClass: UserInterfaceSizeClass?`

The vertical size class of this environment.

`enum UserInterfaceSizeClass`

A set of values that indicate the visual size available to the view.

### Accessing edges, regions, and layouts

`enum Edge`

An enumeration to indicate one edge of a rectangle.

`enum Edge3D`

An edge or face of a 3D volume.

`enum HorizontalEdge`

An edge on the horizontal axis.

`enum VerticalEdge`

An edge on the vertical axis.

`struct EdgeInsets`

The inset distances for the sides of a rectangle.

`struct EdgeInsets3D`

The inset distances for the faces of a 3D volume.

## See Also

### View layout

Arrange views inside built-in layout containers like stacks and grids.

Place views in custom arrangements and create animated transitions between layout types.

Display a structured, scrollable column of information.

Display selectable, sortable data arranged in rows and columns.

Present views in different kinds of purpose-driven containers, like forms or control groups.

Enable people to scroll to content that doesn’t fit in the current display.

---

# https://developer.apple.com/documentation/swiftui/custom-layout

Collection

- SwiftUI
- Custom layout

API Collection

# Custom layout

Place views in custom arrangements and create animated transitions between layout types.

## Overview

You can create complex view layouts using the built-in layout containers and layout view modifiers that SwiftUI provides. However, if you need behavior that you can’t achieve with the built-in layout tools, create a custom layout container type using the `Layout` protocol. A container that you define asks for the sizes of all its subviews, and then indicates where to place the subviews within its own bounds.

You can also create animated transitions among layout types that conform to the `Layout` procotol, including both built-in and custom layouts.

For design guidance, see Layout in the Human Interface Guidelines.

## Topics

### Creating a custom layout container

Composing custom layouts with SwiftUI

Arrange views in your app’s interface using layout tools that SwiftUI provides.

`protocol Layout`

A type that defines the geometry of a collection of views.

`struct LayoutSubview`

A proxy that represents one subview of a layout.

`struct LayoutSubviews`

A collection of proxy values that represent the subviews of a layout view.

### Configuring a custom layout

`struct LayoutProperties`

Layout-specific properties of a layout container.

`struct ProposedViewSize`

A proposal for the size of a view.

`struct ViewSpacing`

A collection of the geometric spacing preferences of a view.

### Associating values with views in a custom layout

Associates a value with a custom layout property.

`protocol LayoutValueKey`

A key for accessing a layout value of a layout container’s subviews.

### Transitioning between layout types

`struct AnyLayout`

A type-erased instance of the layout protocol.

`struct HStackLayout`

A horizontal container that you can use in conditional layouts.

`struct VStackLayout`

A vertical container that you can use in conditional layouts.

`struct ZStackLayout`

An overlaying container that you can use in conditional layouts.

`struct GridLayout`

A grid that you can use in conditional layouts.

## See Also

### View layout

Arrange views inside built-in layout containers like stacks and grids.

Make fine adjustments to alignment, spacing, padding, and other layout parameters.

Display a structured, scrollable column of information.

Display selectable, sortable data arranged in rows and columns.

Present views in different kinds of purpose-driven containers, like forms or control groups.

Enable people to scroll to content that doesn’t fit in the current display.

---

# https://developer.apple.com/documentation/swiftui/lists

Collection

- SwiftUI
- Lists

API Collection

# Lists

Display a structured, scrollable column of information.

## Overview

Use a list to display a one-dimensional vertical collection of views.

The list is a complex container type that automatically provides scrolling when it grows too large for the current display. You build a list by providing it with individual views for the rows in the list, or by using a `ForEach` to enumerate a group of rows. You can also mix these strategies, blending any number of individual views and `ForEach` constructs.

Use view modifiers to configure the appearance and behavior of a list and its rows, headers, sections, and separators. For example, you can apply a style to the list, add swipe gestures to individual rows, or make the list refreshable with a pull-down gesture. You can also use the configuration associated with Scroll views to control the list’s implicit scrolling behavior.

For design guidance, see Lists and tables in the Human Interface Guidelines.

## Topics

### Creating a list

Displaying data in lists

Visualize collections of data with platform-appropriate appearance.

`struct List`

A container that presents rows of data arranged in a single column, optionally providing the ability to select one or more members.

Sets the style for lists within this view.

### Disclosing information progressively

`struct OutlineGroup`

A structure that computes views and disclosure groups on demand from an underlying collection of tree-structured, identified data.

`struct DisclosureGroup`

A view that shows or hides another content view, based on the state of a disclosure control.

Sets the style for disclosure groups within this view.

### Configuring a list’s layout

Applies an inset to the rows in a list.

`var defaultMinListRowHeight: CGFloat`

The default minimum height of rows in a list.

`var defaultMinListHeaderHeight: CGFloat?`

The default minimum height of a header in a list.

Sets the vertical spacing between two adjacent rows in a List.

`func listSectionSpacing(_:)`

Sets the spacing between adjacent sections in a `List` to a custom value.

`struct ListSectionSpacing`

The spacing options between two adjacent sections in a list.

Set the section margins for the specific edges.

### Configuring rows

`func listItemTint(_:)`

Sets a fixed tint color for content in a list.

`struct ListItemTint`

A tint effect configuration that you can apply to content in a list.

### Configuring headers

Sets the header prominence for this view.

`var headerProminence: Prominence`

The prominence to apply to section headers within a view.

`enum Prominence`

A type indicating the prominence of a view hierarchy.

### Configuring separators

Sets the tint color associated with a row.

Sets the tint color associated with a section.

Sets the display mode for the separator associated with this specific row.

Sets whether to hide the separator associated with a list section.

### Configuring backgrounds

Places a custom background view behind a list row item.

Overrides whether lists and tables in this view have alternating row backgrounds.

`struct AlternatingRowBackgroundBehavior`

The styling of views with respect to alternating row backgrounds.

`var backgroundProminence: BackgroundProminence`

The prominence of the background underneath views associated with this environment.

`struct BackgroundProminence`

The prominence of backgrounds underneath other views.

### Displaying a badge on a list item

`func badge(_:)`

Generates a badge for the view from an integer value.

Specifies the prominence of badges created by this view.

`var badgeProminence: BadgeProminence`

The prominence to apply to badges associated with this environment.

`struct BadgeProminence`

The visual prominence of a badge.

### Configuring interaction

Adds custom swipe actions to a row in a list.

Adds a condition that controls whether users can select this view.

Requests that the containing list row use the provided hover effect.

Requests that the containing list row have its hover effect disabled.

### Refreshing a list’s content

Marks this view as refreshable.

`var refresh: RefreshAction?`

A refresh action stored in a view’s environment.

`struct RefreshAction`

An action that initiates a refresh operation.

### Editing a list

Adds a condition for whether the view’s view hierarchy is movable.

Adds a condition for whether the view’s view hierarchy is deletable.

An indication of whether the user can edit the contents of a view associated with this environment.

`enum EditMode`

A mode that indicates whether the user can edit a view’s content.

`struct EditActions`

A set of edit actions on a collection of data that a view can offer to a user.

`struct EditableCollectionContent`

An opaque wrapper view that adds editing capabilities to a row in a list.

`struct IndexedIdentifierCollection`

A collection wrapper that iterates over the indices and identifiers of a collection together.

### Configuring a section index

Changes the visibility of the list section index.

`func sectionIndexLabel(_:)`

Sets the label that is used in a section index to point to this section, typically only a single character long.

## See Also

### View layout

Arrange views inside built-in layout containers like stacks and grids.

Make fine adjustments to alignment, spacing, padding, and other layout parameters.

Place views in custom arrangements and create animated transitions between layout types.

Display selectable, sortable data arranged in rows and columns.

Present views in different kinds of purpose-driven containers, like forms or control groups.

Enable people to scroll to content that doesn’t fit in the current display.

---

# https://developer.apple.com/documentation/swiftui/tables

Collection

- SwiftUI
- Tables

API Collection

# Tables

Display selectable, sortable data arranged in rows and columns.

## Overview

Use a table to display multiple values across a collection of elements. Each element in the collection appears in a different row of the table, while each value for a given element appears in a different column. Narrow displays may adapt to show only the first column of the table.

When you create a table, you provide a collection of elements, and then tell the table how to find the needed value for each column. In simple cases, SwiftUI infers the element for each row, but you can also specify the row elements explicitly in more complex scenarios. With a small amount of additional configuration, you can also make the items in the table selectable, and the columns sortable.

Like a `List`, a table includes implicit vertical scrolling that you can configure using the view modifiers described in Scroll views. For design guidance, see Lists and tables in the Human Interface Guidelines.

## Topics

### Creating a table

Building a great Mac app with SwiftUI

Create engaging SwiftUI Mac apps by incorporating side bars, tables, toolbars, and several other popular user interface elements.

`struct Table`

A container that presents rows of data arranged in one or more columns, optionally providing the ability to select one or more members.

Sets the style for tables within this view.

### Creating columns

`struct TableColumn`

A column that displays a view for each row in a table.

`protocol TableColumnContent`

A type used to represent columns within a table.

`struct TableColumnAlignment`

Describes the alignment of the content of a table column.

`struct TableColumnBuilder`

A result builder that creates table column content from closures.

`struct TableColumnForEach`

A structure that computes columns on demand from an underlying collection of identified data.

### Customizing columns

Controls the visibility of a `Table`’s column header views.

`struct TableColumnCustomization`

A representation of the state of the columns in a table.

`struct TableColumnCustomizationBehavior`

A set of customization behaviors of a column that a table can offer to a user.

### Creating rows

`struct TableRow`

A row that represents a data value in a table.

`protocol TableRowContent`

A type used to represent table rows.

`struct TableHeaderRowContent`

A table row that displays a single view instead of columned content.

`struct TupleTableRowContent`

A type of table column content that creates table rows created from a Swift tuple of table rows.

`struct TableForEachContent`

A type of table row content that creates table rows created by iterating over a collection.

`struct EmptyTableRowContent`

A table row content that doesn’t produce any rows.

`protocol DynamicTableRowContent`

A type of table row content that generates table rows from an underlying collection of data.

`struct TableRowBuilder`

A result builder that creates table row content from closures.

### Adding progressive disclosure

`struct DisclosureTableRow`

A kind of table row that shows or hides additional rows based on the state of a disclosure control.

`struct TableOutlineGroupContent`

An opaque table row type created by a table’s hierarchical initializers.

## See Also

### View layout

Arrange views inside built-in layout containers like stacks and grids.

Make fine adjustments to alignment, spacing, padding, and other layout parameters.

Place views in custom arrangements and create animated transitions between layout types.

Display a structured, scrollable column of information.

Present views in different kinds of purpose-driven containers, like forms or control groups.

Enable people to scroll to content that doesn’t fit in the current display.

---

# https://developer.apple.com/documentation/swiftui/view-groupings

Collection

- SwiftUI
- View groupings

API Collection

# View groupings

Present views in different kinds of purpose-driven containers, like forms or control groups.

## Overview

You can create groups of views that serve different purposes.

For example, a `Group` construct treats the specified views as a unit without imposing any additional layout or appearance characteristics. A `Form` presents a group of elements with a platform-specific appearance that’s suitable for gathering input from people.

For design guidance, see Layout in the Human Interface Guidelines.

## Topics

### Grouping views into a container

Creating custom container views

Access individual subviews to compose flexible container views.

`struct Group`

A type that collects multiple instances of a content type — like views, scenes, or commands — into a single unit.

`struct GroupElementsOfContent`

Transforms the subviews of a given view into a resulting content view.

`struct GroupSectionsOfContent`

Transforms the sections of a given view into a resulting content view.

### Organizing views into sections

`struct Section`

A container view that you can use to add hierarchy within certain views.

`struct SectionCollection`

An opaque collection representing the sections of view.

`struct SectionConfiguration`

Specifies the contents of a section.

### Iterating over dynamic data

`struct ForEach`

A structure that computes views on demand from an underlying collection of identified data.

`struct ForEachSectionCollection`

A collection which allows a view to be treated as a collection of its sections in a for each loop.

`struct ForEachSubviewCollection`

A collection which allows a view to be treated as a collection of its subviews in a for each loop.

`protocol DynamicViewContent`

A type of view that generates views from an underlying collection of data.

### Accessing a container’s subviews

`struct Subview`

An opaque value representing a subview of another view.

`struct SubviewsCollection`

An opaque collection representing the subviews of view.

`struct SubviewsCollectionSlice`

A slice of a SubviewsCollection.

Sets a particular container value of a view.

`struct ContainerValues`

A collection of container values associated with a given view.

`protocol ContainerValueKey`

A key for accessing container values.

### Grouping views into a box

`struct GroupBox`

A stylized view, with an optional label, that visually collects a logical grouping of content.

Sets the style for group boxes within this view.

### Grouping inputs

`struct Form`

A container for grouping controls used for data entry, such as in settings or inspectors.

Sets the style for forms in a view hierarchy.

`struct LabeledContent`

A container for attaching a label to a value-bearing view.

Sets a style for labeled content.

### Presenting a group of controls

`struct ControlGroup`

A container view that displays semantically-related controls in a visually-appropriate manner for the context

Sets the style for control groups within this view.

## See Also

### View layout

Arrange views inside built-in layout containers like stacks and grids.

Make fine adjustments to alignment, spacing, padding, and other layout parameters.

Place views in custom arrangements and create animated transitions between layout types.

Display a structured, scrollable column of information.

Display selectable, sortable data arranged in rows and columns.

Enable people to scroll to content that doesn’t fit in the current display.

---

# https://developer.apple.com/documentation/swiftui/scroll-views

Collection

- SwiftUI
- Scroll views

API Collection

# Scroll views

Enable people to scroll to content that doesn’t fit in the current display.

## Overview

When the content of a view doesn’t fit in the display, you can wrap the view in a `ScrollView` to enable people to scroll on one or more axes. Configure the scroll view using view modifiers. For example, you can set the visibility of the scroll indicators or the availability of scrolling in a given dimension.

You can put any view type in a scroll view, but you most often use a scroll view for a layout container with too many elements to fit in the display. For some container views that you put in a scroll view, like lazy stacks, the container doesn’t load views until they are visible or almost visible. For others, like regular stacks and grids, the container loads the content all at once, regardless of the state of scrolling.

Lists and Tables implicitly include a scroll view, so you don’t need to add scrolling to those container types. However, you can configure their implicit scroll views with the same view modifiers that apply to explicit scroll views.

For design guidance, see Scroll views in the Human Interface Guidelines.

## Topics

### Creating a scroll view

`struct ScrollView`

A scrollable view.

`struct ScrollViewReader`

A view that provides programmatic scrolling, by working with a proxy to scroll to known child views.

`struct ScrollViewProxy`

A proxy value that supports programmatic scrolling of the scrollable views within a view hierarchy.

### Managing scroll position

Associates a binding to a scroll position with a scroll view within this view.

Associates a binding to be updated when a scroll view within this view scrolls.

Associates an anchor to control which part of the scroll view’s content should be rendered by default.

Associates an anchor to control the position of a scroll view in a particular circumstance.

`struct ScrollAnchorRole`

A type defining the role of a scroll anchor.

`struct ScrollPosition`

A type that defines the semantic position of where a scroll view is scrolled within its content.

### Defining scroll targets

Sets the scroll behavior of views scrollable in the provided axes.

Configures the outermost layout as a scroll target layout.

`struct ScrollTarget`

A type defining the target in which a scroll view should try and scroll to.

`protocol ScrollTargetBehavior`

A type that defines the scroll behavior of a scrollable view.

`struct ScrollTargetBehaviorContext`

The context in which a scroll target behavior updates its scroll target.

`struct PagingScrollTargetBehavior`

The scroll behavior that aligns scroll targets to container-based geometry.

`struct ViewAlignedScrollTargetBehavior`

The scroll behavior that aligns scroll targets to view-based geometry.

`struct AnyScrollTargetBehavior`

A type-erased scroll target behavior.

`struct ScrollTargetBehaviorProperties`

Properties influencing the scroll view a scroll target behavior applies to.

`struct ScrollTargetBehaviorPropertiesContext`

The context in which a scroll target behavior can decide its properties.

### Animating scroll transitions

Applies the given transition, animating between the phases of the transition as this view appears and disappears within the visible region of the containing scroll view.

`enum ScrollTransitionPhase`

The phases that a view transitions between when it scrolls among other views.

`struct ScrollTransitionConfiguration`

The configuration of a scroll transition that controls how a transition is applied as a view is scrolled through the visible region of a containing scroll view or other container.

### Responding to scroll view changes

Adds an action to be performed when a value, created from a scroll geometry, changes.

Adds an action to be called with information about what views would be considered visible.

Adds an action to be called when the view crosses the threshold to be considered on/off screen.

`func onScrollPhaseChange(_:)`

Adds an action to perform when the scroll phase of the first scroll view in the hierarchy changes.

`struct ScrollGeometry`

A type that defines the geometry of a scroll view.

`enum ScrollPhase`

A type that describes the state of a scroll gesture of a scrollable view like a scroll view.

`struct ScrollPhaseChangeContext`

A type that provides you with more content when the phase of a scroll view changes.

### Showing scroll indicators

Flashes the scroll indicators of a scrollable view when it appears.

Flashes the scroll indicators of scrollable views when a value changes.

Sets the visibility of scroll indicators within this view.

`var horizontalScrollIndicatorVisibility: ScrollIndicatorVisibility`

The visibility to apply to scroll indicators of any horizontally scrollable content.

`var verticalScrollIndicatorVisibility: ScrollIndicatorVisibility`

The visiblity to apply to scroll indicators of any vertically scrollable content.

`struct ScrollIndicatorVisibility`

The visibility of scroll indicators of a UI element.

### Managing content visibility

Specifies the visibility of the background for scrollable views within this view.

Sets whether a scroll view clips its content to its bounds.

`struct ScrollContentOffsetAdjustmentBehavior`

A type that defines the different kinds of content offset adjusting behaviors a scroll view can have.

### Disabling scrolling

Disables or enables scrolling in scrollable views.

`var isScrollEnabled: Bool`

A Boolean value that indicates whether any scroll views associated with this environment allow scrolling to occur.

### Configuring scroll bounce behavior

Configures the bounce behavior of scrollable views along the specified axis.

`var horizontalScrollBounceBehavior: ScrollBounceBehavior`

The scroll bounce mode for the horizontal axis of scrollable views.

`var verticalScrollBounceBehavior: ScrollBounceBehavior`

The scroll bounce mode for the vertical axis of scrollable views.

`struct ScrollBounceBehavior`

The ways that a scrollable view can bounce when it reaches the end of its content.

### Configuring scroll edge effects

Configures the scroll edge effect style for scroll views within this hierarchy.

Hides any scroll edge effects for scroll views within this hierarchy.

`struct ScrollEdgeEffectStyle`

A structure that defines the style of pocket a scroll view will have.

`func safeAreaBar(edge:alignment:spacing:content:)`

Shows the specified content as a custom bar beside the modified view.

### Interacting with a software keyboard

Configures the behavior in which scrollable content interacts with the software keyboard.

`var scrollDismissesKeyboardMode: ScrollDismissesKeyboardMode`

The way that scrollable content interacts with the software keyboard.

`struct ScrollDismissesKeyboardMode`

The ways that scrollable content can interact with the software keyboard.

### Managing scrolling for different inputs

Enables or disables scrolling in scrollable views when using particular inputs.

`struct ScrollInputKind`

Inputs used to scroll views.

`struct ScrollInputBehavior`

A type that defines whether input should scroll a view.

## See Also

### View layout

Arrange views inside built-in layout containers like stacks and grids.

Make fine adjustments to alignment, spacing, padding, and other layout parameters.

Place views in custom arrangements and create animated transitions between layout types.

Display a structured, scrollable column of information.

Display selectable, sortable data arranged in rows and columns.

Present views in different kinds of purpose-driven containers, like forms or control groups.

---

# https://developer.apple.com/documentation/swiftui/gestures

Collection

- SwiftUI
- Gestures

API Collection

# Gestures

Define interactions from taps, clicks, and swipes to fine-grained gestures.

## Overview

Respond to gestures by adding gesture modifiers to your views. You can listen for taps, drags, pinches, and other standard gestures.

You can also compose custom gestures from individual gestures using the `simultaneously(with:)`, `sequenced(before:)`, or `exclusively(before:)` modifiers, or combine gestures with keyboard modifiers using the `modifiers(_:)` modifier.

For design guidance, see Gestures in the Human Interface Guidelines.

## Topics

### Essentials

Adding interactivity with gestures

Use gesture modifiers to add interactivity to your app.

### Recognizing tap gestures

Adds an action to perform when this view recognizes a tap gesture.

`func onTapGesture(count:coordinateSpace:perform:)`

Adds an action to perform when this view recognizes a tap gesture, and provides the action with the location of the interaction.

`struct TapGesture`

A gesture that recognizes one or more taps.

`struct SpatialTapGesture`

A gesture that recognizes one or more taps and reports their location.

### Recognizing long press gestures

Adds an action to perform when this view recognizes a long press gesture.

Adds an action to perform when this view recognizes a remote long touch gesture. A long touch gesture is when the finger is on the remote touch surface without actually pressing.

`struct LongPressGesture`

A gesture that succeeds when the user performs a long press.

### Recognizing spatial events

`struct SpatialEventGesture`

A gesture that provides information about ongoing spatial events like clicks and touches.

`struct SpatialEventCollection`

A collection of spatial input events that target a specific view.

`enum Chirality`

The chirality, or handedness, of a pose.

### Recognizing gestures that change over time

`func gesture(_:)`

Attaches an `NSGestureRecognizerRepresentable` to the view.

Attaches a gesture to the view with a lower precedence than gestures defined by the view.

`struct DragGesture`

A dragging motion that invokes an action as the drag-event sequence changes.

`struct WindowDragGesture`

A gesture that recognizes the motion of and handles dragging a window.

`struct MagnifyGesture`

A gesture that recognizes a magnification motion and tracks the amount of magnification.

`struct RotateGesture`

A gesture that recognizes a rotation motion and tracks the angle of the rotation.

`struct RotateGesture3D`

A gesture that recognizes 3D rotation motion and tracks the angle and axis of the rotation.

`struct GestureMask`

Options that control how adding a gesture to a view affects other gestures recognized by the view and its subviews.

### Recognizing Apple Pencil gestures

Adds an action to perform after the user double-taps their Apple Pencil.

Adds an action to perform when the user squeezes their Apple Pencil.

`var preferredPencilDoubleTapAction: PencilPreferredAction`

The action that the user prefers to perform after double-tapping their Apple Pencil, as selected in the Settings app.

`var preferredPencilSqueezeAction: PencilPreferredAction`

The action that the user prefers to perform when squeezing their Apple Pencil, as selected in the Settings app.

`struct PencilPreferredAction`

An action that the user prefers to perform after double-tapping their Apple Pencil.

`struct PencilDoubleTapGestureValue`

Describes the value of an Apple Pencil double-tap gesture.

`struct PencilSqueezeGestureValue`

Describes the value of an Apple Pencil squeeze gesture.

`enum PencilSqueezeGesturePhase`

Describes the phase and value of an Apple Pencil squeeze gesture.

`struct PencilHoverPose`

A value describing the location and distance of an Apple Pencil hovering in the area above a view’s bounds.

### Combining gestures

Composing SwiftUI gestures

Combine gestures to create complex interactions.

Attaches a gesture to the view to process simultaneously with gestures defined by the view.

`struct SequenceGesture`

A gesture that’s a sequence of two gestures.

`struct SimultaneousGesture`

A gesture containing two gestures that can happen at the same time with neither of them preceding the other.

`struct ExclusiveGesture`

A gesture that consists of two gestures where only one of them can succeed.

### Defining custom gestures

Attaches a gesture to the view with a higher precedence than gestures defined by the view.

Assigns a hand gesture shortcut to the modified control.

Sets the screen edge from which you want your gesture to take precedence over the system gesture.

`protocol Gesture`

An instance that matches a sequence of events to a gesture, and returns a stream of values for each of its states.

`struct AnyGesture`

A type-erased gesture.

`struct HandActivationBehavior`

An activation behavior specific to hand-driven input.

`struct HandGestureShortcut`

Hand gesture shortcuts describe finger and wrist movements that the user can perform in order to activate a button or toggle.

### Managing gesture state

`struct GestureState`

A property wrapper type that updates a property while the user performs a gesture and resets the property

A gesture that updates the state provided by a gesture’s updating callback.

### Handling activation events

Configures whether gestures in this view hierarchy can handle events that activate the containing window.

### Deprecated gestures

`struct MagnificationGesture`

Deprecated

`struct RotationGesture`

## See Also

### Event handling

Respond to input from a hardware device, like a keyboard or a Touch Bar.

Enable people to move or duplicate items by issuing Copy and Paste commands.

Enable people to move or duplicate items by dragging them from one location to another.

Identify and control which visible object responds to user interaction.

React to system events, like opening a URL.

---

# https://developer.apple.com/documentation/swiftui/input-events

Collection

- SwiftUI
- Input events

API Collection

# Input events

Respond to input from a hardware device, like a keyboard or a Touch Bar.

## Overview

SwiftUI provides view modifiers that enable your app to listen for and react to various kinds of user input. For example, you can create keyboard shortcuts, respond to a form submission, or take input from the digital crown of an Apple Watch.

For design guidance, see Inputs in the Human Interface Guidelines.

## Topics

### Responding to keyboard input

Performs an action if the user presses a key on a hardware keyboard while the view has focus.

Performs an action if the user presses any key on a hardware keyboard while the view has focus.

Performs an action if the user presses one or more keys on a hardware keyboard while the view has focus.

`struct KeyPress`

### Creating keyboard shortcuts

`func keyboardShortcut(_:)`

Assigns a keyboard shortcut to the modified control.

Defines a keyboard shortcut and assigns it to the modified control.

`var keyboardShortcut: KeyboardShortcut?`

The keyboard shortcut that buttons in this environment will be triggered with.

`struct KeyboardShortcut`

Keyboard shortcuts describe combinations of keys on a keyboard that the user can press in order to activate a button or toggle.

`struct KeyEquivalent`

Key equivalents consist of a letter, punctuation, or function key that can be combined with an optional set of modifier keys to specify a keyboard shortcut.

`struct EventModifiers`

A set of key modifiers that you can add to a gesture.

### Responding to modifier keys

Performs an action whenever the user presses or releases a hardware modifier key.

Builds a view to use in place of the modified view when the user presses the modifier key(s) indicated by the given set.

### Responding to hover events

Adds an action to perform when the user moves the pointer over or away from the view’s frame.

`func onContinuousHover(coordinateSpace:perform:)`

Adds an action to perform when the pointer enters, moves within, and exits the view’s bounds.

`func hoverEffect(_:isEnabled:)`

Applies a hover effect to this view.

Adds a condition that controls whether this view can display hover effects.

`func defaultHoverEffect(_:)`

Sets the default hover effect to use for views within this view.

`var isHoverEffectEnabled: Bool`

A Boolean value that indicates whether the view associated with this environment allows hover effects to be displayed.

`enum HoverPhase`

The current hovering state and value of the pointer.

`struct HoverEffectPhaseOverride`

Options for overriding a hover effect’s current phase.

`struct OrnamentHoverContentEffect`

Presents an ornament on hover using a custom effect.

`struct OrnamentHoverEffect`

Presents an ornament on hover.

### Modifying pointer appearance

Sets the pointer style to display when the pointer is over the view.

`struct PointerStyle`

A style describing the appearance of the pointer (also called a cursor) when it’s hovered over a view.

Sets the visibility of the pointer when it’s over the view.

### Changing view appearance for hover events

`struct HoverEffect`

An effect applied when the pointer hovers over a view.

Applies a hover effect to this view, optionally adding it to a `HoverEffectGroup`.

Applies a hover effect to this view described by the given closure.

`protocol CustomHoverEffect`

A type that represents how a view should change when a pointer hovers over a view, or when someone looks at the view.

`struct ContentHoverEffect`

A `CustomHoverEffect` that applies effects to a view on hover using a closure.

`struct HoverEffectGroup`

Describes a grouping of effects that activate together.

Adds an implicit `HoverEffectGroup` to all effects defined on descendant views, so that all effects added to subviews activate as a group whenever this view or any descendant views are hovered.

Adds a `HoverEffectGroup` to all effects defined on descendant views, and activates the group whenever this view or any descendant views are hovered.

`struct GroupHoverEffect`

A `CustomHoverEffect` that activates a named group of effects.

`protocol HoverEffectContent`

A type that describes the effects of a view for a particular hover effect phase.

`struct EmptyHoverEffectContent`

An empty base effect that you use to build other effects.

Sets the behavior of the hand pointer while the user is interacting with the view.

`struct HandPointerBehavior`

A behavior that can be applied to the hand pointer while the user is interacting with a view.

### Responding to submission events

Adds an action to perform when the user submits a value to this view.

Prevents submission triggers originating from this view to invoke a submission action configured by a submission modifier higher up in the view hierarchy.

`struct SubmitTriggers`

A type that defines various triggers that result in the firing of a submission action.

### Labeling a submission event

Sets the submit label for this view.

`struct SubmitLabel`

A semantic label describing the label of submission within a view hierarchy.

### Responding to commands

Adds an action to perform in response to a move command, like when the user presses an arrow key on a Mac keyboard, or taps the edge of the Siri Remote when controlling an Apple TV.

Adds an action to perform in response to the system’s Delete command, or pressing either the ⌫ (backspace) or ⌦ (forward delete) keys while the view has focus.

Steps a value through a range in response to page up or page down commands.

Sets up an action that triggers in response to receiving the exit command while the view has focus.

Adds an action to perform in response to the system’s Play/Pause command.

Adds an action to perform in response to the given selector.

`enum MoveCommandDirection`

Specifies the direction of an arrow key movement.

### Controlling hit testing

Sets whether text in this view can compress the space between characters when necessary to fit text in a line.

Defines the content shape for hit testing.

Sets the content shape for this view.

`struct ContentShapeKinds`

A kind for the content shape of a view.

### Interacting with the Digital Crown

Specifies the visibility of Digital Crown accessory Views on Apple Watch.

Places an accessory View next to the Digital Crown on Apple Watch.

Tracks Digital Crown rotations by updating the specified binding.

`func digitalCrownRotation(detent:from:through:by:sensitivity:isContinuous:isHapticFeedbackEnabled:onChange:onIdle:)`

`struct DigitalCrownEvent`

An event emitted when the user rotates the Digital Crown.

`enum DigitalCrownRotationalSensitivity`

The amount of Digital Crown rotation needed to move between two integer numbers.

### Managing Touch Bar input

Sets the content that the Touch Bar displays.

Sets the Touch Bar content to be shown in the Touch Bar when applicable.

Sets principal views that have special significance to this Touch Bar.

Sets a user-visible string that identifies the view’s functionality.

Sets the behavior of the user-customized view.

`struct TouchBar`

A container for a view that you can show in the Touch Bar.

`enum TouchBarItemPresence`

Options that affect user customization of the Touch Bar.

### Responding to capture events

Used to register an action triggered by system capture events.

Used to register actions triggered by system capture events.

## See Also

### Event handling

Define interactions from taps, clicks, and swipes to fine-grained gestures.

Enable people to move or duplicate items by issuing Copy and Paste commands.

Enable people to move or duplicate items by dragging them from one location to another.

Identify and control which visible object responds to user interaction.

React to system events, like opening a URL.

---

# https://developer.apple.com/documentation/swiftui/clipboard

Collection

- SwiftUI
- Clipboard

API Collection

# Clipboard

Enable people to move or duplicate items by issuing Copy and Paste commands.

## Overview

When people issue standard Copy and Cut commands, they expect to move items to the system’s Clipboard, from which they can paste the items into another place in the same app or into another app. Your app can participate in this activity if you add view modifiers that indicate how to respond to the standard commands.

In your copy and paste modifiers, provide or accept types that conform to the `Transferable` protocol, or that inherit from the `NSItemProvider` class. When possible, prefer using transferable items.

## Topics

### Copying transferable items

Specifies a list of items to copy in response to the system’s Copy command.

Specifies an action that moves items to the Clipboard in response to the system’s Cut command.

Specifies an action that adds validated items to a view in response to the system’s Paste command.

### Copying items using item providers

Adds an action to perform in response to the system’s Copy command.

Adds an action to perform in response to the system’s Cut command.

`func onPasteCommand(of:perform:)`

Adds an action to perform in response to the system’s Paste command.

`func onPasteCommand(of:validator:perform:)`

Adds an action to perform in response to the system’s Paste command with items that you validate.

## See Also

### Event handling

Define interactions from taps, clicks, and swipes to fine-grained gestures.

Respond to input from a hardware device, like a keyboard or a Touch Bar.

Enable people to move or duplicate items by dragging them from one location to another.

Identify and control which visible object responds to user interaction.

React to system events, like opening a URL.

---

# https://developer.apple.com/documentation/swiftui/drag-and-drop

Collection

- SwiftUI
- Drag and drop

API Collection

# Drag and drop

Enable people to move or duplicate items by dragging them from one location to another.

## Overview

Drag and drop offers people a convenient way to move content from one part of your app to another, or from one app to another, using an intuitive dragging gesture. Support this feature in your app by adding view modifiers to potential source and destination views within your app’s interface.

In your modifiers, provide or accept types that conform to the `Transferable` protocol, or that inherit from the `NSItemProvider` class. When possible, prefer using transferable items.

For design guidance, see Drag and drop in the Human Interface Guidelines.

## Topics

### Essentials

Adopting drag and drop using SwiftUI

Enable drag-and-drop interactions in lists, tables and custom views.

Making a view into a drag source

Adopt draggable API to provide items for drag-and-drop operations.

### Configuring drag and drop behavior

`struct DragConfiguration`

The behavior of the drag, proposed by the dragging source.

`struct DropConfiguration`

Describes the behavior of the drop.

### Moving items

`struct DragSession`

Describes the ongoing dragging session.

`struct DropSession`

### Moving transferable items

Activates this view as the source of a drag and drop operation.

Defines the destination of a drag and drop operation that handles the dropped content with a closure that you specify.

Deprecated

### Moving items using item providers

Provides a closure that vends the drag representation to be used for a particular data element.

`func onDrop(of:isTargeted:perform:)`

Defines the destination of a drag-and-drop operation that handles the dropped content with a closure that you specify.

`func onDrop(of:delegate:)`

Defines the destination of a drag and drop operation using behavior controlled by the delegate that you provide.

`protocol DropDelegate`

An interface that you implement to interact with a drop operation in a view modified to accept drops.

`struct DropProposal`

The behavior of a drop.

`enum DropOperation`

Operation types that determine how a drag and drop session resolves when the user drops a drag item.

`struct DropInfo`

The current state of a drop.

### Describing preview formations

`struct DragDropPreviewsFormation`

On macOS, describes the way the dragged previews are visually composed. Both drag sources and drop destination can specify their desired preview formation.

### Configuring spring loading

Sets the spring loading behavior this view.

`var springLoadingBehavior: SpringLoadingBehavior`

The behavior of spring loaded interactions for the views associated with this environment.

`struct SpringLoadingBehavior`

The options for controlling the spring loading behavior of views.

## See Also

### Event handling

Define interactions from taps, clicks, and swipes to fine-grained gestures.

Respond to input from a hardware device, like a keyboard or a Touch Bar.

Enable people to move or duplicate items by issuing Copy and Paste commands.

Identify and control which visible object responds to user interaction.

React to system events, like opening a URL.

---

# https://developer.apple.com/documentation/swiftui/focus

Collection

- SwiftUI
- Focus

API Collection

# Focus

Identify and control which visible object responds to user interaction.

## Overview

Focus indicates which element in the display receives the next input. Use view modifiers to indicate which views can receive focus, to detect which view has focus, and to programmatically control focus state.

For design guidance, see Focus and selection in the Human Interface Guidelines.

## Topics

### Essentials

Focus Cookbook: Supporting and enhancing focus-driven interactions in your SwiftUI app

Create custom focusable views with key-press handlers that accelerate keyboard input and support movement, and control focus programmatically.

### Indicating that a view can receive focus

Specifies if the view is focusable.

Specifies if the view is focusable, and if so, what focus-driven interactions it supports.

`struct FocusInteractions`

Values describe different focus interactions that a view can support.

### Managing focus state

Modifies this view by binding its focus state to the given state value.

Modifies this view by binding its focus state to the given Boolean state value.

`var isFocused: Bool`

Returns whether the nearest focusable ancestor has focus.

`struct FocusState`

A property wrapper type that can read and write a value that SwiftUI updates as the placement of focus within the scene changes.

`struct FocusedValue`

A property wrapper for observing values from the focused view or one of its ancestors.

`macro Entry()`

Creates an environment values, transaction, container values, or focused values entry.

`protocol FocusedValueKey`

A protocol for identifier types used when publishing and observing focused values.

`struct FocusedBinding`

A convenience property wrapper for observing and automatically unwrapping state bindings from the focused view or one of its ancestors.

Modifies this view by binding the focus state of the search field associated with the nearest searchable modifier to the given Boolean value.

Modifies this view by binding the focus state of the search field associated with the nearest searchable modifier to the given value.

### Exposing value types to focused views

Sets the focused value for the given object type.

`func focusedValue(_:_:)`

Modifies this view by injecting a value that you provide for use by other views whose state depends on the focused view hierarchy.

Sets the focused value for the given object type at a scene-wide scope.

`func focusedSceneValue(_:_:)`

Modifies this view by injecting a value that you provide for use by other views whose state depends on the focused scene.

`struct FocusedValues`

A collection of state exported by the focused scene or view and its ancestors.

### Exposing reference types to focused views

`func focusedObject(_:)`

Creates a new view that exposes the provided object to other views whose whose state depends on the focused view hierarchy.

`func focusedSceneObject(_:)`

Creates a new view that exposes the provided object to other views whose whose state depends on the active scene.

`struct FocusedObject`

A property wrapper type for an observable object supplied by the focused view or one of its ancestors.

### Setting focus scope

Creates a focus scope that SwiftUI uses to limit default focus preferences.

Indicates that the view’s frame and cohort of focusable descendants should be used to guide focus movement.

### Controlling default focus

Indicates that the view should receive focus by default for a given namespace.

Defines a region of the window in which default focus is evaluated by assigning a value to a given focus state binding.

`struct DefaultFocusEvaluationPriority`

Prioritizations for default focus preferences when evaluating where to move focus in different circumstances.

### Resetting focus

`var resetFocus: ResetFocusAction`

An action that requests the focus system to reevaluate default focus.

`struct ResetFocusAction`

An environment value that provides the ability to reevaluate default focus.

### Configuring effects

Adds a condition that controls whether this view can display focus effects, such as a default focus ring or hover effect.

`var isFocusEffectEnabled: Bool`

A Boolean value that indicates whether the view associated with this environment allows focus effects to be displayed.

## See Also

### Event handling

Define interactions from taps, clicks, and swipes to fine-grained gestures.

Respond to input from a hardware device, like a keyboard or a Touch Bar.

Enable people to move or duplicate items by issuing Copy and Paste commands.

Enable people to move or duplicate items by dragging them from one location to another.

React to system events, like opening a URL.

---

# https://developer.apple.com/documentation/swiftui/system-events

Collection

- SwiftUI
- System events

API Collection

# System events

React to system events, like opening a URL.

## Overview

Specify view and scene modifiers to indicate how your app responds to certain system events. For example, you can use the `onOpenURL(perform:)` view modifier to define an action to take when your app receives a universal link, or use the `backgroundTask(_:action:)` scene modifier to specify an asynchronous task to carry out in response to a background task event, like the completion of a background URL session.

## Topics

### Sending and receiving user activities

Restoring your app’s state with SwiftUI

Provide app continuity for users by preserving their current activities.

Advertises a user activity type.

Registers a handler to invoke in response to a user activity that your app receives.

### Sending and receiving URLs

`var openURL: OpenURLAction`

An action that opens a URL.

`struct OpenURLAction`

Registers a handler to invoke in response to a URL that your app receives.

### Handling external events

Specifies the external events for which SwiftUI opens a new instance of the modified scene.

Specifies the external events that the view’s scene handles if the scene is already open.

### Handling background tasks

Runs the specified action when the system provides a background task.

`struct BackgroundTask`

The kinds of background tasks that your app or extension can handle.

`struct SnapshotData`

The associated data of a snapshot background task.

`struct SnapshotResponse`

Your application’s response to a snapshot background task.

### Importing and exporting transferable items

Enables importing items from services, such as Continuity Camera on macOS.

Exports items for consumption by shortcuts, quick actions, and services.

Exports read-write items for consumption by shortcuts, quick actions, and services.

### Importing and exporting using item providers

Enables importing item providers from services, such as Continuity Camera on macOS.

Exports a read-only item provider for consumption by shortcuts, quick actions, and services.

Exports a read-write item provider for consumption by shortcuts, quick actions, and services.

## See Also

### Event handling

Define interactions from taps, clicks, and swipes to fine-grained gestures.

Respond to input from a hardware device, like a keyboard or a Touch Bar.

Enable people to move or duplicate items by issuing Copy and Paste commands.

Enable people to move or duplicate items by dragging them from one location to another.

Identify and control which visible object responds to user interaction.

---

# https://developer.apple.com/documentation/swiftui/accessibility-fundamentals

Collection

- SwiftUI
- Accessibility fundamentals

API Collection

# Accessibility fundamentals

Make your SwiftUI apps accessible to everyone, including people with disabilities.

## Overview

Like all Apple UI frameworks, SwiftUI comes with built-in accessibility support. The framework introspects common elements like navigation views, lists, text fields, sliders, buttons, and so on, and provides basic accessibility labels and values by default. You don’t have to do any extra work to enable these standard accessibility features.

SwiftUI also provides tools to help you enhance the accessibility of your app. To find out what enhancements you need, try using your app with accessibility features like VoiceOver, Voice Control, and Switch Control, or get feedback from users of your app that regularly use these features. Then use the accessibility view modifiers that SwiftUI provides to improve the experience. For example, you can explicitly add accessibility labels to elements in your UI using the `accessibilityLabel(_:)` or the `accessibilityValue(_:)` view modifier.

Customize your use of accessibility modifiers for all the platforms that your app runs on. For example, you may need to adjust the accessibility elements for a companion Apple Watch app that shares a common code base with an iOS app. If you integrate AppKit or UIKit controls in SwiftUI, expose any accessibility labels and make them accessible from your `NSViewRepresentable` or `UIViewRepresentable` views, or provide custom accessibility information if the underlying accessibility labels aren’t available.

For design guidance, see Accessibility in the Human Interface Guidelines.

## Topics

### Essentials

Creating accessible views

Make your app accessible to everyone by applying accessibility modifiers to your SwiftUI views.

### Creating accessible elements

Creates a new accessibility element, or modifies the `AccessibilityChildBehavior` of the existing accessibility element.

Replaces the existing accessibility element’s children with one or more new synthetic accessibility elements.

Replaces one or more accessibility elements for this view with new accessibility elements.

`struct AccessibilityChildBehavior`

Defines the behavior for the child elements of the new parent element.

### Identifying elements

Uses the string you specify to identify the view.

### Hiding elements

Specifies whether to hide this view from system accessibility features.

### Supporting types

`struct AccessibilityTechnologies`

Accessibility technologies available to the system.

`struct AccessibilityAttachmentModifier`

A view modifier that adds accessibility properties to the view

## See Also

### Accessibility

Enhance the legibility of content in your app’s interface.

Improve access to actions that your app can undertake.

Describe interface elements to help people understand what they represent.

Enable users to navigate to specific user interface elements using rotors.

---

# https://developer.apple.com/documentation/swiftui/accessible-appearance

Collection

- SwiftUI
- Accessible appearance

API Collection

# Accessible appearance

Enhance the legibility of content in your app’s interface.

## Overview

Make content easier for people to see by making it larger, giving it greater contrast, or reducing the amount of distracting motion.

For design guidance, see Accessibility in the Accessibility section of the Human Interface Guidelines.

## Topics

### Managing color

Sets whether this view should ignore the system Smart Invert setting.

`var accessibilityInvertColors: Bool`

Whether the system preference for Invert Colors is enabled.

`var accessibilityDifferentiateWithoutColor: Bool`

Whether the system preference for Differentiate without Color is enabled.

### Enlarging content

Adds a default large content view to be shown by the large content viewer.

Adds a custom large content view to be shown by the large content viewer.

`var accessibilityLargeContentViewerEnabled: Bool`

Whether the Large Content Viewer is enabled.

### Improving legibility

`var accessibilityShowButtonShapes: Bool`

Whether the system preference for Show Button Shapes is enabled.

Deprecated

`var accessibilityReduceTransparency: Bool`

Whether the system preference for Reduce Transparency is enabled.

`var legibilityWeight: LegibilityWeight?`

The font weight to apply to text.

`enum LegibilityWeight`

The Accessibility Bold Text user setting options.

### Minimizing motion

`var accessibilityDimFlashingLights: Bool`

Whether the setting to reduce flashing or strobing lights in video content is on. This setting can also be used to determine if UI in playback controls should be shown to indicate upcoming content that includes flashing or strobing lights.

`var accessibilityPlayAnimatedImages: Bool`

Whether the setting for playing animations in an animated image is on. When this value is false, any presented image that contains animation should not play automatically.

`var accessibilityReduceMotion: Bool`

Whether the system preference for Reduce Motion is enabled.

### Using assistive access

`var accessibilityAssistiveAccessEnabled: Bool`

A Boolean value that indicates whether Assistive Access is in use.

`struct AssistiveAccess`

A scene that presents an interface appropriate for Assistive Access on iOS and iPadOS. On other platforms, this scene is unused.

## See Also

### Accessibility

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Improve access to actions that your app can undertake.

Describe interface elements to help people understand what they represent.

Enable users to navigate to specific user interface elements using rotors.

---

# https://developer.apple.com/documentation/swiftui/accessible-controls

Collection

- SwiftUI
- Accessible controls

API Collection

# Accessible controls

Improve access to actions that your app can undertake.

## Overview

Help people using assistive technologies to gain access to controls in your app.

For design guidance, see Accessibility in the Accessibility section of the Human Interface Guidelines.

## Topics

### Adding actions to views

Adds an accessibility action to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action.

Adds multiple accessibility actions to the view.

`func accessibilityAction(named:_:)`

Adds an accessibility action labeled by the contents of `label` to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action. When the action is performed, the `intent` will be invoked.

Adds an accessibility action representing `actionKind` to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action. When the action is performed, the `intent` will be invoked.

`func accessibilityAction(named:intent:)`

Adds an accessibility action labeled `name` to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action. When the action is performed, the `intent` will be invoked.

Adds an accessibility adjustable action to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action.

Adds an accessibility scroll action to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action.

Adds multiple accessibility actions to the view with a specific category. Actions allow assistive technologies, such as VoiceOver, to interact with the view by invoking the action and are grouped by their category. When multiple action modifiers with an equal category are applied to the view, the actions are combined together.

`struct AccessibilityActionKind`

The structure that defines the kinds of available accessibility actions.

`enum AccessibilityAdjustmentDirection`

A directional indicator you use when making an accessibility adjustment.

`struct AccessibilityActionCategory`

Designates an accessibility action category that is provided and named by the system.

### Offering Quick Actions to people

Adds a quick action to be shown by the system when active.

`protocol AccessibilityQuickActionStyle`

A type that describes the presentation style of an accessibility quick action.

### Making gestures accessible

`func accessibilityActivationPoint(_:)`

The activation point for an element is the location assistive technologies use to initiate gestures.

`func accessibilityActivationPoint(_:isEnabled:)`

`func accessibilityDragPoint(_:description:)`

The point an assistive technology should use to begin a drag interaction.

`func accessibilityDragPoint(_:description:isEnabled:)`

`func accessibilityDropPoint(_:description:)`

The point an assistive technology should use to end a drag interaction.

`func accessibilityDropPoint(_:description:isEnabled:)`

Explicitly set whether this accessibility element is a direct touch area. Direct touch areas passthrough touch events to the app rather than being handled through an assistive technology, such as VoiceOver. The modifier accepts an optional `AccessibilityDirectTouchOptions` option set to customize the functionality of the direct touch area.

Adds an accessibility zoom action to the view. Actions allow assistive technologies, such as VoiceOver, to interact with the view by invoking the action.

`struct AccessibilityDirectTouchOptions`

An option set that defines the functionality of a view’s direct touch area.

`struct AccessibilityZoomGestureAction`

Position and direction information of a zoom gesture that someone performs with an assistive technology like VoiceOver.

### Controlling focus

Modifies this view by binding its accessibility element’s focus state to the given boolean state value.

Modifies this view by binding its accessibility element’s focus state to the given state value.

`struct AccessibilityFocusState`

A property wrapper type that can read and write a value that SwiftUI updates as the focus of any active accessibility technology, such as VoiceOver, changes.

### Managing interactivity

Explicitly set whether this Accessibility element responds to user interaction and would thus be interacted with by technologies such as Switch Control, Voice Control or Full Keyboard Access.

## See Also

### Accessibility

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Enhance the legibility of content in your app’s interface.

Describe interface elements to help people understand what they represent.

Enable users to navigate to specific user interface elements using rotors.

---

# https://developer.apple.com/documentation/swiftui/accessible-descriptions

Collection

- SwiftUI
- Accessible descriptions

API Collection

# Accessible descriptions

Describe interface elements to help people understand what they represent.

## Overview

SwiftUI can often infer some information about your user interface elements, but you can use accessibility modifiers to provide even more information for users that need it.

For design guidance, see Accessibility in the Accessibility section of the Human Interface Guidelines.

## Topics

### Applying labels

`func accessibilityLabel(_:)`

Adds a label to the view that describes its contents.

`func accessibilityLabel(_:isEnabled:)`

`func accessibilityInputLabels(_:)`

Sets alternate input labels with which users identify a view.

`func accessibilityInputLabels(_:isEnabled:)`

Pairs an accessibility element representing a label with the element for the matching content.

`enum AccessibilityLabeledPairRole`

The role of an accessibility element in a label / content pair.

### Describing values

`func accessibilityValue(_:)`

Adds a textual description of the value that the view contains.

`func accessibilityValue(_:isEnabled:)`

### Describing content

Sets an accessibility text content type.

Sets the accessibility level of this heading.

`enum AccessibilityHeadingLevel`

The hierarchy of a heading in relation to other headings.

`struct AccessibilityTextContentType`

Textual context that assistive technologies can use to improve the presentation of spoken text.

### Describing charts

Adds a descriptor to a View that represents a chart to make the chart’s contents accessible to all users.

`protocol AXChartDescriptorRepresentable`

A type to generate an `AXChartDescriptor` object that you use to provide information about a chart and its data for an accessible experience in VoiceOver or other assistive technologies.

### Adding custom descriptions

`func accessibilityCustomContent(_:_:importance:)`

Add additional accessibility information to the view.

`struct AccessibilityCustomContentKey`

Key used to specify the identifier and label associated with an entry of additional accessibility information.

### Assigning traits to content

Adds the given traits to the view.

Removes the given traits from this view.

`struct AccessibilityTraits`

A set of accessibility traits that describe how an element behaves.

### Offering hints

`func accessibilityHint(_:)`

Communicates to the user what happens after performing the view’s action.

`func accessibilityHint(_:isEnabled:)`

### Configuring VoiceOver

Raises or lowers the pitch of spoken text.

Sets whether VoiceOver should always speak all punctuation in the text view.

Controls whether to queue pending announcements behind existing speech rather than interrupting speech in progress.

Sets whether VoiceOver should speak the contents of the text view character by character.

## See Also

### Accessibility

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Enhance the legibility of content in your app’s interface.

Improve access to actions that your app can undertake.

Enable users to navigate to specific user interface elements using rotors.

---

# https://developer.apple.com/documentation/swiftui/accessible-navigation

Collection

- SwiftUI
- Accessible navigation

API Collection

# Accessible navigation

Enable users to navigate to specific user interface elements using rotors.

## Overview

An accessibility rotor is a shortcut that enables users to quickly navigate to specific elements of the user interface, and, optionally, to specific ranges of text within those elements.

The system automatically provides rotors for many navigable elements, but you can supply additional rotors for specific purposes, or replace system rotors when they don’t automatically pick up off-screen elements, like those far down in a `LazyVStack` or a `List`.

For design guidance, see Accessibility in the Accessibility section of the Human Interface Guidelines.

## Topics

### Working with rotors

`func accessibilityRotor(_:entries:)`

Create an Accessibility Rotor with the specified user-visible label, and entries generated from the content closure.

`func accessibilityRotor(_:entries:entryID:entryLabel:)`

Create an Accessibility Rotor with the specified user-visible label and entries.

`func accessibilityRotor(_:entries:entryLabel:)`

`func accessibilityRotor(_:textRanges:)`

Create an Accessibility Rotor with the specified user-visible label and entries for each of the specified ranges. The Rotor will be attached to the current Accessibility element, and each entry will go the specified range of that element.

### Creating rotors

`protocol AccessibilityRotorContent`

Content within an accessibility rotor.

`struct AccessibilityRotorContentBuilder`

Result builder you use to generate rotor entry content.

`struct AccessibilityRotorEntry`

A struct representing an entry in an Accessibility Rotor.

### Replacing system rotors

`struct AccessibilitySystemRotor`

Designates a Rotor that replaces one of the automatic, system-provided Rotors with a developer-provided Rotor.

### Configuring rotors

Defines an explicit identifier tying an Accessibility element for this view to an entry in an Accessibility Rotor.

Links multiple accessibility elements so that the user can quickly navigate from one element to another, even when the elements are not near each other in the accessibility hierarchy.

Sets the sort priority order for this view’s accessibility element, relative to other elements at the same level.

## See Also

### Accessibility

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Enhance the legibility of content in your app’s interface.

Improve access to actions that your app can undertake.

Describe interface elements to help people understand what they represent.

---

# https://developer.apple.com/documentation/swiftui/appkit-integration

Collection

- SwiftUI
- AppKit integration

API Collection

# AppKit integration

Add AppKit views to your SwiftUI app, or use SwiftUI views in your AppKit app.

## Overview

Integrate SwiftUI with your app’s existing content using hosting controllers to add SwiftUI views into AppKit interfaces. A hosting controller wraps a set of SwiftUI views in a form that you can then add to your storyboard-based app.

You can also add AppKit views and view controllers to your SwiftUI interfaces. A representable object wraps the designated view or view controller, and facilitates communication between the wrapped object and your SwiftUI views.

For design guidance, see Designing for macOS in the Human Interface Guidelines.

## Topics

### Displaying SwiftUI views in AppKit

Unifying your app’s animations

Create a consistent UI animation experience across SwiftUI, UIKit, and AppKit.

`class NSHostingController`

An AppKit view controller that hosts SwiftUI view hierarchy.

`class NSHostingView`

An AppKit view that hosts a SwiftUI view hierarchy.

`class NSHostingMenu`

An AppKit menu with menu items that are defined by a SwiftUI View.

`struct NSHostingSizingOptions`

Options for how hosting views and controllers reflect their content’s size into Auto Layout constraints.

`class NSHostingSceneRepresentation`

An AppKit type that hosts and can present SwiftUI scenes

`struct NSHostingSceneBridgingOptions`

Options for how hosting views and controllers manage aspects of the associated window.

### Adding AppKit views to SwiftUI view hierarchies

`protocol NSViewRepresentable`

A wrapper that you use to integrate an AppKit view into your SwiftUI view hierarchy.

`struct NSViewRepresentableContext`

Contextual information about the state of the system that you use to create and update your AppKit view.

`protocol NSViewControllerRepresentable`

A wrapper that you use to integrate an AppKit view controller into your SwiftUI interface.

`struct NSViewControllerRepresentableContext`

Contextual information about the state of the system that you use to create and update your AppKit view controller.

### Adding AppKit gesture recognizers into SwiftUI view hierarchies

`protocol NSGestureRecognizerRepresentable`

A wrapper for an `NSGestureRecognizer` that you use to integrate that gesture recognizer into your SwiftUI hierarchy.

`struct NSGestureRecognizerRepresentableContext`

Contextual information about the state of the system that you use to create and update a represented gesture recognizer.

`struct NSGestureRecognizerRepresentableCoordinateSpaceConverter`

A structure used to convert locations to and from coordinate spaces in the hierarchy of the SwiftUI view associated with an `NSGestureRecognizerRepresentable`.

## See Also

### Framework integration

Add UIKit views to your SwiftUI app, or use SwiftUI views in your UIKit app.

Add WatchKit views to your SwiftUI app, or use SwiftUI views in your WatchKit app.

Use SwiftUI views that other Apple frameworks provide.

---

# https://developer.apple.com/documentation/swiftui/uikit-integration

Collection

- SwiftUI
- UIKit integration

API Collection

# UIKit integration

Add UIKit views to your SwiftUI app, or use SwiftUI views in your UIKit app.

## Overview

Integrate SwiftUI with your app’s existing content using hosting controllers to add SwiftUI views into UIKit interfaces. A hosting controller wraps a set of SwiftUI views in a form that you can then add to your storyboard-based app.

You can also add UIKit views and view controllers to your SwiftUI interfaces. A representable object wraps the designated view or view controller, and facilitates communication between the wrapped object and your SwiftUI views.

For design guidance, see the following sections in the Human Interface Guidelines:

- Designing for iOS

- Designing for iPadOS

- Designing for tvOS

## Topics

### Displaying SwiftUI views in UIKit

Using SwiftUI with UIKit

Learn how to incorporate SwiftUI views into a UIKit app.

Unifying your app’s animations

Create a consistent UI animation experience across SwiftUI, UIKit, and AppKit.

`class UIHostingController`

A UIKit view controller that manages a SwiftUI view hierarchy.

`struct UIHostingControllerSizingOptions`

Options for how a hosting controller tracks its content’s size.

`struct UIHostingConfiguration`

A content configuration suitable for hosting a hierarchy of SwiftUI views.

`protocol UIHostingSceneDelegate`

Extends `UIKit/UISceneDelegate` to bridge SwiftUI scenes.

### Adding UIKit views to SwiftUI view hierarchies

`protocol UIViewRepresentable`

A wrapper for a UIKit view that you use to integrate that view into your SwiftUI view hierarchy.

`struct UIViewRepresentableContext`

Contextual information about the state of the system that you use to create and update your UIKit view.

`protocol UIViewControllerRepresentable`

A view that represents a UIKit view controller.

`struct UIViewControllerRepresentableContext`

Contextual information about the state of the system that you use to create and update your UIKit view controller.

### Adding UIKit gesture recognizers into SwiftUI view hierarchies

`protocol UIGestureRecognizerRepresentable`

A wrapper for a `UIGestureRecognizer` that you use to integrate that gesture recognizer into your SwiftUI hierarchy.

`struct UIGestureRecognizerRepresentableContext`

Contextual information about the state of the system that you use to create and update a represented gesture recognizer.

`struct UIGestureRecognizerRepresentableCoordinateSpaceConverter`

A proxy structure used to convert locations to/from coordinate spaces in the hierarchy of the SwiftUI view associated with a `UIGestureRecognizerRepresentable`.

### Sharing configuration information

`typealias UITraitBridgedEnvironmentKey`

### Hosting an ornament in UIKit

`class UIHostingOrnament`

A model that represents an ornament suitable for being hosted in UIKit.

`class UIOrnament`

The abstract base class that represents an ornament.

## See Also

### Framework integration

Add AppKit views to your SwiftUI app, or use SwiftUI views in your AppKit app.

Add WatchKit views to your SwiftUI app, or use SwiftUI views in your WatchKit app.

Use SwiftUI views that other Apple frameworks provide.

---

# https://developer.apple.com/documentation/swiftui/watchkit-integration

Collection

- SwiftUI
- WatchKit integration

API Collection

# WatchKit integration

Add WatchKit views to your SwiftUI app, or use SwiftUI views in your WatchKit app.

## Overview

Integrate SwiftUI with your app’s existing content using hosting controllers to add SwiftUI views into WatchKit interfaces. A hosting controller wraps a set of SwiftUI views in a form that you can then add to your storyboard-based app.

You can also add WatchKit views and view controllers to your SwiftUI interfaces. A representable object wraps the designated view or view controller, and facilitates communication between the wrapped object and your SwiftUI views.

For design guidance, see Designing for watchOS in the Human Interface Guidelines.

## Topics

### Displaying SwiftUI views in WatchKit

`class WKHostingController`

A WatchKit interface controller that hosts a SwiftUI view hierarchy.

`class WKUserNotificationHostingController`

A WatchKit user notification interface controller that hosts a SwiftUI view hierarchy.

### Adding WatchKit views to SwiftUI view hierarchies

`protocol WKInterfaceObjectRepresentable`

A view that represents a WatchKit interface object.

`struct WKInterfaceObjectRepresentableContext`

Contextual information about the state of the system that you use to create and update your WatchKit interface object.

## See Also

### Framework integration

Add AppKit views to your SwiftUI app, or use SwiftUI views in your AppKit app.

Add UIKit views to your SwiftUI app, or use SwiftUI views in your UIKit app.

Use SwiftUI views that other Apple frameworks provide.

---

# https://developer.apple.com/documentation/swiftui/technology-specific-views

Collection

- SwiftUI
- Technology-specific views

API Collection

# Technology-specific views

Use SwiftUI views that other Apple frameworks provide.

## Overview

To access SwiftUI views that another framework defines, import both SwiftUI and the other framework into the file where you use the view. You can find the framework to import by looking at the availability information on the view’s documentation page.

For example, to use the `Map` view in your app, import both SwiftUI and MapKit.

import SwiftUI
import MapKit

struct MyMapView: View {
// Center the map on Joshua Tree National Park.
var region = MKCoordinateRegion(
center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
)

var body: some View {
Map(initialPosition: .region(region))
}
}

For design guidance, see Technologies in the Human Interface Guidelines.

## Topics

### Displaying web content

`struct WebView`

A view that displays some web content.

`class WebPage`

An object that controls and manages the behavior of interactive web content.

Determines whether horizontal swipe gestures trigger backward and forward page navigation.

Specifies the visibility of the webpage’s natural background color within this view.

Adds an item-based context menu to a WebView, replacing the default set of context menu items.

Determines whether a web view can display content full screen.

Determines whether pressing a link displays a preview of the destination for the link.

Determines whether magnify gestures change the view’s magnification.

Adds an action to be performed when a value, created from a scroll geometry, changes.

Enables or disables scrolling in web views when using particular inputs.

Associates a binding to a scroll position with the web view.

Determines whether to allow people to select or otherwise interact with text.

### Accessing Apple Pay and Wallet

`struct PayWithApplePayButton`

A type that provides a button to pay with Apple pay.

`struct AddPassToWalletButton`

A type that provides a button that enables people to add a new or existing pass to Apple Wallet.

`struct VerifyIdentityWithWalletButton`

A type that displays a button to present the identity verification flow.

Sets the button’s style.

Sets the style to be used by the button. (see `PKAddPassButtonStyle`).

Called when a user has entered or updated a coupon code. This is required if the user is being asked to provide a coupon code.

Called when a payment method has changed and asks for an update payment request. If this modifier isn’t provided Wallet will assume the payment method is valid.

Called when a user selected a shipping address. This is required if the user is being asked to provide a shipping contact.

Called when a user selected a shipping method. This is required if the user is being asked to provide a shipping method.

Sets the action on the PayLaterView. See `PKPayLaterAction`.

Sets the display style on the PayLaterView. See `PKPayLaterDisplayStyle`.

Sets the style to be used by the button. (see `PayWithApplePayButtonStyle`).

Sets the style to be used by the button. (see `PKIdentityButtonStyle`).

`struct AsyncShareablePassConfiguration`

Provides a task to perform before this view appears

### Authorizing and authenticating

`struct LocalAuthenticationView`

A SwiftUI view that displays an authentication interface.

`struct SignInWithAppleButton`

A SwiftUI view that creates the Sign in with Apple button for display.

Sets the style used for displaying the control (see `SignInWithAppleButton.Style`).

`var authorizationController: AuthorizationController`

A value provided in the SwiftUI environment that views can use to perform authorization requests.

`var webAuthenticationSession: WebAuthenticationSession`

A value provided in the SwiftUI environment that views can use to authenticate a user through a web service.

### Configuring Family Sharing

`struct FamilyActivityPicker`

A view in which users specify applications, web domains, and categories without revealing their choices to the app.

Presents an activity picker view as a sheet.

### Reporting on device activity

`struct DeviceActivityReport`

A view that reports the user’s application, category, and web domain activity in a privacy-preserving way.

### Working with managed devices

Applies a managed content style to the view.

Presents a modal view that enables users to add devices to their organization.

### Creating graphics

`struct Chart`

A SwiftUI view that displays a chart.

`struct SceneView`

A SwiftUI view for displaying 3D SceneKit content.

`struct SpriteView`

A SwiftUI view that renders a SpriteKit scene.

### Getting location information

`struct LocationButton`

A SwiftUI button that grants one-time location authorization.

`struct Map`

A view that displays an embedded map interface.

Specifies the map style to be used.

Creates a mapScope that SwiftUI uses to connect map controls to an associated map.

Specifies which map features should have selection disabled.

Specifies the selection accessory to display for a `MapFeature`

Specifies a custom presentation for the currently selected feature.

Configures all `Map` views in the associated environment to have standard size and position controls

Configures all Map controls in the environment to have the specified visibility

Uses the given keyframes to animate the camera of a `Map` when the given trigger value changes.

`func onMapCameraChange(frequency:_:)`

Performs an action when Map camera framing changes

Presents a map item detail popover.

Presents a map item detail sheet.

### Displaying media

`struct CameraView`

A SwiftUI view into which a video stream or an image snapshot is rendered.

`struct NowPlayingView`

A view that displays the system’s Now Playing interface so that the user can control audio.

`struct VideoPlayer`

A view that displays content from a player and a native user interface to control playback.

A `continuityDevicePicker` should be used to discover and connect nearby continuity device through a button interface or other form of activation. On tvOS, this presents a fullscreen continuity device picker experience when selected. The modal view covers as much the screen of `self` as possible when a given condition is true.

Specifies the view that should act as the virtual camera for Apple Vision Pro 2D Persona stream.

### Selecting photos

`struct PhotosPicker`

A view that displays a Photos picker for choosing assets from the photo library.

Presents a Photos picker that selects a `PhotosPickerItem`.

Presents a Photos picker that selects a `PhotosPickerItem` from a given photo library.

Presents a Photos picker that selects a collection of `PhotosPickerItem`.

Presents a Photos picker that selects a collection of `PhotosPickerItem` from a given photo library.

Sets the accessory visibility of the Photos picker. Accessories include anything between the content and the edge, like the navigation bar or the sidebar.

Disables capabilities of the Photos picker.

Sets the mode of the Photos picker.

### Previewing content

Presents a Quick Look preview of the contents of a single URL.

Presents a Quick Look preview of the URLs you provide.

### Interacting with networked devices

`struct DevicePicker`

A SwiftUI view that displays other devices on the network, and creates an encrypted connection to a copy of your app running on that device.

`var devicePickerSupports: DevicePickerSupportedAction`

Checks for support to present a DevicePicker.

### Configuring a Live Activity

The text color for the auxiliary action button that the system shows next to a Live Activity on the Lock Screen.

Sets the tint color for the background of a Live Activity that appears on the Lock Screen.

`var isActivityFullscreen: Bool`

A Boolean value that indicates whether the Live Activity appears in a full-screen presentation.

`var activityFamily: ActivityFamily`

The size family of the current Live Activity.

### Interacting with the App Store and Apple Music

Presents a StoreKit overlay when a given condition is true.

Display the refund request sheet for the given transaction.

Presents a sheet that enables customers to redeem offer codes that you configure in App Store Connect.

Initiates the process of presenting a sheet with subscription offers for Apple Music when the `isPresented` binding is `true`.

Declares the view as dependent on the entitlement of an In-App Purchase product, and returns a modified view.

Add a function to call before initiating a purchase from StoreKit view within this view, providing a set of options for the purchase.

Add an action to perform when a purchase initiated from a StoreKit view within this view completes.

Add an action to perform when a user triggers the purchase button on a StoreKit view within this view.

Adds a standard border to an in-app purchase product’s icon .

Sets the style for In-App Purchase product views within a view.

Configure the visibility of labels displaying an in-app purchase product description within the view.

Specifies the visibility of auxiliary buttons that store view and subscription store view instances may use.

Declares the view as dependent on an In-App Purchase product and returns a modified view.

Declares the view as dependent on a collection of In-App Purchase products and returns a modified view.

Declares the view as dependent on the status of an auto-renewable subscription group, and returns a modified view.

Configures subscription store view instances within a view to use the provided button label.

Sets a view to use to decorate individual subscription options within a subscription store view.

Sets the control style for subscription store views within a view.

Sets the control style and control placement for subscription store views within a view.

Sets the style subscription store views within this view use to display groups of subscription options.

Sets the background style for picker items of the subscription store view instances within a view.

Sets the background shape and style for subscription store view picker items within a view.

Configures a view as the destination for a policy button action in subscription store views.

Configures a URL as the destination for a policy button action in subscription store views.

Sets the style for the and buttons within a subscription store view.

Sets the primary and secondary style for the and buttons within a subscription store view.

Adds an action to perform when a person uses the sign-in button on a subscription store view within a view.

`func subscriptionStoreControlBackground(_:)`

Set a standard effect to use for the background of subscription store view controls within the view.

Selects a promotional offer to apply to a purchase a customer makes from a subscription store view.

Deprecated

Selects a subscription offer to apply to a purchase that a customer makes from a subscription store view, a store view, or a product view.

### Accessing health data

Asynchronously requests permission to read a data type that requires per-object authorization (such as vision prescriptions).

Requests permission to read the specified HealthKit data types.

Requests permission to save and read the specified HealthKit data types.

Presents a preview of the workout contents as a modal sheet

### Providing tips

Presents a popover tip on the modified view.

Sets the tip’s view background to a style. Currently this only applies to inline tips, not popover tips.

Sets the corner radius for an inline tip view.

Sets the size for a tip’s image.

Sets the given style for TipView within the view hierarchy.

Sets the style for a tip’s image.

### Showing a translation

Presents a translation popover when a given condition is true.

Adds a task to perform before this view appears or when the translation configuration changes.

Adds a task to perform before this view appears or when the specified source or target languages change.

### Presenting journaling suggestions

Presents a visual picker interface that contains events and images that a person can select to retrieve more information.

### Managing contact access

Modally present UI which allows the user to select which contacts your app has access to.

### Handling game controller events

Specifies the game controllers events which should be delivered through the GameController framework when the view, or one of its descendants has focus.

### Creating a tabletop game

Adds a tabletop game to a view.

Supplies a closure which returns a new interaction whenever needed.

### Configuring camera controls

`var realityViewCameraControls: CameraControls`

The camera controls for the reality view.

Adds gestures that control the position and direction of a virtual camera.

### Interacting with transactions

Presents a picker that selects a collection of transactions.

## See Also

### Framework integration

Add AppKit views to your SwiftUI app, or use SwiftUI views in your AppKit app.

Add UIKit views to your SwiftUI app, or use SwiftUI views in your UIKit app.

Add WatchKit views to your SwiftUI app, or use SwiftUI views in your WatchKit app.

---

# https://developer.apple.com/documentation/swiftui/previews-in-xcode

Collection

- SwiftUI
- Previews in Xcode

API Collection

# Previews in Xcode

Generate dynamic, interactive previews of your custom views.

## Overview

When you create a custom `View` with SwiftUI, Xcode can display a preview of the view’s content that stays up-to-date as you make changes to the view’s code. You use one of the preview macros — like `Preview(_:body:)` — to tell Xcode what to display. Xcode shows the preview in a canvas beside your code.

Different preview macros enable different kinds of configuration. For example, you can add traits that affect the preview’s appearance using the `Preview(_:traits:_:body:)` macro or add custom viewpoints for the preview using the `Preview(_:traits:body:cameras:)` macro. You can also check how your view behaves inside a specific scene type. For example, in visionOS you can use the `Preview(_:immersionStyle:traits:body:)` macro to preview your view inside an `ImmersiveSpace`.

You typically rely on preview macros to create previews in your code. However, if you can’t get the behavior you need using a preview macro, you can use the `PreviewProvider` protocol and its associated supporting types to define and configure a preview.

## Topics

### Essentials

Previewing your app’s interface in Xcode

Iterate designs quickly and preview your apps’ displays across different Apple devices.

### Creating a preview

Creates a preview of a SwiftUI view.

Creates a preview of a SwiftUI view using the specified traits.

Creates a preview of a SwiftUI view using the specified traits and custom viewpoints.

### Creating a preview in the context of a scene

Creates a preview of a SwiftUI view in an immersive space.

Creates a preview of a SwiftUI view in an immersive space with custom viewpoints.

Creates a preview of a SwiftUI view in a window.

Creates a preview of a SwiftUI view in a window with custom viewpoints.

### Defining a preview

`macro Previewable()`

Tag allowing a dynamic property to appear inline in a preview.

`protocol PreviewProvider`

A type that produces view previews in Xcode.

`enum PreviewPlatform`

Platforms that can run the preview.

Sets a user visible name to show in the canvas for a preview.

`protocol PreviewModifier`

A type that defines an environment in which previews can appear.

`struct PreviewModifierContent`

The type-erased content of a preview.

### Customizing a preview

Overrides the device for a preview.

`struct PreviewDevice`

A simulator device that runs a preview.

Overrides the size of the container for the preview.

Overrides the orientation of the preview.

`struct InterfaceOrientation`

The orientation of the interface from the user’s perspective.

### Setting a context

Declares a context for the preview.

`protocol PreviewContext`

A context type for use with a preview.

`protocol PreviewContextKey`

A key type for a preview context.

### Building in debug mode

`struct DebugReplaceableView`

Erases view opaque result types in debug builds.

## See Also

### Tool support

Expose custom views and modifiers in the Xcode library.

Measure and improve your app’s responsiveness.

---

# https://developer.apple.com/documentation/swiftui/xcode-library-customization

Collection

- SwiftUI
- Xcode library customization

# Xcode library customization

Expose custom views and modifiers in the Xcode library.

## Overview

You can add your custom SwiftUI views and view modifiers to Xcode’s library. This allows anyone developing your app or adopting your framework to access them by clicking the Library button (+) in Xcode’s toolbar. You can select and drag the custom library items into code, just like you would for system-provided items.

To add items to the library, create a structure that conforms to the `LibraryContentProvider` protocol and encapsulate any items you want to add as `LibraryItem` instances. Implement the `views` computed property to add library items containing views. Implement the `modifiers(base:)` method to add items containing view modifiers. Xcode harvests items from all of the library content providers in your project as you work, and makes them available to you in its library.

## Topics

### Creating library items

`protocol LibraryContentProvider`

A source of Xcode library and code completion content.

`struct LibraryItem`

A single item to add to the Xcode library.

## See Also

### Tool support

Generate dynamic, interactive previews of your custom views.

Measure and improve your app’s responsiveness.

---

# https://developer.apple.com/documentation/swiftui/performance-analysis

Collection

- SwiftUI
- Performance analysis

# Performance analysis

Measure and improve your app’s responsiveness.

## Overview

Use Instruments to detect hangs and hitches in your app, and to analyze long view body updates and frequently occurring SwiftUI updates that can contribute to hangs and hitches.

## Topics

### Essentials

Understanding user interface responsiveness

Make your app more responsive by examining the event-handling and rendering loop.

Understanding hangs in your app

Determine the cause for delays in user interactions by examining the main thread and the main run loop.

Understanding hitches in your app

Determine the cause of interruptions in motion by examining the render loop.

### Analyzing SwiftUI performance

Understanding and improving SwiftUI performance

Identify and address long-running view updates, and reduce the frequency of updates.

## See Also

### Tool support

Generate dynamic, interactive previews of your custom views.

Expose custom views and modifiers in the Xcode library.

---

# https://developer.apple.com/documentation/swiftui/app)



---

# https://developer.apple.com/documentation/swiftui/view)



---

# https://developer.apple.com/documentation/swiftui/landmarks-building-an-app-with-liquid-glass)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/building-a-document-based-app-with-swiftui)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/app-organization)



---

# https://developer.apple.com/documentation/swiftui/scenes)



---

# https://developer.apple.com/documentation/swiftui/windows)



---

# https://developer.apple.com/documentation/swiftui/immersive-spaces)



---

# https://developer.apple.com/documentation/swiftui/documents)



---

# https://developer.apple.com/documentation/swiftui/navigation)



---

# https://developer.apple.com/documentation/swiftui/modal-presentations)



---

# https://developer.apple.com/documentation/swiftui/toolbars)



---

# https://developer.apple.com/documentation/swiftui/search)



---

# https://developer.apple.com/documentation/swiftui/app-extensions)



---

# https://developer.apple.com/documentation/swiftui/model-data)



---

# https://developer.apple.com/documentation/swiftui/environment-values)



---

# https://developer.apple.com/documentation/swiftui/preferences)



---

# https://developer.apple.com/documentation/swiftui/persistent-storage)



---

# https://developer.apple.com/documentation/swiftui/view-fundamentals)



---

# https://developer.apple.com/documentation/swiftui/view-configuration)



---

# https://developer.apple.com/documentation/swiftui/view-styles)



---

# https://developer.apple.com/documentation/swiftui/animations)



---

# https://developer.apple.com/documentation/swiftui/text-input-and-output)



---

# https://developer.apple.com/documentation/swiftui/images)



---

# https://developer.apple.com/documentation/swiftui/controls-and-indicators)



---

# https://developer.apple.com/documentation/swiftui/menus-and-commands)



---

# https://developer.apple.com/documentation/swiftui/shapes)



---

# https://developer.apple.com/documentation/swiftui/drawing-and-graphics)



---

# https://developer.apple.com/documentation/swiftui/layout-fundamentals)



---

# https://developer.apple.com/documentation/swiftui/layout-adjustments)



---

# https://developer.apple.com/documentation/swiftui/custom-layout)



---

# https://developer.apple.com/documentation/swiftui/lists)



---

# https://developer.apple.com/documentation/swiftui/tables)



---

# https://developer.apple.com/documentation/swiftui/view-groupings)



---

# https://developer.apple.com/documentation/swiftui/scroll-views)



---

# https://developer.apple.com/documentation/swiftui/gestures)



---

# https://developer.apple.com/documentation/swiftui/input-events)



---

# https://developer.apple.com/documentation/swiftui/clipboard)



---

# https://developer.apple.com/documentation/swiftui/drag-and-drop)



---

# https://developer.apple.com/documentation/swiftui/focus)



---

# https://developer.apple.com/documentation/swiftui/system-events)



---

# https://developer.apple.com/documentation/swiftui/accessibility-fundamentals)



---

# https://developer.apple.com/documentation/swiftui/accessible-appearance)



---

# https://developer.apple.com/documentation/swiftui/accessible-controls)



---

# https://developer.apple.com/documentation/swiftui/accessible-descriptions)



---

# https://developer.apple.com/documentation/swiftui/accessible-navigation)



---

# https://developer.apple.com/documentation/swiftui/appkit-integration)



---

# https://developer.apple.com/documentation/swiftui/uikit-integration)



---

# https://developer.apple.com/documentation/swiftui/watchkit-integration)



---

# https://developer.apple.com/documentation/swiftui/technology-specific-views)



---

# https://developer.apple.com/documentation/swiftui/previews-in-xcode)



---

# https://developer.apple.com/documentation/swiftui/xcode-library-customization)



---

# https://developer.apple.com/documentation/swiftui/performance-analysis)



---

# https://developer.apple.com/documentation/swiftui

Framework

# SwiftUI

Declare the user interface and behavior for your app on every platform.

## Overview

SwiftUI provides views, controls, and layout structures for declaring your app’s user interface. The framework provides event handlers for delivering taps, gestures, and other types of input to your app, and tools to manage the flow of data from your app’s models down to the views and controls that users see and interact with.

Define your app structure using the `App` protocol, and populate it with scenes that contain the views that make up your app’s user interface. Create your own custom views that conform to the `View` protocol, and compose them with SwiftUI views for displaying text, images, and custom shapes using stacks, lists, and more. Apply powerful modifiers to built-in views and your own views to customize their rendering and interactivity. Share code between apps on multiple platforms with views and controls that adapt to their context and presentation.

You can integrate SwiftUI views with objects from the UIKit, AppKit, and WatchKit frameworks to take further advantage of platform-specific functionality. You can also customize accessibility support in SwiftUI, and localize your app’s interface for different languages, countries, or cultural regions.

### Featured samples

![An image with a background of Mount Fuji, and in the foreground screenshots of the landmark detail view for Mount Fuji in the Landmarks app, in an iPad and iPhone.\\
\\
Landmarks: Building an app with Liquid Glass \\
\\
Enhance your app experience with system-provided and custom Liquid Glass.\\
\\
](https://developer.apple.com/documentation/swiftui/landmarks-building-an-app-with-liquid-glass)

![\\
\\
Destination Video \\
\\
Leverage SwiftUI to build an immersive media experience in a multiplatform app.\\
\\
](https://developer.apple.com/documentation/visionOS/destination-video)

![\\
\\
BOT-anist \\
\\
Build a multiplatform app that uses windows, volumes, and animations to create a robot botanist’s greenhouse.\\
\\
](https://developer.apple.com/documentation/visionOS/BOT-anist)

![A screenshot displaying the document launch experience on iPad with a robot and plant accessory to the left and right of the title view, respectively.\\
\\
Building a document-based app with SwiftUI \\
\\
Create, save, and open documents in a multiplatform app.\\
\\
](https://developer.apple.com/documentation/swiftui/building-a-document-based-app-with-swiftui)

## Topics

### Essentials

Adopting Liquid Glass

Find out how to bring the new material to your app.

Learning SwiftUI

Discover tips and techniques for building multiplatform apps with this set of conceptual articles and sample code.

Exploring SwiftUI Sample Apps

Explore these SwiftUI samples using Swift Playgrounds on iPad or in Xcode to learn about defining user interfaces, responding to user interactions, and managing data flow.

SwiftUI updates

Learn about important changes to SwiftUI.

Landmarks: Building an app with Liquid Glass

Enhance your app experience with system-provided and custom Liquid Glass.

### App structure

Define the entry point and top-level structure of your app.

Declare the user interface groupings that make up the parts of your app.

Display user interface content in a window or a collection of windows.

Display unbounded content in a person’s surroundings.

Enable people to open and manage documents.

Enable people to move between different parts of your app’s view hierarchy within a scene.

Present content in a separate view that offers focused interaction.

Provide immediate access to frequently used commands and controls.

Enable people to search for text or other content within your app.

Extend your app’s basic functionality to other parts of the system, like by adding a Widget.

### Data and storage

Manage the data that your app uses to drive its interface.

Share data throughout a view hierarchy using the environment.

Indicate configuration preferences from views to their container views.

Store data for use across sessions of your app.

### Views

Define the visual elements of your app using a hierarchy of views.

Adjust the characteristics of views in a hierarchy.

Apply built-in and custom appearances and behaviors to different types of views.

Create smooth visual updates in response to state changes.

Display formatted text and get text input from the user.

Add images and symbols to your app’s user interface.

Display values and get user selections.

Provide space-efficient, context-dependent access to commands and controls.

Trace and fill built-in and custom shapes with a color, gradient, or other pattern.

Enhance your views with graphical effects and customized drawings.

### View layout

Arrange views inside built-in layout containers like stacks and grids.

Make fine adjustments to alignment, spacing, padding, and other layout parameters.

Place views in custom arrangements and create animated transitions between layout types.

Display a structured, scrollable column of information.

Display selectable, sortable data arranged in rows and columns.

Present views in different kinds of purpose-driven containers, like forms or control groups.

Enable people to scroll to content that doesn’t fit in the current display.

### Event handling

Define interactions from taps, clicks, and swipes to fine-grained gestures.

Respond to input from a hardware device, like a keyboard or a Touch Bar.

Enable people to move or duplicate items by issuing Copy and Paste commands.

Enable people to move or duplicate items by dragging them from one location to another.

Identify and control which visible object responds to user interaction.

React to system events, like opening a URL.

### Accessibility

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Enhance the legibility of content in your app’s interface.

Improve access to actions that your app can undertake.

Describe interface elements to help people understand what they represent.

Enable users to navigate to specific user interface elements using rotors.

### Framework integration

Add AppKit views to your SwiftUI app, or use SwiftUI views in your AppKit app.

Add UIKit views to your SwiftUI app, or use SwiftUI views in your UIKit app.

Add WatchKit views to your SwiftUI app, or use SwiftUI views in your WatchKit app.

Use SwiftUI views that other Apple frameworks provide.

### Tool support

Generate dynamic, interactive previews of your custom views.

Expose custom views and modifiers in the Xcode library.

Measure and improve your app’s responsiveness.

---

# https://developer.apple.com/documentation/swiftui/navigationsplitview

- SwiftUI
- NavigationSplitView

Structure

# NavigationSplitView

A view that presents views in two or three columns, where selections in leading columns control presentations in subsequent columns.

## Mentioned in

Migrating to new navigation types

Adding a search interface to your app

## Overview

You create a navigation split view with two or three columns, and typically use it as the root view in a `Scene`. People choose one or more items in a leading column to display details about those items in subsequent columns.

To create a two-column navigation split view, use the `init(sidebar:detail:)` initializer:

var body: some View {
NavigationSplitView {
List(model.employees, selection: $employeeIds) { employee in
Text(employee.name)
}
} detail: {
EmployeeDetails(for: employeeIds)
}
}

In the above example, the navigation split view coordinates with the `List` in its first column, so that when people make a selection, the detail view updates accordingly. Programmatic changes that you make to the selection property also affect both the list appearance and the presented detail view.

To create a three-column view, use the `init(sidebar:content:detail:)` initializer. The selection in the first column affects the second, and the selection in the second column affects the third. For example, you can show a list of departments, the list of employees in the selected department, and the details about all of the selected employees:

@State private var departmentId: Department.ID? // Single selection.

var body: some View {
NavigationSplitView {
List(model.departments, selection: $departmentId) { department in
Text(department.name)
}
} content: {
if let department = model.department(id: departmentId) {
List(department.employees, selection: $employeeIds) { employee in
Text(employee.name)
}
} else {
Text("Select a department")
}
} detail: {
EmployeeDetails(for: employeeIds)
}
}

You can also embed a `NavigationStack` in a column. Tapping or clicking a `NavigationLink` that appears in an earlier column sets the view that the stack displays over its root view. Activating a link in the same column adds a view to the stack. Either way, the link must present a data type for which the stack has a corresponding `navigationDestination(for:destination:)` modifier.

On watchOS and tvOS, and with narrow sizes like on iPhone or on iPad in Slide Over, the navigation split view collapses all of its columns into a stack, and shows the last column that displays useful information. For example, the three-column example above shows the list of departments to start, the employees in the department after someone selects a department, and the employee details when someone selects an employee. For rows in a list that have `NavigationLink` instances, the list draws disclosure chevrons while in the collapsed state.

### Control column visibility

You can programmatically control the visibility of navigation split view columns by creating a `State` value of type `NavigationSplitViewVisibility`. Then pass a `Binding` to that state to the appropriate initializer — such as `init(columnVisibility:sidebar:detail:)` for two columns, or the `init(columnVisibility:sidebar:content:detail:)` for three columns.

The following code updates the first example above to always hide the first column when the view appears:

@State private var columnVisibility =
NavigationSplitViewVisibility.detailOnly

var body: some View {
NavigationSplitView(columnVisibility: $columnVisibility) {
List(model.employees, selection: $employeeIds) { employee in
Text(employee.name)
}
} detail: {
EmployeeDetails(for: employeeIds)
}
}

The split view ignores the visibility control when it collapses its columns into a stack.

### Collapsed split views

At narrow size classes, such as on iPhone or Apple Watch, a navigation split view collapses into a single stack. Typically SwiftUI automatically chooses the view to show on top of this single stack, based on the content of the split view’s columns.

For custom navigation experiences, you can provide more information to help SwiftUI choose the right column. Create a `State` value of type `NavigationSplitViewColumn`. Then pass a `Binding` to that state to the appropriate initializer, such as `init(preferredCompactColumn:sidebar:detail:)` or `init(preferredCompactColumn:sidebar:content:detail:)`.

The following code shows the blue detail view when run on iPhone. When the person using the app taps the back button, they’ll see the yellow view. The value of `preferredPreferredCompactColumn` will change from `.detail` to `.sidebar`:

@State private var preferredColumn =
NavigationSplitViewColumn.detail

var body: some View {
NavigationSplitView(preferredCompactColumn: $preferredColumn) {
Color.yellow
} detail: {
Color.blue
}
}

### Customize a split view

To specify a preferred column width in a navigation split view, use the `navigationSplitViewColumnWidth(_:)` modifier. To set minimum, maximum, and ideal sizes for a column, use `navigationSplitViewColumnWidth(min:ideal:max:)`. You can specify a different modifier in each column. The navigation split view does its best to accommodate the preferences that you specify, but might make adjustments based on other constraints.

To specify how columns in a navigation split view interact, use the `navigationSplitViewStyle(_:)` modifier with a `NavigationSplitViewStyle` value. For example, you can specify whether to emphasize the detail column or to give all of the columns equal prominence.

On some platforms, `NavigationSplitView` adds a `sidebarToggle` toolbar item. Use the `toolbar(removing:)` modifier to remove the default item.

## Topics

### Creating a navigation split view

Creates a two-column navigation split view.

Creates a three-column navigation split view.

### Hiding columns in a navigation split view

Creates a two-column navigation split view that enables programmatic control of the sidebar’s visibility.

Creates a three-column navigation split view that enables programmatic control of leading columns’ visibility.

### Specifying a preferred compact column

Creates a two-column navigation split view that enables programmatic control over which column appears on top when the view collapses into a single column in narrow sizes.

Creates a three-column navigation split view that enables programmatic control over which column appears on top when the view collapses into a single column in narrow sizes.

### Specifying a preferred compact column and column visibility

Creates a two-column navigation split view that enables programmatic control of the sidebar’s visibility in regular sizes and which column appears on top when the view collapses into a single column in narrow sizes.

Creates a three-column navigation split view that enables programmatic control of leading columns’ visibility in regular sizes and which column appears on top when the view collapses into a single column in narrow sizes.

## Relationships

### Conforms To

- `View`

## See Also

### Presenting views in columns

Bringing robust navigation structure to your SwiftUI app

Use navigation links, stacks, destinations, and paths to provide a streamlined experience for all platforms, as well as behaviors such as deep linking and state restoration.

Improve navigation behavior in your app by replacing navigation views with navigation stacks and navigation split views.

Sets the style for navigation split views within this view.

Sets a fixed, preferred width for the column containing this view.

Sets a flexible, preferred width for the column containing this view.

`struct NavigationSplitViewVisibility`

The visibility of the leading columns in a navigation split view.

`struct NavigationLink`

A view that controls a navigation presentation.

---

# https://developer.apple.com/documentation/swiftui/image

- SwiftUI
- Image

Structure

# Image

A view that displays an image.

@frozen
struct Image

## Mentioned in

Building layouts with stack views

Configuring views

Creating performant scrollable stacks

Displaying data in lists

Fitting images into available space

## Overview

Use an `Image` instance when you want to add images to your SwiftUI app. You can create images from many sources:

- Image files in your app’s asset library or bundle. Supported types include PNG, JPEG, HEIC, and more.

- Instances of platform-specific image types, like `UIImage` and `NSImage`.

- A bitmap stored in a Core Graphics `CGImage` instance.

- System graphics from the SF Symbols set.

The following example shows how to load an image from the app’s asset library or bundle and scale it to fit within its container:

Image("Landscape_4")
.resizable()
.aspectRatio(contentMode: .fit)
Text("Water wheel")

You can use methods on the `Image` type as well as standard view modifiers to adjust the size of the image to fit your app’s interface. Here, the `Image` type’s `resizable(capInsets:resizingMode:)` method scales the image to fit the current view. Then, the `aspectRatio(_:contentMode:)` view modifier adjusts this resizing behavior to maintain the image’s original aspect ratio, rather than scaling the x- and y-axes independently to fill all four sides of the view. The article Fitting images into available space shows how to apply scaling, clipping, and tiling to `Image` instances of different sizes.

An `Image` is a late-binding token; the system resolves its actual value only when it’s about to use the image in an environment.

### Making images accessible

To use an image as a control, use one of the initializers that takes a `label` parameter. This allows the system’s accessibility frameworks to use the label as the name of the control for users who use features like VoiceOver. For images that are only present for aesthetic reasons, use an initializer with the `decorative` parameter; the accessibility systems ignore these images.

## Topics

### Creating an image

`init(String, bundle: Bundle?)`

Creates a labeled image that you can use as content for controls.

`init(String, variableValue: Double?, bundle: Bundle?)`

Creates a labeled image that you can use as content for controls, with a variable value.

`init(ImageResource)`

Initialize an `Image` with an image resource.

### Creating an image for use as a control

`init(String, bundle: Bundle?, label: Text)`

Creates a labeled image that you can use as content for controls, with the specified label.

`init(String, variableValue: Double?, bundle: Bundle?, label: Text)`

Creates a labeled image that you can use as content for controls, with the specified label and variable value.

`init(CGImage, scale: CGFloat, orientation: Image.Orientation, label: Text)`

Creates a labeled image based on a Core Graphics image instance, usable as content for controls.

### Creating an image for decorative use

`init(decorative: String, bundle: Bundle?)`

Creates an unlabeled, decorative image.

`init(decorative: String, variableValue: Double?, bundle: Bundle?)`

Creates an unlabeled, decorative image, with a variable value.

`init(decorative: CGImage, scale: CGFloat, orientation: Image.Orientation)`

Creates an unlabeled, decorative image based on a Core Graphics image instance.

### Creating a system symbol image

`init(systemName: String)`

Creates a system symbol image.

`init(systemName: String, variableValue: Double?)`

Creates a system symbol image with a variable value.

### Creating an image from another image

`init(uiImage: UIImage)`

Creates a SwiftUI image from a UIKit image instance.

`init(nsImage: NSImage)`

Creates a SwiftUI image from an AppKit image instance.

### Creating an image from drawing instructions

Initializes an image of the given size, with contents provided by a custom rendering closure.

### Resizing images

Sets the mode by which SwiftUI resizes an image to fit its space.

### Specifying rendering behavior

Specifies whether SwiftUI applies antialiasing when rendering the image.

Sets the rendering mode for symbol images within this view.

Indicates whether SwiftUI renders an image as-is, or by using a different mode.

Specifies the current level of quality for rendering an image that requires interpolation.

`enum TemplateRenderingMode`

A type that indicates how SwiftUI renders images.

`enum Interpolation`

The level of quality for rendering an image that requires interpolation, such as a scaled image.

### Specifying dynamic range

Returns a new image configured with the specified allowed dynamic range.

`var allowedDynamicRange: Image.DynamicRange?`

The allowed dynamic range for the view, or nil.

`struct DynamicRange`

### Instance Methods

Sets the color rendering mode of the image.

Sets the variable value mode mode for symbol images within this view.

Specifies the how to render an `Image` when using the `WidgetKit/WidgetRenderingMode/accented` mode.

### Enumerations

`enum Orientation`

The orientation of an image.

`enum ResizingMode`

The modes that SwiftUI uses to resize an image to fit within its containing view.

`enum Scale`

A scale to apply to vector images relative to text.

## Relationships

### Conforms To

- `Copyable`
- `Equatable`
- `JournalingSuggestionAsset`
- `Sendable`
- `SendableMetatype`
- `Transferable`
- `View`

---

# https://developer.apple.com/documentation/swiftui/view/backgroundextensioneffect()

#app-main)

- SwiftUI
- View
- backgroundExtensionEffect()

Instance Method

# backgroundExtensionEffect()

Adds the background extension effect to the view. The view will be duplicated into mirrored copies which will be placed around the view on any edge with available safe area. Additionally, a blur effect will be applied on top to blur out the copies.

@MainActor @preconcurrency

## Discussion

Use this modifier when you want to extend the view beyond its bounds so the copies can function as backgrounds for other elements on top. The most common use case is to apply this to a view in the detail column of a navigation split view so it can extend under the sidebar or inspector region to provide seamless immersive visuals.

NavigationSplitView {
// sidebar content
} detail: {
ZStack {
BannerView()
.backgroundExtensionEffect()
}
}
.inspector(isPresented: $showInspector) {
// inspector content
}

Apply this modifier with discretion. This should often be used with only a single instance of background content with consideration of visual clarity and performance.

---

# https://developer.apple.com/documentation/swiftui/landmarks-applying-a-background-extension-effect

- SwiftUI
- Landmarks: Building an app with Liquid Glass
- Landmarks: Applying a background extension effect

Sample Code

# Landmarks: Applying a background extension effect

Configure an image to blur and extend under a sidebar or inspector panel.

Download

Xcode 26.0+

## Overview

The Landmarks app lets people explore interesting sites around the world. Whether it’s a national park near their home or a far-flung location on a different continent, the app provides a way for people to organize and mark their adventures and receive custom activity badges along the way.

This sample demonstrates how to apply a background extension effect. In the top Landmarks view, the sample applies a background extension effect to the featured image in `LandmarksView`, and to the main image in `LandmarkDetailView`. The background extension effect blurs and extends the image under the sidebar or inspector panel when open. The following images show the main image in `LandmarkDetailView` both with and without the background extension effect.

To apply the background extension effect, the sample:

1. Aligns the view to the leading and trailing edges of the containing view.

2. Applies the `backgroundExtensionEffect()` modifier to the view.

3. Configures only the image in the background extension, and avoids applying the effect to the title and button in the overlay.

### Align the view to the leading and trailing edges

To apply the `backgroundExtensionEffect()` to a view, align the leading edge of the view next to the sidebar, and align the trailing edge of the view to the trailing edge of the containing view.

In `LandmarksView`, the `LandmarkFeaturedItemView` and the containing `LazyVStack` and `ScrollView` don’t have padding. This allows the `LandmarkFeaturedItemView` to align with the leading edge of the view next to the sidebar.

ScrollView(showsIndicators: false) {
LazyVStack(alignment: .leading, spacing: Constants.standardPadding) {
LandmarkFeaturedItemView(landmark: modelData.featuredLandmark!)
.flexibleHeaderContent()
//...
}
}

In `LandmarkDetailView`, the `ScrollView` and `VStack` that contain the main image also don’t have any padding. This allows the main image to align against the leading edge of the containing view.

### Apply the background extension effect to the image

In `LandmarkDetailView`, the sample applies the background extension effect to the main image by adding the `backgroundExtensionEffect()` modifier:

Image(landmark.backgroundImageName)
//...
.backgroundExtensionEffect()

When the sidebar is open, the system extends the image in the leading direction as follows:

- The system takes a section of the leading end of the image that matches the width of the sidebar.

- The system flips that portion of the image horizontally toward the leading edge and applies a blur to the flipped section.

- The system places the modified section of the image under the sidebar, immediately before the leading edge of the image.

When the inspector is open, the system extends the image in the trailing direction as follows:

- The system takes a section of the trailing end of the image that matches the width of the sidebar.

- The system flips that portion of the image horizontally toward the trailing edge and applies a blur to the flipped section.

- The system places the modified section of the image under the inspector, immediately after the trailing edge of the image.

### Configure only the image

In `LandmarksView`, the `LandmarkFeaturedItemView` has an image from the featured landmark, and includes a title for the landmark and a button you can click or tap to learn more about that location.

To avoid having the landmark’s title and button appear under the sidebar in macOS, the sample applies the `backgroundExtensionEffect()` modifier to the image before adding the overlay that includes the title and button:

Image(decorative: landmark.backgroundImageName)
//...
.backgroundExtensionEffect()
.overlay(alignment: .bottom) {
VStack {
Text("Featured Landmark", comment: "Big headline in the main image of featured landmarks.")
//...
Text(landmark.name)
//...
Button("Learn More") {
modelData.path.append(landmark)
}
//...
}
.padding([.bottom], Constants.learnMoreBottomPadding)
}

## See Also

### App features

Landmarks: Extending horizontal scrolling under a sidebar or inspector

Improve your horizontal scrollbar’s appearance by extending it under a sidebar or inspector.

Landmarks: Refining the system provided Liquid Glass effect in toolbars

Organize toolbars into related groupings to improve their appearance and utility.

Landmarks: Displaying custom activity badges

Provide people with a way to mark their adventures by displaying animated custom activity badges.

---

# https://developer.apple.com/documentation/swiftui/landmarks-extending-horizontal-scrolling-under-a-sidebar-or-inspector

- SwiftUI
- Landmarks: Building an app with Liquid Glass
- Landmarks: Extending horizontal scrolling under a sidebar or inspector

Sample Code

# Landmarks: Extending horizontal scrolling under a sidebar or inspector

Improve your horizontal scrollbar’s appearance by extending it under a sidebar or inspector.

Download

Xcode 26.0+

## Overview

The Landmarks app lets people explore interesting sites around the world. Whether it’s a national park near their home or a far-flung location on a different continent, the app provides a way for people to organize and mark their adventures and receive custom activity badges along the way.

This sample demonstrates how to extend horizontal scrolling under a sidebar or inspector. Within each continent section in `LandmarksView`, an instance of `LandmarkHorizontalListView` shows a horizontally scrolling list of landmark views. When open, the landmark views can scroll underneath the sidebar or inspector.

## Configure the scroll view

To achieve this effect, the sample configures the `LandmarkHorizontalListView` so it touches the leading and trailing edges. When a scroll view touches the sidebar or inspector, the system automatically adjusts it to scroll under the sidebar or inspector and then off the edge of the screen.

The sample adds a `Spacer` at the beginning of the `ScrollView` to inset the content so it aligns with the title padding:

ScrollView(.horizontal, showsIndicators: false) {
LazyHStack(spacing: Constants.standardPadding) {
Spacer()
.frame(width: Constants.standardPadding)
ForEach(landmarkList) { landmark in
//...
}
}
}

## See Also

### App features

Landmarks: Applying a background extension effect

Configure an image to blur and extend under a sidebar or inspector panel.

Landmarks: Refining the system provided Liquid Glass effect in toolbars

Organize toolbars into related groupings to improve their appearance and utility.

Landmarks: Displaying custom activity badges

Provide people with a way to mark their adventures by displaying animated custom activity badges.

---

# https://developer.apple.com/documentation/swiftui/landmarks-refining-the-system-provided-glass-effect-in-toolbars

- SwiftUI
- Landmarks: Building an app with Liquid Glass
- Landmarks: Refining the system provided Liquid Glass effect in toolbars

Sample Code

# Landmarks: Refining the system provided Liquid Glass effect in toolbars

Organize toolbars into related groupings to improve their appearance and utility.

Download

Xcode 26.0+

## Overview

The Landmarks app lets people explore interesting sites around the world. Whether it’s a national park near their home or a far-flung location on a different continent, the app provides a way for people to organize and mark their adventures and receive custom activity badges along the way.

This sample demonstrates how to refine the system provided glass effect in toolbars. In `LandmarkDetailView`, the sample adds toolbar items for:

- sharing a landmark

- adding or removing a landmark from a list of Favorites

- adding or removing a landmark from Collections

- showing or hiding the inspector

The system applies Liquid Glass to the toolbar items automatically.

## Organize the toolbar items into logical groupings

To organize the toolbar items into logical groupings, the sample adds `ToolbarSpacer` items and passes `fixed` as the `sizing` parameter to divide the toolbar into sections:

.toolbar {
ToolbarSpacer(.flexible)

ToolbarItem {
ShareLink(item: landmark, preview: landmark.sharePreview)
}

ToolbarSpacer(.fixed)

ToolbarItemGroup {
LandmarkFavoriteButton(landmark: landmark)
LandmarkCollectionsMenu(landmark: landmark)
}

ToolbarItem {
Button("Info", systemImage: "info") {
modelData.selectedLandmark = landmark
modelData.isLandmarkInspectorPresented.toggle()
}
}
}

## See Also

### App features

Landmarks: Applying a background extension effect

Configure an image to blur and extend under a sidebar or inspector panel.

Landmarks: Extending horizontal scrolling under a sidebar or inspector

Improve your horizontal scrollbar’s appearance by extending it under a sidebar or inspector.

Landmarks: Displaying custom activity badges

Provide people with a way to mark their adventures by displaying animated custom activity badges.

---

# https://developer.apple.com/documentation/swiftui/view/glasseffect(_:in:)

#app-main)

- SwiftUI
- View
- glassEffect(\_:in:)

Instance Method

# glassEffect(\_:in:)

Applies the Liquid Glass effect to a view.

nonisolated
func glassEffect(
_ glass: Glass = .regular,
in shape: some Shape = DefaultGlassEffectShape()

## Mentioned in

Applying Liquid Glass to custom views

## Discussion

When you use this effect, the system:

- Renders a shape anchored behind a view with the Liquid Glass material.

- Applies the foreground effects of Liquid Glass over a view.

For example, to add this effect to a `Text`:

Text("Hello, World!")
.font(.title)
.padding()
.glassEffect()

SwiftUI uses the `regular` variant by default along with a `Capsule` shape.

SwiftUI anchors the Liquid Glass to a view’s bounds. For the example above, the material fills the entirety of the `Text` frame, which includes the padding.

You typically use this modifier with a `GlassEffectContainer` to combine multiple Liquid Glass shapes into a single shape that can morph into one another.

## See Also

### Styling views with Liquid Glass

Configure, combine, and morph views using Liquid Glass effects.

Landmarks: Building an app with Liquid Glass

Enhance your app experience with system-provided and custom Liquid Glass.

Returns a copy of the structure configured to be interactive.

`struct GlassEffectContainer`

A view that combines multiple Liquid Glass shapes into a single shape that can morph individual shapes into one another.

`struct GlassEffectTransition`

A structure that describes changes to apply when a glass effect is added or removed from the view hierarchy.

`struct GlassButtonStyle`

A button style that applies glass border artwork based on the button’s context.

`struct GlassProminentButtonStyle`

A button style that applies prominent glass border artwork based on the button’s context.

`struct DefaultGlassEffectShape`

The default shape applied by glass effects, a capsule.

---

# https://developer.apple.com/documentation/swiftui/glasseffectcontainer

- SwiftUI
- GlassEffectContainer

Structure

# GlassEffectContainer

A view that combines multiple Liquid Glass shapes into a single shape that can morph individual shapes into one another.

@MainActor @preconcurrency

## Mentioned in

Applying Liquid Glass to custom views

## Overview

Use a container with the `glassEffect(_:in:)` modifier. Each view with a Liquid Glass effect contributes a shape rendered with the effect to a set of shapes. SwiftUI renders the effects together, improving rendering performance and allowing the effects to interact with and morph into one another.

Configure how shapes interact with one another by customizing the default spacing value of the container. As shapes near one another, their paths start to blend into one another. The higher the spacing, the sooner blending begins as the shapes approach each other.

## Topics

### Initializers

Creates a glass effect container with the provided spacing, extracting glass shapes from the provided content.

## Relationships

### Conforms To

- `Sendable`
- `SendableMetatype`
- `View`

## See Also

### Styling views with Liquid Glass

Configure, combine, and morph views using Liquid Glass effects.

Landmarks: Building an app with Liquid Glass

Enhance your app experience with system-provided and custom Liquid Glass.

Applies the Liquid Glass effect to a view.

Returns a copy of the structure configured to be interactive.

`struct GlassEffectTransition`

A structure that describes changes to apply when a glass effect is added or removed from the view hierarchy.

`struct GlassButtonStyle`

A button style that applies glass border artwork based on the button’s context.

`struct GlassProminentButtonStyle`

A button style that applies prominent glass border artwork based on the button’s context.

`struct DefaultGlassEffectShape`

The default shape applied by glass effects, a capsule.

---

# https://developer.apple.com/documentation/swiftui/view/glasseffectid(_:in:)

#app-main)

- SwiftUI
- View
- glassEffectID(\_:in:)

Instance Method

# glassEffectID(\_:in:)

Associates an identity value to Liquid Glass effects defined within this view.

nonisolated
func glassEffectID(
_ id: (some Hashable & Sendable)?,
in namespace: Namespace.ID

## Mentioned in

Applying Liquid Glass to custom views

## Discussion

You use this modifier with the `glassEffect(_:in:)` view modifier and a `GlassEffectContainer` view. When used together, SwiftUI uses the identifier to animate shapes to and from each other during transitions.

---

# https://developer.apple.com/documentation/swiftui/landmarks-displaying-custom-activity-badges

- SwiftUI
- Landmarks: Building an app with Liquid Glass
- Landmarks: Displaying custom activity badges

Sample Code

# Landmarks: Displaying custom activity badges

Provide people with a way to mark their adventures by displaying animated custom activity badges.

Download

Xcode 26.0+

## Overview

The Landmarks app lets people track their adventures as they explore sites around the world. Whether it’s a national park near their home or a far-flung location on a different continent, the app provides a way for people to mark their adventures and receive custom activity badges along the way.

This sample displays the badges in a vertical view that includes a toggle button for showing or hiding the badges. The Landmarks app includes a custom modifier that makes it easier for other views to adopt the badge view. By configuring the badges to use Liquid Glass, the badges gain the advantage of using the morphing animation when you show or hide the badges.

## Add a modifier to show badges in other views

To make the badges available in other views, like `CollectionsView`, the sample uses a custom modifier, `ShowBadgesViewModifier`, as a `ViewModifier`. The sample layers the badges over another view using a `ZStack`, and positions the badge view in the lower trailing corner:

private struct ShowsBadgesViewModifier: ViewModifier {

ZStack {
content
HStack {
Spacer()
VStack {
Spacer()
BadgesView()
.padding()
}
}
}
}
}

The sample extends `View` by adding the `showBadges` modifier:

extension View {

modifier(ShowsBadgesViewModifier())
}
}

## Apply Liquid Glass to the toggle button

To create the toggle button, the sample configures a `Button` using `ToggleBadgesLabel` which has different system images for the Show and Hide toggle states. To apply Liquid Glass, style the button with the `glass` modifier:

Button {
//...
} label: {
//...
}
.buttonStyle(.glass)

## Add Liquid Glass to the badges

To add Liquid Glass to each badge, the sample uses the `glassEffect(_:in:)` modifier. To make a custom glass view appearance, the sample specifies a rectangular option with a corner radius:

BadgeLabel(badge: $0)
.glassEffect(.regular, in: .rect(cornerRadius: Constants.badgeCornerRadius))

## Animate the badges using the morph effect

The morph effect is an animation for Liquid Glass views. During this animation, the toggle button and each badge start as a combined view. Then, the button and badges change shape like a liquid as they separate and move from one location to another. In reverse, the toggle button and badges change shape and combine back into one view.

To achieve the Liquid Glass morph effect, the app:

- organizes the badges and toggle button into a `GlassEffectContainer`

- adds `glassEffectID(_:in:)` to each badge

- adds `glassEffectID(_:in:)` to the toggle button

- wraps the command that toggles the `isExpanded` property in `withAnimation(_:_:)`

// Organizes the badges and toggle button to animate together.
GlassEffectContainer(spacing: Constants.badgeGlassSpacing) {
VStack(alignment: .center, spacing: Constants.badgeButtonTopSpacing) {
if isExpanded {
VStack(spacing: Constants.badgeSpacing) {
ForEach(modelData.earnedBadges) {
BadgeLabel(badge: $0)
// Adds Liquid Glass to the badge.
.glassEffect(.regular, in: .rect(cornerRadius: Constants.badgeCornerRadius))
// Adds an identifier to the badge for animation.
.glassEffectID($0.id, in: namespace)
}
}
}

Button {
// Animates this button and badges when `isExpanded` changes values.
withAnimation {
isExpanded.toggle()
}
} label: {
ToggleBadgesLabel(isExpanded: isExpanded)
.frame(width: Constants.badgeShowHideButtonWidth,
height: Constants.badgeShowHideButtonHeight)
}
// Adds Liquid Glass to the button.
.buttonStyle(.glass)
#if os(macOS)
.tint(.clear)
#endif
// Adds an identifier to the button for animation.
.glassEffectID("togglebutton", in: namespace)
}
.frame(width: Constants.badgeFrameWidth)
}

## See Also

### App features

Landmarks: Applying a background extension effect

Configure an image to blur and extend under a sidebar or inspector panel.

Landmarks: Extending horizontal scrolling under a sidebar or inspector

Improve your horizontal scrollbar’s appearance by extending it under a sidebar or inspector.

Landmarks: Refining the system provided Liquid Glass effect in toolbars

Organize toolbars into related groupings to improve their appearance and utility.

---

# https://developer.apple.com/documentation/swiftui/applying-liquid-glass-to-custom-views

- SwiftUI
- View styles
- Applying Liquid Glass to custom views

Article

# Applying Liquid Glass to custom views

Configure, combine, and morph views using Liquid Glass effects.

## Overview

Interfaces across Apple platforms feature a new dynamic material called Liquid Glass, which combines the optical properties of glass with a sense of fluidity. Liquid Glass is a material that blurs content behind it, reflects color and light of surrounding content, and reacts to touch and pointer interactions in real time. Standard components in SwiftUI use Liquid Glass. Adopt Liquid Glass on custom components to move, combine, and morph them into one another with unique animations and transitions.

To learn about Liquid Glass and more, see Landmarks: Building an app with Liquid Glass.

## Apply and configure Liquid Glass effects

Use the `glassEffect(_:in:)` modifier to add Liquid Glass effects to a view. By default, the modifier uses the `regular` variant of `Glass` and applies the given effect within a `Capsule` shape behind the view’s content.

Configure the effect to customize your components in a variety of ways:

- Use different shapes to have a consistent look and feel across custom components in your app. For example, use a rounded rectangle if you’re applying the effect to larger components that would look odd as a `Capsule` or `Circle`.

- Assign a tint color to suggest prominence.

- Add `interactive(_:)` to custom components to make them react to touch and pointer interactions. This applies the same responsive and fluid reactions that `glass` provides to standard buttons.

In the examples below, observe how to apply Liquid Glass effects to a view, use an alternate shape with a specific corner radius, and create a tinted view that responds to interactivity:

Video with custom controls.

Content description: A video showing examples including a Text view with Liquid Glass effects applied, a Text view with a custom shape, corner radius effect, and Liquid Glass effects applied, and a Text view with an orange tint color effect that responds to interactivity, with Liquid Glass effects applied.

Play

Text("Hello, World!")
.font(.title)
.padding()
.glassEffect()

Text("Hello, World!")
.font(.title)
.padding()
.glassEffect(in: .rect(cornerRadius: 16.0))

Text("Hello, World!")
.font(.title)
.padding()
.glassEffect(.regular.tint(.orange).interactive())

## Combine multiple views with Liquid Glass containers

Use `GlassEffectContainer` when applying Liquid Glass effects on multiple views to achieve the best rendering performance. A container also allows views with Liquid Glass effects to blend their shapes together and to morph in and out of each other during transitions. Inside a container, each view with the `glassEffect(_:in:)` modifier renders with the effects behind it.

Customize the spacing on the container to control how the Liquid Glass effects behind views interact with one another. The larger the spacing value on the container, the sooner the Liquid Glass effects behind views blend together and merge the shapes during a transition. A spacing value on the container that’s larger than the spacing of an interior `HStack`, `VStack`, or other layout container causes Liquid Glass effects to blend together at rest because the views are too close to each other. Animating views in or out causes the shapes to morph apart or together as the space in the container changes.

The `glassEffect(_:in:)` modifier captures the content to send to the container to render. Apply the `glassEffect(_:in:)` modifier after other modifiers that affect the appearance of the view.

In the example below, two images are placed close to each other and the Liquid Glass effects begin to blend their shapes together. This creates a fluid animation as components move around each other within a container:

GlassEffectContainer(spacing: 40.0) {
HStack(spacing: 40.0) {
Image(systemName: "scribble.variable")
.frame(width: 80.0, height: 80.0)
.font(.system(size: 36))
.glassEffect()

Image(systemName: "eraser.fill")
.frame(width: 80.0, height: 80.0)
.font(.system(size: 36))
.glassEffect()

// An `offset` shows how Liquid Glass effects react to each other in a container.
// Use animations and components appearing and disappearing to obtain effects that look purposeful.
.offset(x: -40.0, y: 0.0)
}
}

In some cases, you want the geometries of multiple views to contribute to a single Liquid Glass effect capsule, even when your content is at rest. Use the `glassEffectUnion(id:namespace:)` modifier to specify that a view contributes to a unified effect with a particular ID. This combines all effects with a similar shape, Liquid Glass effect, and ID into a single shape with the applied Liquid Glass material. This is especially useful when creating views dynamically, or with views that live outside of a layout container, like an `HStack` or `VStack`.

let symbolSet: [String] = ["cloud.bolt.rain.fill", "sun.rain.fill", "moon.stars.fill", "moon.fill"]

GlassEffectContainer(spacing: 20.0) {
HStack(spacing: 20.0) {
ForEach(symbolSet.indices, id: \.self) { item in
Image(systemName: symbolSet[item])
.frame(width: 80.0, height: 80.0)
.font(.system(size: 36))
.glassEffect()
.glassEffectUnion(id: item < 2 ? "1" : "2", namespace: namespace)
}
}
}

## Morph Liquid Glass effects during transitions

Morphing effects occur during transitions or animations between views with Liquid Glass effects. Coordinate transitions between views with effects in a container by using the `glassEffectID(_:in:)` modifier. `GlassEffectTransition` allows you to specify the type of transition to use when you want to add or remove effects within a container. For effects you want to add or remove that are positioned within the container’s assigned spacing, the default transition type is `matchedGeometry`.

If you prefer to have a simpler transition or to create a custom transition, use the `materialize` transition and `withAnimation(_:_:)`. Use the `materialize` transition for effects you want to add or remove that are farther from each other than the container’s assigned spacing. To provide people with a consistent experience, use `matchedGeometry` and `materialize` transitions across your apps. The system applies more than opacity changes with the available transition types.

Associate each Liquid Glass effect with a unique identifier within a namespace that the `Namespace` property wrapper provides. These IDs ensure SwiftUI animates the same shapes correctly when a shape appears or disappears due to view hierarchy changes. SwiftUI uses the spacing provided to the effect container along with the geometry of the shapes themselves to determine when and which appropriate shapes to morph into and out of.

The `glassEffectID(_:in:)` and `glassEffectTransition(_:)` modifiers only affect their content during view hierarchy transitions or animations.

In the example below, the eraser image transitions into and out of the pencil image when the `isExpanded` variable changes. The `GlassEffectContainer` has a spacing value of `40.0`, and the `HStack` within it has a spacing of `40.0`. This morphs the eraser image into the pencil image when the eraser’s nearest edge is less than or equal to the container’s spacing.

Content description: A video which shows two views, a scribble symbol on the left and a eraser symbol on the right, with Liquid Glass effects morphing in and out of each other as a button below them is pressed.

@State private var isExpanded: Bool = false
@Namespace private var namespace

var body: some View {
GlassEffectContainer(spacing: 40.0) {
HStack(spacing: 40.0) {
Image(systemName: "scribble.variable")
.frame(width: 80.0, height: 80.0)
.font(.system(size: 36))
.glassEffect()
.glassEffectID("pencil", in: namespace)

if isExpanded {
Image(systemName: "eraser.fill")
.frame(width: 80.0, height: 80.0)
.font(.system(size: 36))
.glassEffect()
.glassEffectID("eraser", in: namespace)
}
}
}

Button("Toggle") {
withAnimation {
isExpanded.toggle()
}
}
.buttonStyle(.glass)
}

## Optimize performance when using Liquid Glass effects

Creating too many Liquid Glass effect containers and applying too many effects to views outside of containers can degrade performance. Limit the use of Liquid Glass effects onscreen at the same time. Additionally, optimize how your app spends rendering time as people use it. To learn how to improve the performance of your UI, see Explore UI animation hitches and the render loop and Optimize SwiftUI performance with Instruments.

## See Also

### Styling views with Liquid Glass

Landmarks: Building an app with Liquid Glass

Enhance your app experience with system-provided and custom Liquid Glass.

Applies the Liquid Glass effect to a view.

Returns a copy of the structure configured to be interactive.

`struct GlassEffectContainer`

A view that combines multiple Liquid Glass shapes into a single shape that can morph individual shapes into one another.

`struct GlassEffectTransition`

A structure that describes changes to apply when a glass effect is added or removed from the view hierarchy.

`struct GlassButtonStyle`

A button style that applies glass border artwork based on the button’s context.

`struct GlassProminentButtonStyle`

A button style that applies prominent glass border artwork based on the button’s context.

`struct DefaultGlassEffectShape`

The default shape applied by glass effects, a capsule.

---

# https://developer.apple.com/documentation/swiftui/navigationsplitview)



---

# https://developer.apple.com/documentation/swiftui/image)



---

# https://developer.apple.com/documentation/swiftui/view/backgroundextensioneffect())



---

# https://developer.apple.com/documentation/swiftui/landmarks-applying-a-background-extension-effect).

.#app-main)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/landmarks-extending-horizontal-scrolling-under-a-sidebar-or-inspector).

.#app-main)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/landmarks-refining-the-system-provided-glass-effect-in-toolbars).

.#app-main)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/view/glasseffect(_:in:))



---

# https://developer.apple.com/documentation/swiftui/glasseffectcontainer),



---

# https://developer.apple.com/documentation/swiftui/view/glasseffectid(_:in:)).



---

# https://developer.apple.com/documentation/swiftui/landmarks-displaying-custom-activity-badges).

.#app-main)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/applying-liquid-glass-to-custom-views).

.#app-main)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/landmarks-applying-a-background-extension-effect)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/landmarks-extending-horizontal-scrolling-under-a-sidebar-or-inspector)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/landmarks-refining-the-system-provided-glass-effect-in-toolbars)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/landmarks-displaying-custom-activity-badges)

# The page you're looking for can't be found.

Search developer.apple.comSearch Icon

---

# https://developer.apple.com/documentation/swiftui/declaring-a-custom-view

- SwiftUI
- View fundamentals
- Declaring a custom view

Article

# Declaring a custom view

Define views and assemble them into a view hierarchy.

## Overview

SwiftUI offers a declarative approach to user interface design. With a traditional imperative approach, the burden is on your controller code not only to instantiate, lay out, and configure views, but also to continually make updates as conditions change. In contrast, with a declarative approach, you create a lightweight description of your user interface by declaring views in a hierarchy that mirrors the desired layout of your interface. SwiftUI then manages drawing and updating these views in response to events like user input or state changes.

SwiftUI provides tools for defining and configuring the views in your user interface. You compose custom views out of built-in views that SwiftUI provides, plus other composite views that you’ve already defined. You configure these views with view modifiers and connect them to your data model. You then place your custom views within your app’s view hierarchy.

### Conform to the view protocol

Declare a custom view type by defining a structure that conforms to the `View` protocol:

struct MyView: View {
}

Like other Swift protocols, the `View` protocol provides a blueprint for functionality — in this case, the behavior of an element that SwiftUI draws onscreen. Conformance to the protocol comes with both requirements that a view must fulfill, and functionality that the protocol provides. After you fulfill the requirements, you can insert your custom view into a view hierarchy so that it becomes part of your app’s user interface.

### Declare a body

The `View` protocol’s main requirement is that conforming types must define a `body` computed property:

struct MyView: View {
var body: some View {
}
}

SwiftUI reads the value of this property any time it needs to update the view, which can happen repeatedly during the life of the view, typically in response to user input or system events. The value that the view returns is an element that SwiftUI draws onscreen.

The `View` protocol’s secondary requirement is that conforming types must indicate an associated type for the body property. However, you don’t make an explicit declaration. Instead, you declare the body property as an opaque type, using the `some View` syntax, to indicate only that the body’s type conforms to `View`. The exact type depends on the body’s content, which varies as you edit the body during development. Swift infers the exact type automatically.

### Assemble the view’s content

Describe your view’s appearance by adding content to the view’s body property. You can compose the body from built-in views that SwiftUI provides, as well as custom views that you’ve defined elsewhere. For example, you can create a body that draws the string “Hello, World!” using a built-in `Text` view:

struct MyView: View {
var body: some View {
Text("Hello, World!")
}
}

In addition to views for specific kinds of content, controls, and indicators, like `Text`, `Toggle`, and `ProgressView`, SwiftUI also provides built-in views that you can use to arrange other views. For example, you can vertically stack two `Text` views using a `VStack`:

struct MyView: View {
var body: some View {
VStack {
Text("Hello, World!")
Text("Glad to meet you.")
}
}
}

Views that take multiple input child views, like the stack in the example above, typically do so using a closure marked with the `ViewBuilder` attribute. This enables a multiple-statement closure that doesn’t require additional syntax at the call site. You only need to list the input views in succession.

For examples of views that contain other views, see Layout fundamentals.

### Configure views with modifiers

To configure the views in your view’s body, you apply view modifiers. A modifier is nothing more than a method called on a particular view. The method returns a new, altered view that effectively takes the place of the original in the view hierarchy.

SwiftUI extends the `View` protocol with a large set of methods for this purpose. All `View` protocol conformers — both built-in and custom views — have access to these methods that alter the behavior of a view in some way. For example, you can change the font of a text view by applying the `font(_:)` modifier:

struct MyView: View {
var body: some View {
VStack {
Text("Hello, World!")
.font(.title)
Text("Glad to meet you.")
}
}
}

For more information about how view modifiers work, and how to use them on your views, see Configuring views.

### Manage data

To supply inputs to your views, add properties. For example, you can make the font of the “Hello, World!” string configurable:

struct MyView: View {
let helloFont: Font

var body: some View {
VStack {
Text("Hello, World!")
.font(helloFont)
Text("Glad to meet you.")
}
}
}

If an input value changes, SwiftUI notices the change and redraws only the affected parts of your interface. This might involve reinitializing your entire view, but SwiftUI manages that for you.

Because the system may reinitialize a view at any time, it’s important to avoid doing any significant work in your view’s initialization code. It’s often best to omit an explicit initializer, as in the example above, allowing Swift to synthesize a _member-wise initializer_ instead.

SwiftUI provides many tools to help you manage your app’s data under these constraints, as described in Model data. For information about Swift initializers, see Initialization in _The Swift Programming Language_.

### Add your view to the view hierarchy

After you define a view, you can incorporate it in other views, just like you do with built-in views. You add your view by declaring it at the point in the hierarchy at which you want it to appear. For example, you could put `MyView` in your app’s `ContentView`, which Xcode creates automatically as the root view of a new app:

struct ContentView: View {
var body: some View {
MyView(helloFont: .title)
}
}

Alternatively, you could add your view as the root view of a new scene in your app, like the `Settings` scene that declares content for a macOS preferences window, or a `WKNotificationScene` scene that declares the content for a watchOS notification. For more information about defining your app structure with SwiftUI, see App organization.

## See Also

### Creating a view

`protocol View`

A type that represents part of your app’s user interface and provides modifiers that you use to configure views.

`struct ViewBuilder`

A custom parameter attribute that constructs views from closures.

---

# https://developer.apple.com/documentation/swiftui/configuring-views

- SwiftUI
- View fundamentals
- Configuring views

Article

# Configuring views

Adjust the characteristics of a view by applying view modifiers.

## Overview

In SwiftUI, you assemble views into a hierarchy that describes your app’s user interface. To help you customize the appearance and behavior of your app’s views, you use _view modifiers_. For example, you can use modifiers to:

- Add accessibility features to a view.

- Adjust a view’s styling, layout, and other appearance characteristics.

- Respond to events, like copy and paste.

- Conditionally present modal views, like popovers.

- Configure supporting views, like toolbars.

Because view modifiers are Swift methods with behavior provided by the `View` protocol, you can apply them to any type that conforms to the `View` protocol. That includes built-in views like `Text`, `Image`, and `Button`, as well as views that you define.

### Configure a view with a modifier

Like other Swift methods, a modifier operates on an instance — a view of some kind in this case — and can optionally take input parameters. For example, you can apply the `foregroundColor(_:)` modifier to set the color of a `Text` view:

Text("Hello, World!")
.foregroundColor(.red) // Display red text.

Modifiers return a view that wraps the original view and replaces it in the view hierarchy. You can think of the two lines in the example above as resolving to a single view that displays red text.

While the code above follows the rules of Swift, the code’s structure might be unfamiliar for developers new to SwiftUI. SwiftUI uses a declarative approach, where you declare and configure a view at the point in your code that corresponds to the view’s position in the view hierarchy. For more information, see Declaring a custom view.

### Chain modifiers to achieve complex effects

You commonly chain modifiers, each wrapping the result of the previous one, by calling them one after the other. For example, you can wrap a text view in an invisible box with a given width using the `frame(width:height:alignment:)` modifier to influence its layout, and then use the `border(_:width:)` modifier to draw an outline around that:

Text("Title")
.frame(width: 100)
.border(Color.gray)

The order in which you apply modifiers matters. For example, the border that results from the code above outlines the full width of the frame.

By specifying the frame modifier after the border modifier, SwiftUI applies the border only to the text view, which never takes more space than it needs to render its contents.

Text("Title")
.border(Color.gray) // Apply the border first this time.
.frame(width: 100)

Wrapping that view in an invisible one with a fixed 100 point width affects the layout of the composite view, but has no effect on the border.

### Configure child views

You can apply any view modifier defined by the `View` protocol to any concrete view, even when the modifier doesn’t have an immediate effect on its target view. The effects of a modifier propagate to child views that don’t explicitly override the modifier.

For example, a `VStack` instance on its own acts only to vertically stack other views — it doesn’t have any text to display. Therefore, applying a `font(_:)` modifier to the stack has no effect on the stack. Yet the font modifier does apply to any of the stack’s child views, some of which might display text. You can, however, locally override the stack’s modifier by adding another to a specific child view:

VStack {
Text("Title")
.font(.title) // Override the font of this view.
Text("First body line.")
Text("Second body line.")
}
.font(.body) // Set a default font for text in the stack.

### Use view-specific modifiers

While many view types rely on standard view modifiers for customization and control, some views do define modifiers that are specific to that view type. You can’t use such a modifier on anything but the appropriate kind of view. For example, `Text` defines the `bold()` modifier as a convenience for adding a bold effect to the view’s text. While you can use `font(_:)` on any view because it’s part of the `View` protocol, you can use `bold()` only on `Text` views. As a result, you can’t use it on a container view:

VStack {
Text("Hello, world!")
}
.bold() // Fails because 'VStack' doesn't have a 'bold' modifier.

You also can’t use it on a `Text` view after applying another general modifier because general modifiers return an opaque type. For example, the return value from the padding modifier isn’t `Text`, but rather an opaque result type that can’t take a bold modifier:

Text("Hello, world!")
.padding()
.bold() // Fails because 'some View' doesn't have a 'bold' modifier.

Instead, apply the bold modifier directly to the `Text` view and then add the padding:

Text("Hello, world!")
.bold() // Succeeds.
.padding()

## See Also

### Modifying a view

Reducing view modifier maintenance

Bundle view modifiers that you regularly reuse into a custom view modifier.

Applies a modifier to a view and returns a new view.

`protocol ViewModifier`

A modifier that you apply to a view or another view modifier, producing a different version of the original value.

`struct EmptyModifier`

An empty, or identity, modifier, used during development to switch modifiers at compile time.

`struct ModifiedContent`

A value with a modifier applied to it.

`protocol EnvironmentalModifier`

A modifier that must resolve to a concrete modifier in an environment before use.

`struct ManipulableModifier`

`struct ManipulableResponderModifier`

`struct ManipulableTransformBindingModifier`

`struct ManipulationGeometryModifier`

`struct ManipulationGestureModifier`

`struct ManipulationUsingGestureStateModifier`

`enum Manipulable`

A namespace for various manipulable related types.

---

# https://developer.apple.com/documentation/swiftui/reducing-view-modifier-maintenance

- SwiftUI
- View fundamentals
- Reducing view modifier maintenance

Article

# Reducing view modifier maintenance

Bundle view modifiers that you regularly reuse into a custom view modifier.

## Overview

To create consistent views, you might reuse the same view modifier or group of modifiers repeatedly across your views. For example, you might apply the same font and foreground color to many text instances throughout your app, so they all match. Unfortunately, this can lead to maintenance challenges, because even a small change in format, like a different font size, requires changes in many different parts of your code.

To avoid this overhead, collect a set of modifiers into a single location using an instance of the `ViewModifier` protocol. Then, extend the `View` protocol with a method that uses your modifier, making it easy to use and understand. Collecting the modifiers together provides a single location to update when you want to change them.

### Create a custom view modifier

When you create your custom modifier, name it to reflect the purpose of the collection. For example, if you repeatedly apply the `caption` font style and a secondary color scheme to views to represent a secondary styling, collect them together as `CaptionTextFormat`:

struct CaptionTextFormat: ViewModifier {

content
.font(.caption)
.foregroundColor(.secondary)
}
}

Apply your modifier using the `modifier(_:)` method. The following code applies the above example to a `Text` instance:

Text("Some additional information...")
.modifier(CaptionTextFormat())

### Extend the view protocol to provide fluent modifier access

To make your custom view modifier conveniently accessible, extend the `View` protocol with a function that applies your modifier:

extension View {

modifier(CaptionTextFormat())
}
}

Apply the modifier to a text view by including this extension:

Text("Some additional information...")
.captionTextFormat()

## See Also

### Modifying a view

Configuring views

Adjust the characteristics of a view by applying view modifiers.

Applies a modifier to a view and returns a new view.

`protocol ViewModifier`

A modifier that you apply to a view or another view modifier, producing a different version of the original value.

`struct EmptyModifier`

An empty, or identity, modifier, used during development to switch modifiers at compile time.

`struct ModifiedContent`

A value with a modifier applied to it.

`protocol EnvironmentalModifier`

A modifier that must resolve to a concrete modifier in an environment before use.

`struct ManipulableModifier`

`struct ManipulableResponderModifier`

`struct ManipulableTransformBindingModifier`

`struct ManipulationGeometryModifier`

`struct ManipulationGestureModifier`

`struct ManipulationUsingGestureStateModifier`

`enum Manipulable`

A namespace for various manipulable related types.

---

# https://developer.apple.com/documentation/swiftui/displaying-data-in-lists

- SwiftUI
- Lists
- Displaying data in lists

Article

# Displaying data in lists

Visualize collections of data with platform-appropriate appearance.

## Overview

Displaying a collection of data in a vertical list is a common requirement in many apps. Whether it’s a list of contacts, a schedule of events, an index of categories, or a shopping list, you’ll often find a use for a `List`.

List views display collections of items vertically, load rows as needed, and add scrolling when the rows don’t fit on the screen, making them suitable for displaying large collections of data.

By default, list views also apply platform-appropriate styling to their elements. For example, on iOS, the default configuration of a list displays a separator line between each row, and adds disclosure indicators next to items that initiate navigation actions.

The code in this article shows the use of list views to display a company’s staff directory. Each section enhances the usefulness of the list, by adding custom cells, splitting the list into sections, and using the list selection to navigate to a detail view.

### Prepare your data for iteration

The most common use of `List` is for representing collections of information in your data model. The following example defines a `Person` as an `Identifiable` type with the properties `name` and `phoneNumber`. An array called `staff` contains two instances of this type.

struct Person: Identifiable {
let id = UUID()
var name: String
var phoneNumber: String
}

var staff = [\
Person(name: "Juan Chavez", phoneNumber: "(408) 555-4301"),\
Person(name: "Mei Chen", phoneNumber: "(919) 555-2481")\
]

To present the contents of the array as a list, the example creates a `List` instance. The list’s content builder uses a `ForEach` to iterate over the `staff` array. For each member of the array, the listing creates a row view by instantiating a new `Text` that contains the name of the `Person`.

struct StaffList: View {
var body: some View {
List {
ForEach(staff) { person in
Text(person.name)
}
}
}
}

Members of a list must be uniquely identifiable from one another. Unique identifiers allow SwiftUI to automatically generate animations for changes in the underlying data, like inserts, deletions, and moves. Identify list members either by using a type that conforms to `Identifiable`, as `Person` does, or by providing an `id` parameter with the key path to a unique property of the type. The `ForEach` that populates the list above depends on this behavior, as do the `List` initializers that take a `RandomAccessCollection` of members to iterate over.

### Display data inside a row

Each row inside a `List` must be a SwiftUI `View`. You may be able to represent your data with a single view such as an `Image` or `Text` view, or you may need to define a custom view to compose several views into something more complex.

As your row views get more sophisticated, refactor the views into separate view structures, passing in the data that the row needs to render. The following example defines a `PersonRowView` to create a two-line view for a `Person`, using fonts, colors, and the system “phone” icon image to visually style the data.

struct PersonRowView: View {
var person: Person

var body: some View {
VStack(alignment: .leading, spacing: 3) {
Text(person.name)
.foregroundColor(.primary)
.font(.headline)
HStack(spacing: 3) {
Label(person.phoneNumber, systemImage: "phone")
}
.foregroundColor(.secondary)
.font(.subheadline)
}
}
}

struct StaffList: View {
var body: some View {
List {
ForEach(staff) { person in
PersonRowView(person: person)
}
}
}
}

For more information on composing the types of views commonly used inside list rows, see Building layouts with stack views.

### Represent data hierarchy with sections

`List` views can also display data with a level of hierarchy, grouping associated data into sections.

Consider an expanded data model that represents an entire company, including multiple departments. Each `Department` has a name and an array of `Person` instances, and the company has an array of the `Department` type.

struct Department: Identifiable {
let id = UUID()
var name: String
var staff: [Person]
}

struct Company {
var departments: [Department]
}

var company = Company(departments: [\
Department(name: "Sales", staff: [\
Person(name: "Juan Chavez", phoneNumber: "(408) 555-4301"),\
Person(name: "Mei Chen", phoneNumber: "(919) 555-2481"),\
// ...\
]),\
Department(name: "Engineering", staff: [\
Person(name: "Bill James", phoneNumber: "(408) 555-4450"),\
Person(name: "Anne Johnson", phoneNumber: "(417) 555-9311"),\
// ...\
]),\
// ...\
])

Use `Section` views to give the data inside a `List` a level of hierarchy. Start by creating the `List`, using a `ForEach` to iterate over the `company.departments` array, and then create `Section` views for each department. Within the section’s view builder, use a `ForEach` to iterate over the department’s `staff`, and return a customized view for each `Person`.

List {
ForEach(company.departments) { department in
Section(header: Text(department.name)) {
ForEach(department.staff) { person in
PersonRowView(person: person)
}
}
}
}

## Use Lists for Navigation

Using a `NavigationLink` within a `List` contained inside a `NavigationView` adds platform-appropriate visual styling, and in some cases, additional container views that provide the structure for navigation. SwiftUI uses one of two visual presentations, based on the runtime environment:

- A list with disclosure indicators, which performs an animated navigation to a destination scene when the user chooses a list item. SwiftUI uses this presentation on watchOS, tvOS, and on most iOS devices except as described below.

- A two-panel split view, with the top-level data as a list on the left side and the detail on the right. To get this presentation, you also need to provide a placeholder view after the list; this placeholder fills the detail pane until the user makes a selection. SwiftUI uses this two-panel approach on macOS, iPadOS, and on iOS devices with sufficient horizontal space, as indicated by the `horizontalSizeClass` environment value.

The following example sets up a navigation-based UI by wrapping the list with a navigation view. Instances of `NavigationLink` wrap the list’s rows to provide a `destination` view to navigate to when the user taps the row. If a split view navigation is appropriate for the platform, the right panel initially contains the “No Selection” placeholder view, which the navigation view replaces with the destination view when the user makes a selection.

NavigationView {
List {
ForEach(company.departments) { department in
Section(header: Text(department.name)) {
ForEach(department.staff) { person in
NavigationLink(destination: PersonDetailView(person: person)) {
PersonRowView(person: person)
}
}
}
}
}
.navigationTitle("Staff Directory")

// Placeholder
Text("No Selection")
.font(.headline)
}

In this example, the view passed in as the `destination` is a `PersonDetailView`, which repeats the information from the list. In a more complex app, this detail view could show more information about a `Person` than would fit inside the list row.

struct PersonDetailView: View {
var person: Person

var body: some View {
VStack {
Text(person.name)
.foregroundColor(.primary)
.font(.title)
.padding()
HStack {
Label(person.phoneNumber, systemImage: "phone")
}
.foregroundColor(.secondary)
}
}
}

On most iOS devices (those with a compact horizontal size class), the list appears as a view by itself, and tapping a row performs an animated transition to the destination view. The following figure shows both the list view and the destination view that appears when the user makes a selection:

On the other hand, iPadOS and macOS show the list and the detail view together as a multi-column view. The following figure shows what this example looks like on macOS prior to making a selection, which means the “No selection” placeholder view is still in the detail column.

You can use the `navigationViewStyle(_:)` view modifier to change the default behavior of a `NavigationView`. For example, on iOS, the `StackNavigationViewStyle` forces single-column mode, even on an iPad in landscape orientation.

## See Also

### Creating a list

`struct List`

A container that presents rows of data arranged in a single column, optionally providing the ability to select one or more members.

Sets the style for lists within this view.

---

# https://developer.apple.com/documentation/swiftui/migrating-to-the-swiftui-life-cycle

- SwiftUI
- App organization
- Migrating to the SwiftUI life cycle

Article

# Migrating to the SwiftUI life cycle

Use a scene-based life cycle in SwiftUI while keeping your existing codebase.

## Overview

Take advantage of the declarative syntax in SwiftUI and its compatibility with spatial frameworks by moving your app to the SwiftUI life cycle.

Moving to the SwiftUI life cycle requires several steps, including changing your app’s entry point, configuring the launch of your app, and monitoring life-cycle changes with the methods that SwiftUI provides.

### Change your app’s entry point

The UIKit framework defines the `AppDelegate` file as the entry point of your app with the annotation `@main`. For more information on `@main`, see the Attributes section in The Swift Programming Language. To indicate the entry of a SwiftUI app, you’ll need to create a new file that defines your app’s structure.

1. Open your project in Xcode.

4. Add `import SwiftUI` at the top of the file.

5. Annotate the app structure with the `@main` attribute to indicate the entry point of the SwiftUI app, as shown in the code snippet below.

Use following code to create the SwiftUI app structure. To learn more about this structure, follow the tutorial in Exploring the structure of a SwiftUI app.

import SwiftUI

@main
struct MyExampleApp: App {
var body: some Scene {
WindowGroup {
ContentView()
}
}
}

### Support app delegate methods

To continue using methods in your app delegate, use the `UIApplicationDelegateAdaptor` property wrapper. To tell SwiftUI about a delegate that conforms to the `UIApplicationDelegate` protocol, place this property wrapper inside your `App` declaration:

@main
struct MyExampleApp: App {
@UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate
var body: some Scene { ... }
}

This example marks a custom app delegate named `MyAppDelegate` as the delegate adaptor. Be sure to implement any necessary delegate methods in that type.

### Configure the launch of your app

If you’re migrating an app that contains storyboards to SwiftUI, make sure to remove them when they’re no longer needed.

2. Remove `Main.storyboard` from the project navigator.

3. Choose your app’s target.

4. Open the `Info.plist` file.

5. Remove the `Main storyboard file base name` key.

This figure shows the structure of the `Info.plist` file before removing these keys.

The scene delegate continues to be called after removing the keys from the `Info.plist` file, so you can still handle other scene-based life cycle changes in this file. If you were previously launching your app in your scene delegate, remove the `scene(_:willConnectTo:options:)` method from your scene delegate.

If you didn’t previously support scenes in your app and rely on your app delegate to respond to the launch of your app, ensure you’re no longer setting a root view controller in `application(_:didFinishLaunchingWithOptions:)`. Instead, return `true`.

### Monitor life cycle changes

You will no longer be able to monitor life-cycle changes in your app delegate due to the scene-based nature of SwiftUI (see `Scene`). Prefer to handle these changes in `ScenePhase`, the life cycle enumeration that SwiftUI provides to monitor the phases of a scene. Observe the `Environment` value to initiate actions when the phase changes.

@Environment(\.scenePhase) private var scenePhase

Interpret the value differently based on where you read it from. If you read the phase from inside a `View` instance, the value reflects the phase of the scene that contains the view. If you read the phase from within an `App` instance, the value reflects an aggregation of the phases of all of the scenes in your app.

To handle scene-based events with a scene delegate, provide your scene delegate to your SwiftUI app inside your app delegate. For more information, see the “Scene delegates” section of `UIApplicationDelegateAdaptor`.

For more information on handling scene-based life cycle events, see Managing your app’s life cycle.

## See Also

### Creating an app

Destination Video

Leverage SwiftUI to build an immersive media experience in a multiplatform app.

Hello World

Use windows, volumes, and immersive spaces to teach people about the Earth.

Backyard Birds: Building an app with SwiftData and widgets

Create an app with persistent data, interactive widgets, and an all new in-app purchase experience.

Food Truck: Building a SwiftUI multiplatform app

Create a single codebase and app target for Mac, iPad, and iPhone.

Fruta: Building a feature-rich app with SwiftUI

Create a shared codebase to build a multiplatform app that offers widgets and an App Clip.

`protocol App`

A type that represents the structure and behavior of an app.

---

# https://developer.apple.com/documentation/swiftui/view/body-8kl5o

- SwiftUI
- View
- body

Instance Property

# body

The content and behavior of the view.

@ViewBuilder @MainActor @preconcurrency
var body: Self.Body { get }

**Required** Default implementations provided.

## Mentioned in

Declaring a custom view

## Discussion

When you implement a custom view, you must implement a computed `body` property to provide the content for your view. Return a view that’s composed of built-in views that SwiftUI provides, plus other composite views that you’ve already defined:

struct MyView: View {
var body: some View {
Text("Hello, World!")
}
}

For more information about composing views and a view hierarchy, see Declaring a custom view.

## Default Implementations

### NSViewControllerRepresentable Implementations

`var body: Never`

Declares the content and behavior of this view.

### NSViewRepresentable Implementations

### UIViewControllerRepresentable Implementations

### UIViewRepresentable Implementations

### WKInterfaceObjectRepresentable Implementations

## See Also

### Implementing a custom view

`associatedtype Body : View`

The type of view representing the body of this view.

**Required**

Applies a modifier to a view and returns a new view.

Generate dynamic, interactive previews of your custom views.

---

# https://developer.apple.com/documentation/swiftui/text

- SwiftUI
- Text

Structure

# Text

A view that displays one or more lines of read-only text.

@frozen
struct Text

## Mentioned in

Configuring views

Building layouts with stack views

Declaring a custom view

Laying out a simple view

Displaying data in lists

## Overview

A text view draws a string in your app’s user interface using a `body` font that’s appropriate for the current platform. You can choose a different standard font, like `title` or `caption`, using the `font(_:)` view modifier.

Text("Hamlet")
.font(.title)

If you need finer control over the styling of the text, you can use the same modifier to configure a system font or choose a custom font. You can also apply view modifiers like `bold()` or `italic()` to further adjust the formatting.

Text("by William Shakespeare")
.font(.system(size: 12, weight: .light, design: .serif))
.italic()

To apply styling within specific portions of the text, you can create the text view from an `AttributedString`, which in turn allows you to use Markdown to style runs of text. You can mix string attributes and SwiftUI modifiers, with the string attributes taking priority.

let attributedString = try! AttributedString(
markdown: "_Hamlet_ by William Shakespeare")

var body: some View {
Text(attributedString)
.font(.system(size: 12, weight: .light, design: .serif))
}

A text view always uses exactly the amount of space it needs to display its rendered contents, but you can affect the view’s layout. For example, you can use the `frame(width:height:alignment:)` modifier to propose specific dimensions to the view. If the view accepts the proposal but the text doesn’t fit into the available space, the view uses a combination of wrapping, tightening, scaling, and truncation to make it fit. With a width of `100` points but no constraint on the height, a text view might wrap a long string:

Text("To be, or not to be, that is the question:")
.frame(width: 100)

Use modifiers like `lineLimit(_:)`, `allowsTightening(_:)`, `minimumScaleFactor(_:)`, and `truncationMode(_:)` to configure how the view handles space constraints. For example, combining a fixed width and a line limit of `1` results in truncation for text that doesn’t fit in that space:

Text("Brevity is the soul of wit.")
.frame(width: 100)
.lineLimit(1)

### Localizing strings

If you initialize a text view with a string literal, the view uses the `init(_:tableName:bundle:comment:)` initializer, which interprets the string as a localization key and searches for the key in the table you specify, or in the default table if you don’t specify one.

Text("pencil") // Searches the default table in the main bundle.

For an app localized in both English and Spanish, the above view displays “pencil” and “lápiz” for English and Spanish users, respectively. If the view can’t perform localization, it displays the key instead. For example, if the same app lacks Danish localization, the view displays “pencil” for users in that locale. Similarly, an app that lacks any localization information displays “pencil” in any locale.

To explicitly bypass localization for a string literal, use the `init(verbatim:)` initializer.

Text(verbatim: "pencil") // Displays the string "pencil" in any locale.

If you initialize a text view with a variable value, the view uses the `init(_:)` initializer, which doesn’t localize the string. However, you can request localization by creating a `LocalizedStringKey` instance first, which triggers the `init(_:tableName:bundle:comment:)` initializer instead:

// Don't localize a string variable...
Text(writingImplement)

// ...unless you explicitly convert it to a localized string key.
Text(LocalizedStringKey(writingImplement))

When localizing a string variable, you can use the default table by omitting the optional initialization parameters — as in the above example — just like you might for a string literal.

When composing a complex string, where there is a need to assemble multiple pieces of text, use string interpolation:

let name: String = //…
Text("Hello, \(name)")

This would look up the `"Hello, %@"` localization key in the localized string file and replace the format specifier `%@` with the value of `name` before rendering the text on screen.

Using string interpolation ensures that the text in your app can be localized correctly in all locales, especially in right-to-left languages.

If you desire to style only parts of interpolated text while ensuring that the content can still be localized correctly, interpolate `Text` or `AttributedString`:

let name = Text(person.name).bold()
Text("Hello, \(name)")

The example above uses `appendInterpolation(_:)` and will look up the `"Hello, %@"` in the localized string file and interpolate a bold text rendering the value of `name`.

Using `appendInterpolation(_:)` you can interpolate `Image` in text.

## Topics

### Creating a text view

`init(LocalizedStringKey, tableName: String?, bundle: Bundle?, comment: StaticString?)`

Creates a text view that displays localized content identified by a key.

`init(_:)`

Creates a text view that displays styled attributed content.

`init(verbatim: String)`

Creates a text view that displays a string literal without localization.

`init(Date, style: Text.DateStyle)`

Creates an instance that displays localized dates and times using a specific style.

`init(_:format:)`

Creates a text view that displays the formatted representation of a nonstring type supported by a corresponding format style.

`init(_:formatter:)`

Creates a text view that displays the formatted representation of a Foundation object.

Creates an instance that displays a timer counting within the provided interval.

### Choosing a font

Sets the default font for text in the view.

Sets the font weight of the text.

Sets the font design of the text.

Sets the font width of the text.

### Styling the view’s text

Sets the style of the text displayed by this view.

Applies a bold or emphasized treatment to the fonts of the text.

Applies a bold font weight to the text.

Applies italics to the text.

Applies a strikethrough to the text.

Applies an underline to the text.

Modifies the font of the text to use the fixed-width variant of the current font, if possible.

Modifies the text view’s font to use fixed-width digits, while leaving other characters proportionally spaced.

Sets the spacing, or kerning, between characters.

Sets the tracking for the text.

Sets the vertical offset for the text relative to its baseline.

`enum Case`

A scheme for transforming the capitalization of characters within text.

`struct DateStyle`

A predefined style used to display a `Date`.

`struct LineStyle`

Description of the style used to draw the line for `StrikethroughStyleAttribute` and `UnderlineStyleAttribute`.

### Fitting text into available space

Applies a text scale to the text.

`struct Scale`

Defines text scales

`enum TruncationMode`

The type of truncation to apply to a line of text when it’s too long to fit in the available space.

### Localizing text

`func typesettingLanguage(_:isEnabled:)`

Specifies the language for typesetting.

### Configuring voiceover

Raises or lowers the pitch of spoken text.

Sets whether VoiceOver should always speak all punctuation in the text view.

Controls whether to queue pending announcements behind existing speech rather than interrupting speech in progress.

Sets whether VoiceOver should speak the contents of the text view character by character.

### Providing accessibility information

Sets the accessibility level of this heading.

`func accessibilityLabel(_:)`

Adds a label to the view that describes its contents.

Sets an accessibility text content type.

### Combining text views

Concatenates the text in two text views in a new text view.

Deprecated

### Deprecated symbols

Sets the color of the text displayed by this view.

### Structures

`struct AlignmentStrategy`

The way SwiftUI infers the appropriate text alignment if no value is explicitly provided.

`struct Layout`

A value describing the layout and custom attributes of a tree of `Text` views.

`struct LayoutKey`

A preference key that provides the `Text.Layout` values for all text views in the queried subtree.

`struct WritingDirectionStrategy`

The way SwiftUI infers the appropriate writing direction if no value is explicitly provided.

### Instance Methods

Adds a custom attribute to the text view.

Controls the way text size variants are chosen.

## Relationships

### Conforms To

- `Copyable`
- `Equatable`
- `Sendable`
- `SendableMetatype`
- `View`

## See Also

### Displaying text

`struct Label`

A standard label for user interface items, consisting of an icon with a title.

Sets the style for labels within this view.

---

# https://developer.apple.com/documentation/swiftui/view/opacity(_:)

#app-main)

- SwiftUI
- View
- opacity(\_:)

Instance Method

# opacity(\_:)

Sets the transparency of this view.

nonisolated

## Parameters

`opacity`

A value between 0 (fully transparent) and 1 (fully opaque).

## Return Value

A view that sets the transparency of this view.

## Discussion

Apply opacity to reveal views that are behind another view or to de-emphasize a view.

When applying the `opacity(_:)` modifier to a view that has already had its opacity transformed, the modifier multiplies the effect of the underlying opacity transformation.

The example below shows yellow and red rectangles configured to overlap. The top yellow rectangle has its opacity set to 50%, allowing the occluded portion of the bottom rectangle to be visible:

struct Opacity: View {
var body: some View {
VStack {
Color.yellow.frame(width: 100, height: 100, alignment: .center)
.zIndex(1)
.opacity(0.5)

Color.red.frame(width: 100, height: 100, alignment: .center)
.padding(-40)
}
}
}

## See Also

### Hiding views

Hides this view unconditionally.

---

# https://developer.apple.com/documentation/swiftui/view-layout

Collection

- SwiftUI
- View fundamentals
- View
- Layout modifiers

API Collection

# Layout modifiers

Tell a view how to arrange itself within a view hierarchy by adjusting its size, position, alignment, padding, and so on.

## Overview

Use layout modifiers to fine tune the placement of views in a view hierarchy. You can adjust or constrain the size, position, and alignment of a view. You can also add padding around a view, and indicate how the view interacts with system-defined safe areas.

To get started arranging views, see Layout fundamentals. To make adjustments to a basic layout, see Layout adjustments.

## Topics

### Size

Positions this view within an invisible frame with the specified size.

Positions this view within an invisible frame with the specified depth.

Positions this view within an invisible frame having the specified size constraints.

Positions this view within an invisible frame having the specified depth constraints.

Positions this view within an invisible frame with a size relative to the nearest container.

Fixes this view at its ideal size.

Fixes this view at its ideal size in the specified dimensions.

Sets the priority by which a parent layout should apportion space to this child.

### Position

Positions the center of this view at the specified point in its parent’s coordinate space.

Positions the center of this view at the specified coordinates in its parent’s coordinate space.

Offset this view by the horizontal and vertical amount specified in the offset parameter.

Offset this view by the specified horizontal and vertical distances.

Brings a view forward in Z by the provided distance in points.

Assigns a name to the view’s coordinate space, so other code can operate on dimensions like points and sizes relative to the named space.

### Alignment

`func alignmentGuide(_:computeValue:)`

Sets the view’s horizontal alignment.

### Padding and spacing

`func padding(_:)`

Adds a different padding amount to each edge of this view.

Adds an equal padding amount to specific edges of this view.

`func padding3D(_:)`

Pads this view using the edge insets you specify.

Applies an inset to the rows in a list.

Adds padding to the specified edges of this view using an amount that’s appropriate for the current scene.

Adds a specified kind of padding to the specified edges of this view using an amount that’s appropriate for the current scene.

Sets the vertical spacing between two adjacent rows in a List.

`func listSectionSpacing(_:)`

Sets the spacing between adjacent sections in a `List` to a custom value.

### Grid configuration

Tells a view that acts as a cell in a grid to span the specified number of columns.

Specifies a custom alignment anchor for a view that acts as a grid cell.

Asks grid layouts not to offer the view extra size in the specified axes.

Overrides the default horizontal alignment of the grid column that the view appears in.

### Safe area and margins

Expands the safe area of a view.

`func safeAreaInset(edge:alignment:spacing:content:)`

Shows the specified content beside the modified view.

`func safeAreaPadding(_:)`

Adds the provided insets into the safe area of this view.

Configures the content margin for a provided placement.

`func contentMargins(_:_:for:)`

### Layer order

Controls the display order of overlapping views.

### Layout direction

Sets the behavior of this view for different layout directions.

### Custom layout characteristics

Associates a value with a custom layout property.

## See Also

### Drawing views

Apply built-in styles to different types of views.

Affect the way the system draws a view, for example by scaling or masking a view, or by applying graphical effects.

---

# https://developer.apple.com/documentation/swiftui/view-accessibility

Collection

- SwiftUI
- View fundamentals
- View
- Accessibility modifiers

API Collection

# Accessibility modifiers

Make your SwiftUI apps accessible to everyone, including people with disabilities.

## Overview

Like all Apple UI frameworks, SwiftUI comes with built-in accessibility support. The framework introspects common elements like navigation views, lists, text fields, sliders, buttons, and so on, and provides basic accessibility labels and values by default. You don’t have to do any extra work to enable these standard accessibility features.

SwiftUI also provides tools to help you enhance the accessibility of your app. For example, you can explicitly add accessibility labels to elements in your UI using the `accessibilityLabel(_:)` or the `accessibilityValue(_:)` view modifier.

To learn more about adding accessibility features to your app, see Accessibility fundamentals.

## Topics

### Labels

`func accessibilityLabel(_:)`

Adds a label to the view that describes its contents.

`func accessibilityLabel(_:isEnabled:)`

`func accessibilityInputLabels(_:)`

Sets alternate input labels with which users identify a view.

`func accessibilityInputLabels(_:isEnabled:)`

Pairs an accessibility element representing a label with the element for the matching content.

### Values

`func accessibilityValue(_:)`

Adds a textual description of the value that the view contains.

`func accessibilityValue(_:isEnabled:)`

### Hints

`func accessibilityHint(_:)`

Communicates to the user what happens after performing the view’s action.

`func accessibilityHint(_:isEnabled:)`

### Actions

Adds an accessibility action to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action.

Adds multiple accessibility actions to the view.

`func accessibilityAction(named:_:)`

Adds an accessibility action labeled by the contents of `label` to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action. When the action is performed, the `intent` will be invoked.

Adds an accessibility action representing `actionKind` to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action. When the action is performed, the `intent` will be invoked.

`func accessibilityAction(named:intent:)`

Adds an accessibility action labeled `name` to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action. When the action is performed, the `intent` will be invoked.

Adds an accessibility adjustable action to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action.

Adds an accessibility scroll action to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action.

### Gestures

`func accessibilityActivationPoint(_:)`

The activation point for an element is the location assistive technologies use to initiate gestures.

`func accessibilityActivationPoint(_:isEnabled:)`

`func accessibilityDragPoint(_:description:)`

The point an assistive technology should use to begin a drag interaction.

`func accessibilityDragPoint(_:description:isEnabled:)`

`func accessibilityDropPoint(_:description:)`

The point an assistive technology should use to end a drag interaction.

`func accessibilityDropPoint(_:description:isEnabled:)`

Explicitly set whether this accessibility element is a direct touch area. Direct touch areas passthrough touch events to the app rather than being handled through an assistive technology, such as VoiceOver. The modifier accepts an optional `AccessibilityDirectTouchOptions` option set to customize the functionality of the direct touch area.

Adds an accessibility zoom action to the view. Actions allow assistive technologies, such as VoiceOver, to interact with the view by invoking the action.

### Elements

Creates a new accessibility element, or modifies the `AccessibilityChildBehavior` of the existing accessibility element.

Replaces the existing accessibility element’s children with one or more new synthetic accessibility elements.

Specifies whether to hide this view from system accessibility features.

### Custom controls

Replaces one or more accessibility elements for this view with new accessibility elements.

Explicitly set whether this Accessibility element responds to user interaction and would thus be interacted with by technologies such as Switch Control, Voice Control or Full Keyboard Access.

### Custom content

`func accessibilityCustomContent(_:_:importance:)`

Add additional accessibility information to the view.

### Working with rotors

`func accessibilityRotor(_:entries:)`

Create an Accessibility Rotor with the specified user-visible label, and entries generated from the content closure.

`func accessibilityRotor(_:entries:entryID:entryLabel:)`

Create an Accessibility Rotor with the specified user-visible label and entries.

`func accessibilityRotor(_:entries:entryLabel:)`

`func accessibilityRotor(_:textRanges:)`

Create an Accessibility Rotor with the specified user-visible label and entries for each of the specified ranges. The Rotor will be attached to the current Accessibility element, and each entry will go the specified range of that element.

### Configuring rotors

Defines an explicit identifier tying an Accessibility element for this view to an entry in an Accessibility Rotor.

Links multiple accessibility elements so that the user can quickly navigate from one element to another, even when the elements are not near each other in the accessibility hierarchy.

Sets the sort priority order for this view’s accessibility element, relative to other elements at the same level.

### Focus

Modifies this view by binding its accessibility element’s focus state to the given boolean state value.

Modifies this view by binding its accessibility element’s focus state to the given state value.

### Traits

Adds the given traits to the view.

Removes the given traits from this view.

### Identity

Uses the string you specify to identify the view.

### Color inversion

Sets whether this view should ignore the system Smart Invert setting.

### Content descriptions

Sets an accessibility text content type.

Sets the accessibility level of this heading.

### VoiceOver

Raises or lowers the pitch of spoken text.

Sets whether VoiceOver should always speak all punctuation in the text view.

Controls whether to queue pending announcements behind existing speech rather than interrupting speech in progress.

Sets whether VoiceOver should speak the contents of the text view character by character.

### Charts

Adds a descriptor to a View that represents a chart to make the chart’s contents accessible to all users.

### Large content

Adds a default large content view to be shown by the large content viewer.

Adds a custom large content view to be shown by the large content viewer.

### Quick actions

Adds a quick action to be shown by the system when active.

## See Also

### Configuring view elements

Configure a view’s foreground and background styles, controls, and visibility.

Manage the rendering, selection, and entry of text in your view.

Add and configure supporting views, like toolbars and context menus.

Configure charts that you declare with Swift Charts.

---

# https://developer.apple.com/documentation/swiftui/view-input-and-events

Collection

- SwiftUI
- View fundamentals
- View
- Input and event modifiers

API Collection

# Input and event modifiers

Supply actions for a view to perform in response to user input and system events.

## Overview

Use input and event modifiers to configure and provide handlers for a wide variety of user inputs or system events. For example, you can detect and control focus, respond to life cycle events like view appearance and disappearance, manage keyboard shortcuts, and much more.

## Topics

### Interactivity

Adds a condition that controls whether users can interact with this view.

Sets a tag that you use for tracking interactivity.

### List controls

Adds custom swipe actions to a row in a list.

Marks this view as refreshable.

Adds a condition that controls whether users can select this view.

### Scroll controls

Associates a binding to a scroll position with a scroll view within this view.

Associates a binding to be updated when a scroll view within this view scrolls.

Associates an anchor to control which part of the scroll view’s content should be rendered by default.

Associates an anchor to control the position of a scroll view in a particular circumstance.

Sets the scroll behavior of views scrollable in the provided axes.

Configures the outermost layout as a scroll target layout.

Applies the given transition, animating between the phases of the transition as this view appears and disappears within the visible region of the containing scroll view.

Adds an action to be performed when a value, created from a scroll geometry, changes.

Adds an action to be called with information about what views would be considered visible.

Adds an action to be called when the view crosses the threshold to be considered on/off screen.

`func onScrollPhaseChange(_:)`

Adds an action to perform when the scroll phase of the first scroll view in the hierarchy changes.

### Geometry

`func onGeometryChange(for:of:action:)`

Adds an action to be performed when a value, created from a geometry proxy, changes.

### Taps and gestures

For more information, see Gestures.

Adds an action to perform when this view recognizes a tap gesture.

`func onTapGesture(count:coordinateSpace:perform:)`

Adds an action to perform when this view recognizes a tap gesture, and provides the action with the location of the interaction.

Adds an action to perform when this view recognizes a long press gesture.

Adds an action to perform when this view recognizes a remote long touch gesture. A long touch gesture is when the finger is on the remote touch surface without actually pressing.

`func gesture(_:)`

Attaches an `NSGestureRecognizerRepresentable` to the view.

Attaches a gesture to the view with a lower precedence than gestures defined by the view.

Attaches a gesture to the view with a higher precedence than gestures defined by the view.

Attaches a gesture to the view to process simultaneously with gestures defined by the view.

Sets the screen edge from which you want your gesture to take precedence over the system gesture.

Adds an action to perform after the user double-taps their Apple Pencil.

Adds an action to perform when the user squeezes their Apple Pencil.

Configures whether gestures in this view hierarchy can handle events that activate the containing window.

### Keyboard input

Performs an action if the user presses a key on a hardware keyboard while the view has focus.

Performs an action if the user presses any key on a hardware keyboard while the view has focus.

Performs an action if the user presses one or more keys on a hardware keyboard while the view has focus.

Performs an action whenever the user presses or releases a hardware modifier key.

### Keyboard shortcuts

`func keyboardShortcut(_:)`

Assigns a keyboard shortcut to the modified control.

Defines a keyboard shortcut and assigns it to the modified control.

Builds a view to use in place of the modified view when the user presses the modifier key(s) indicated by the given set.

### Hover

Adds an action to perform when the user moves the pointer over or away from the view’s frame.

`func onContinuousHover(coordinateSpace:perform:)`

Adds an action to perform when the pointer enters, moves within, and exits the view’s bounds.

Applies a hover effect to this view.

`func hoverEffect(_:isEnabled:)`

Applies a hover effect to this view, optionally adding it to a `HoverEffectGroup`.

Applies a hover effect to this view described by the given closure.

Adds an implicit `HoverEffectGroup` to all effects defined on descendant views, so that all effects added to subviews activate as a group whenever this view or any descendant views are hovered.

Adds a `HoverEffectGroup` to all effects defined on descendant views, and activates the group whenever this view or any descendant views are hovered.

Adds a condition that controls whether this view can display hover effects.

`func defaultHoverEffect(_:)`

Sets the default hover effect to use for views within this view.

Requests that the containing list row use the provided hover effect.

Requests that the containing list row have its hover effect disabled.

### Pointer

Sets the visibility of the pointer when it’s over the view.

Sets the pointer style to display when the pointer is over the view.

### Focus

For more information, see Focus.

Modifies this view by binding its focus state to the given state value.

Modifies this view by binding its focus state to the given Boolean state value.

Sets the focused value for the given object type.

`func focusedValue(_:_:)`

Modifies this view by injecting a value that you provide for use by other views whose state depends on the focused view hierarchy.

Sets the focused value for the given object type at a scene-wide scope.

`func focusedSceneValue(_:_:)`

Modifies this view by injecting a value that you provide for use by other views whose state depends on the focused scene.

`func focusedObject(_:)`

Creates a new view that exposes the provided object to other views whose whose state depends on the focused view hierarchy.

`func focusedSceneObject(_:)`

Creates a new view that exposes the provided object to other views whose whose state depends on the active scene.

Indicates that the view should receive focus by default for a given namespace.

Creates a focus scope that SwiftUI uses to limit default focus preferences.

Indicates that the view’s frame and cohort of focusable descendants should be used to guide focus movement.

Specifies if the view is focusable.

Specifies if the view is focusable, and if so, what focus-driven interactions it supports.

Adds a condition that controls whether this view can display focus effects, such as a default focus ring or hover effect.

Defines a region of the window in which default focus is evaluated by assigning a value to a given focus state binding.

Modifies this view by binding the focus state of the search field associated with the nearest searchable modifier to the given Boolean value.

Modifies this view by binding the focus state of the search field associated with the nearest searchable modifier to the given value.

### Copy and paste

For more information, see Clipboard.

Specifies a list of items to copy in response to the system’s Copy command.

Specifies an action that moves items to the Clipboard in response to the system’s Cut command.

Specifies an action that adds validated items to a view in response to the system’s Paste command.

Adds an action to perform in response to the system’s Copy command.

Adds an action to perform in response to the system’s Cut command.

`func onPasteCommand(of:perform:)`

Adds an action to perform in response to the system’s Paste command.

`func onPasteCommand(of:validator:perform:)`

Adds an action to perform in response to the system’s Paste command with items that you validate.

### Drag and drop

For more information, see Drag and drop.

Activates this view as the source of a drag and drop operation.

Provides a closure that vends the drag representation to be used for a particular data element.

`func onDrop(of:isTargeted:perform:)`

Defines the destination of a drag-and-drop operation that handles the dropped content with a closure that you specify.

`func onDrop(of:delegate:)`

Defines the destination of a drag and drop operation using behavior controlled by the delegate that you provide.

Defines the destination of a drag and drop operation that handles the dropped content with a closure that you specify.

Deprecated

Sets the spring loading behavior this view.

### Submission

Adds an action to perform when the user submits a value to this view.

Prevents submission triggers originating from this view to invoke a submission action configured by a submission modifier higher up in the view hierarchy.

Sets the submit label for this view.

### Movement

Adds an action to perform in response to a move command, like when the user presses an arrow key on a Mac keyboard, or taps the edge of the Siri Remote when controlling an Apple TV.

Adds a condition for whether the view’s view hierarchy is movable.

### Deletion

Adds an action to perform in response to the system’s Delete command, or pressing either the ⌫ (backspace) or ⌦ (forward delete) keys while the view has focus.

Adds a condition for whether the view’s view hierarchy is deletable.

### Commands

Steps a value through a range in response to page up or page down commands.

Sets up an action that triggers in response to receiving the exit command while the view has focus.

Adds an action to perform in response to the system’s Play/Pause command.

Adds an action to perform in response to the given selector.

### Digital crown

Specifies the visibility of Digital Crown accessory Views on Apple Watch.

Places an accessory View next to the Digital Crown on Apple Watch.

Tracks Digital Crown rotations by updating the specified binding.

`func digitalCrownRotation(detent:from:through:by:sensitivity:isContinuous:isHapticFeedbackEnabled:onChange:onIdle:)`

### Immersive Spaces

For more information, see Immersive spaces.

Performs an action when the immersion state of your app changes.

### Volumes

Adds an action to perform when the viewpoint of the volume changes.

Specifies which viewpoints are supported for the window bar and ornaments in a volume.

### User activities

Advertises a user activity type.

Registers a handler to invoke in response to a user activity that your app receives.

Specifies the external events that the view’s scene handles if the scene is already open.

### View life cycle

Adds an action to perform before this view appears.

Adds an action to perform after this view disappears.

`func onChange(of:initial:_:)`

Adds a modifier for this view that fires an action when a specific value changes.

Adds an asynchronous task to perform before this view appears.

Adds a task to perform before this view appears or when a specified value changes.

### File renaming

`func renameAction(_:)`

Sets a closure to run for the rename action.

### URLs

Registers a handler to invoke in response to a URL that your app receives.

Sets the URL to open in the containing app when the user clicks the widget.

### Publisher events

Adds an action to perform when this view detects data emitted by the given publisher.

### Hit testing

Configures whether this view participates in hit test operations.

### Content shape

Defines the content shape for hit testing.

Sets the content shape for this view.

### Import and export

Exports a read-only item provider for consumption by shortcuts, quick actions, and services.

Exports a read-write item provider for consumption by shortcuts, quick actions, and services.

Enables importing item providers from services, such as Continuity Camera on macOS.

Exports items for consumption by shortcuts, quick actions, and services.

Exports read-write items for consumption by shortcuts, quick actions, and services.

Enables importing items from services, such as Continuity Camera on macOS.

### App intents

Sets the given style for ShortcutsLinks within the view hierarchy

Sets the given style for SiriTipView within the view hierarchy

### Camera

Used to register an action triggered by system capture events.

Used to register actions triggered by system capture events.

Specifies the view that should act as the virtual camera for Apple Vision Pro 2D Persona stream.

## See Also

### Providing interactivity

Enable people to search for content in your app.

Define additional views for the view to present under specified conditions.

Access storage and provide child views with configuration data.

---

# https://developer.apple.com/documentation/swiftui/view/body-swift.associatedtype

- SwiftUI
- View
- Body

Associated Type

# Body

The type of view representing the body of this view.

associatedtype Body : View

**Required**

## Discussion

When you create a custom view, Swift infers this type from your implementation of the required `body` property.

## See Also

### Implementing a custom view

`var body: Self.Body`

The content and behavior of the view.

**Required** Default implementations provided.

Applies a modifier to a view and returns a new view.

Generate dynamic, interactive previews of your custom views.

---

# https://developer.apple.com/documentation/swiftui/view/modifier(_:)

#app-main)

- SwiftUI
- View
- modifier(\_:)

Instance Method

# modifier(\_:)

Applies a modifier to a view and returns a new view.

nonisolated

## Parameters

`modifier`

The modifier to apply to this view.

## Mentioned in

Reducing view modifier maintenance

## Discussion

Use this modifier to combine a `View` and a `ViewModifier`, to create a new view. For example, if you create a view modifier for a new kind of caption with blue text surrounded by a rounded rectangle:

struct BorderedCaption: ViewModifier {

content
.font(.caption2)
.padding(10)
.overlay(
RoundedRectangle(cornerRadius: 15)
.stroke(lineWidth: 1)
)
.foregroundColor(Color.blue)
}
}

You can use `modifier(_:)` to extend `View` to create new modifier for applying the `BorderedCaption` defined above:

extension View {

modifier(BorderedCaption())
}
}

Then you can apply the bordered caption to any view:

Image(systemName: "bus")
.resizable()
.frame(width:50, height:50)
Text("Downtown Bus")
.borderedCaption()

## See Also

### Modifying a view

Configuring views

Adjust the characteristics of a view by applying view modifiers.

Bundle view modifiers that you regularly reuse into a custom view modifier.

`protocol ViewModifier`

A modifier that you apply to a view or another view modifier, producing a different version of the original value.

`struct EmptyModifier`

An empty, or identity, modifier, used during development to switch modifiers at compile time.

`struct ModifiedContent`

A value with a modifier applied to it.

`protocol EnvironmentalModifier`

A modifier that must resolve to a concrete modifier in an environment before use.

`struct ManipulableModifier`

`struct ManipulableResponderModifier`

`struct ManipulableTransformBindingModifier`

`struct ManipulationGeometryModifier`

`struct ManipulationGestureModifier`

`struct ManipulationUsingGestureStateModifier`

`enum Manipulable`

A namespace for various manipulable related types.

---

# https://developer.apple.com/documentation/swiftui/view-appearance

Collection

- SwiftUI
- View fundamentals
- View
- Appearance modifiers

API Collection

# Appearance modifiers

Configure a view’s foreground and background styles, controls, and visibility.

## Overview

Use these modifiers to configure the appearance of a view, including the use of color and tint, and the application of overlays and background elements. Control the visibility of a view and specific elements within a view. Manage the shape and size of various controls.

For information about configuring views, see View configuration.

## Topics

### Colors and patterns

Sets the specified style to render backgrounds within the view.

Sets a view’s foreground elements to use a given style.

Sets the primary and secondary levels of the foreground style in the child view.

Sets the primary, secondary, and tertiary levels of the foreground style.

Returns a new view configured with the specified allowed dynamic range.

### Tint

`func tint(_:)`

Sets the tint color within this view.

Sets the tint color associated with a row.

Sets the tint color associated with a section.

`func listItemTint(_:)`

Sets a fixed tint color for content in a list.

### Light and dark appearance

Sets the preferred color scheme for this presentation.

Applies an effect to passthrough video.

### Foreground elements

Adds a border to this view with the specified style and width.

Layers the views that you specify in front of this view.

Layers the specified style in front of this view.

Layers a shape that you specify in front of this view.

### Background elements

Layers the views that you specify behind this view.

Sets the view’s background to a style.

Sets the view’s background to the default background style.

`func background(_:in:fillStyle:)`

Sets the view’s background to an insettable shape filled with a style.

`func background(in:fillStyle:)`

Sets the view’s background to an insettable shape filled with the default background style.

Overrides whether lists and tables in this view have alternating row backgrounds.

Places a custom background view behind a list row item.

Specifies the visibility of the background for scrollable views within this view.

Sets the container background of the enclosing container using a view.

Fills the view’s background with an automatic glass background effect and container-relative rounded rectangle shape.

Fills the view’s background with an automatic glass background effect and a shape that you specify.

### Control configuration

Sets the default wheel-style picker item height.

Sets the style for radio group style pickers within this view to be horizontally positioned with the radio buttons inside the layout.

`func controlSize(_:)`

Sets the size for controls within this view.

Sets the border shape for buttons in this view.

Sets whether buttons in this view should repeatedly trigger their actions on prolonged interactions.

Sets the header prominence for this view.

Disables or enables scrolling in scrollable views.

Configures the bounce behavior of scrollable views along the specified axis.

Flashes the scroll indicators of a scrollable view when it appears.

Flashes the scroll indicators of scrollable views when a value changes.

Sets the preferred order of items for menus presented from this view.

Tells a menu whether to dismiss after performing an action.

Specifies the selection effect to apply to a palette item.

`func typeSelectEquivalent(_:)`

Sets an explicit type select equivalent text in a collection, such as a list or table.

### Symbol effects

Returns a new view with a symbol effect added to it.

Returns a new view with its inherited symbol image effects either removed or left unchanged.

### Privacy and redaction

Marks the view as containing sensitive, private user data.

Adds a reason to apply a redaction to this view hierarchy.

Removes any reason to apply a redaction to this view hierarchy.

Mark the receiver as their content might be invalidated.

### Visibility

Hides this view unconditionally.

Hides the labels of any controls contained within this view.

Sets the menu indicator visibility for controls within this view.

Sets the display mode for the separator associated with this specific row.

Sets whether to hide the separator associated with a list section.

Sets the preferred visibility of the non-transient system views overlaying the app.

Sets the visibility of scroll indicators within this view.

Sets whether a scroll view clips its content to its bounds.

Controls the visibility of a `Table`’s column header views.

Sets the preferred visibility of the user’s upper limbs, while an `ImmersiveSpace` scene is presented.

Sets the visibility of the baseplate of a volume, which appears when a user looks towards the ‘floor’ of a volume and during resize. Both `automatic` and `visible` will show the baseplate. `hidden` will never show it.

### Sensory feedback

Plays the specified `feedback` when the provided `trigger` value changes.

`func sensoryFeedback(trigger:_:)`

Plays feedback when returned from the `feedback` closure after the provided `trigger` value changes.

Plays the specified `feedback` when the provided `trigger` value changes and the `condition` closure returns `true`.

### Widget configuration

Adds the view and all of its subviews to the accented group.

Displays the widget’s content along a curve if the context allows it.

`func widgetLabel(_:)`

Returns a localized text label that displays additional content outside the accessory family widget’s main SwiftUI view.

Creates a label for displaying additional content outside an accessory family widget’s main SwiftUI view.

Specifies the vertical placement for a view of an expanded Live Activity that appears in the Dynamic Island.

The view modifier that can be applied to `AccessoryWidgetGroup` to specify the shape the three content views will be masked with. The value of `style` is set to `.automatic`, which is `.circular` by default.

### Window behaviors

Configures the dismiss functionality for the window enclosing `self`.

Configures the full screen functionality for the window enclosing `self`.

Configures the minimize functionality for the window enclosing `self`.

Configures the resize functionality for the window enclosing `self`.

## See Also

### Configuring view elements

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Manage the rendering, selection, and entry of text in your view.

Add and configure supporting views, like toolbars and context menus.

Configure charts that you declare with Swift Charts.

---

# https://developer.apple.com/documentation/swiftui/view-text-and-symbols

Collection

- SwiftUI
- View fundamentals
- View
- Text and symbol modifiers

API Collection

# Text and symbol modifiers

Manage the rendering, selection, and entry of text in your view.

## Overview

SwiftUI provides built-in views that display text to the user, like `Text` and `Label`, or that collect text from the user, like `TextField` and `TextEditor`. Use text and symbol modifiers to control how SwiftUI displays and manages that text. For example, you can set a font, specify text layout parameters, and indicate what kind of input to expect.

To learn more about the kinds of views that you use to display text and the ways in which you can configure those views, see Text input and output.

## Topics

### Fonts

Sets the default font for text in this view.

### Dynamic type

`func dynamicTypeSize(_:)`

Sets the Dynamic Type size within the view to the given value.

### Text style

Applies a bold font weight to the text in this view.

Sets the font design of the text in this view.

Sets the font weight of the text in this view.

Sets the font width of the text in this view.

Applies italics to the text in this view.

Modifies the fonts of all child views to use the fixed-width variant of the current font, if possible.

Modifies the fonts of all child views to use fixed-width digits, if possible, while leaving other characters proportionally spaced.

Applies a strikethrough to the text in this view.

Sets a transform for the case of the text contained in this view when displayed.

Applies a text scale to text in the view.

Applies an underline to the text in this view.

### Text layout

Sets whether text in this view can compress the space between characters when necessary to fit text in a line.

Sets the vertical offset for the text relative to its baseline in this view.

Sets whether this view mirrors its contents horizontally when the layout direction is right-to-left.

Sets the spacing, or kerning, between characters for the text in this view.

Sets the minimum amount that text in this view scales down to fit in the available space.

Sets the tracking for the text in this view.

Sets the truncation mode for lines of text that are too long to fit in the available space.

`func typesettingLanguage(_:isEnabled:)`

Specifies the language for typesetting.

### Multiline text

`func lineLimit(_:)`

Sets to a closed range the number of lines that text can occupy in this view.

Sets a limit for the number of lines text can occupy in this view.

Sets the amount of space between lines of text in this view.

Sets the alignment of a text view that contains multiple lines of text.

### Text selection

Controls whether people can select text within this view.

### Text entry

Sets whether to disable autocorrection for this view.

Sets the keyboard type for this view.

Configures the behavior in which scrollable content interacts with the software keyboard.

Sets how often the shift key in the keyboard is automatically enabled.

Associates a fully formed string with the value of this view when used as a text input suggestion

Configures the text input suggestions for this view.

Sets the text content type for this view, which the system uses to offer suggestions while the user enters text on a watchOS device.

Sets the text content type for this view, which the system uses to offer suggestions while the user enters text on macOS.

Sets the text content type for this view, which the system uses to offer suggestions while the user enters text on an iOS or tvOS device.

### Find and replace

Programmatically presents the find and replace interface for text editor views.

Prevents find and replace operations in a text editor.

Prevents replace operations in a text editor.

### Symbol appearance

Sets the rendering mode for symbol images within this view.

Makes symbols within the view show a particular variant.

## See Also

### Configuring view elements

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Configure a view’s foreground and background styles, controls, and visibility.

Add and configure supporting views, like toolbars and context menus.

Configure charts that you declare with Swift Charts.

---

# https://developer.apple.com/documentation/swiftui/view-auxiliary-views

Collection

- SwiftUI
- View fundamentals
- View
- Auxiliary view modifiers

API Collection

# Auxiliary view modifiers

Add and configure supporting views, like toolbars and context menus.

## Overview

Use these modifiers to manage supplemental views that present context-specific controls and information. For example, you can add titles and buttons to navigation bars, manage the status bar, create context menus, and add badges many different kinds of views.

## Topics

### Navigation titles

Configure your apps navigation titles

Use a navigation title to display the current navigation state of an interface.

`func navigationTitle(_:)`

Configures the view’s title for purposes of navigation, using a string binding.

`func navigationSubtitle(_:)`

Configures the view’s subtitle for purposes of navigation.

### Navigation title configuration

`func navigationDocument(_:)`

Configures the view’s document for purposes of navigation.

`func navigationDocument(_:preview:)`

### Navigation bars

Hides the navigation bar back button for the view.

Configures the title display mode for this view.

### Navigation stacks and columns

Associates a destination view with a presented data type for use within a navigation stack.

Associates a destination view with a binding that can be used to push the view onto a `NavigationStack`.

`func navigationDestination<D, C>(item: Binding<Optional<D>>, destination: (D) -> C) -> some View`

Associates a destination view with a bound value for use within a navigation stack or navigation split view

Sets a fixed, preferred width for the column containing this view.

Sets a flexible, preferred width for the column containing this view.

### Tab views

Specifies the customizations to apply to the sidebar representation of the tab view.

Specifies the default placement for the tabs in a tab view using the adaptable sidebar style.

Adds a custom header to the sidebar of a tab view.

Adds a custom footer to the sidebar of a tab view.

Adds a custom bottom bar to the sidebar of a tab view.

Adds custom actions to a section.

### Toolbars

For information about toolbars, see Toolbars.

`func toolbar(content:)`

Populates the toolbar or navigation bar with the specified items.

Populates the toolbar or navigation bar with the specified items, allowing for user customization.

Specifies the visibility of a bar managed by SwiftUI.

Remove a toolbar item present by default

`func toolbarBackground(_:for:)`

Specifies the preferred shape style of the background of a bar managed by SwiftUI.

Specifies the preferred visibility of backgrounds on a bar managed by SwiftUI.

Specifies the preferred foreground style of bars managed by SwiftUI.

Specifies the preferred color scheme of a bar managed by SwiftUI.

Configures the semantic role for the content populating the toolbar.

Configure the title menu of a toolbar.

Configures the toolbar title display mode for this view.

`func ornament(visibility:attachmentAnchor:contentAlignment:ornament:)`

Presents an ornament.

### Context menus

For information about menus in your app, see Menus and commands.

Adds a context menu to a view.

Adds a context menu with a custom preview to a view.

Adds an item-based context menu to a view.

### Badges

`func badge(_:)`

Generates a badge for the view from an integer value.

Specifies the prominence of badges created by this view.

### Help text

`func help(_:)`

Adds help text to a view using a text view that you provide.

### Status bar

Sets the visibility of the status bar.

### Touch Bar

Sets the content that the Touch Bar displays.

Sets the Touch Bar content to be shown in the Touch Bar when applicable.

Sets principal views that have special significance to this Touch Bar.

Sets a user-visible string that identifies the view’s functionality.

Sets the behavior of the user-customized view.

## See Also

### Configuring view elements

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Configure a view’s foreground and background styles, controls, and visibility.

Manage the rendering, selection, and entry of text in your view.

Configure charts that you declare with Swift Charts.

---

# https://developer.apple.com/documentation/swiftui/view-chart-view

Collection

- SwiftUI
- View fundamentals
- View
- Chart view modifiers

API Collection

# Chart view modifiers

Configure charts that you declare with Swift Charts.

## Overview

Use these modifiers to configure a `Chart` view that you add to your SwiftUI app.

## Topics

### Styles

Adds a background to a view that contains a chart.

Configures the foreground style scale for charts.

Configures the plot area of charts.

### Legends

Configures the legend for charts.

### Overlays

Adds an overlay to a view that contains a chart.

### Axes

Sets the visibility of the x axis.

Configures the x-axis for charts in the view.

Configures the x axis content of charts.

Sets the visibility of the y axis.

Configures the y-axis for charts in the view.

Configures the y axis content of charts.

### Axis Labels

`func chartXAxisLabel(_:position:alignment:spacing:)`

Adds x axis label for charts in the view.

`func chartYAxisLabel(_:position:alignment:spacing:)`

Adds y axis label for charts in the view.

### Axis scales

Configures the x scale for charts.

Configures the y scale for charts.

### Symbol scales

`func chartSymbolScale(_:)`

Configures the symbol scale for charts.

Configures the symbol style scale for charts.

`func chartSymbolScale(domain:range:)`

`func chartSymbolScale(range:)`

### Symbol size scales

Configures the symbol size scale for charts.

### Line style scales

Configures the line style scale for charts.

### Scrolling

Sets the initial scroll position along the x-axis. Once the user scrolls the scroll view, the value provided to this modifier will have no effect.

Sets the initial scroll position along the y-axis. Once the user scrolls the scroll view, the value provided to this modifier will have no effect.

Associates a binding to be updated when the chart scrolls along the x-axis.

Associates a binding to be updated when the chart scrolls along the y-axis.

Sets the scroll behavior of the scrollable chart.

Configures the scrollable behavior of charts in this view.

### Visible domain

Sets the length of the visible domain in the X dimension.

Sets the length of the visible domain in the Y dimension.

## See Also

### Configuring view elements

Make your SwiftUI apps accessible to everyone, including people with disabilities.

Configure a view’s foreground and background styles, controls, and visibility.

Manage the rendering, selection, and entry of text in your view.

Add and configure supporting views, like toolbars and context menus.

---

# https://developer.apple.com/documentation/swiftui/view-style-modifiers

Collection

- SwiftUI
- View fundamentals
- View
- Style modifiers

API Collection

# Style modifiers

Apply built-in styles to different types of views.

## Overview

SwiftUI defines built-in styles for certain kinds of views, and chooses the appropriate style for a particular presentation context. For example, a `Label` might appear as an icon, a string title, or both, depending on factors like the platform, whether the view appears in a toolbar, and so on.

You can override the automatic style by using one of the style modifiers. These modifiers typically propagate through container views, so you can wrap an entire view hierarchy in a style modifier to affect all the views of the given type within the hierarchy. Some view types enable you to create custom styles, which you also apply using style modifiers.

For more information about styling views, see View styles.

## Topics

### Controls

`func buttonStyle(_:)`

Sets the style for buttons within this view to a button style with a custom appearance and standard interaction behavior.

Sets the style for date pickers within this view.

Sets the style for menus within this view.

Sets the style for pickers within this view.

Sets the style for toggles in a view hierarchy.

### Indicators

Sets the style for gauges within this view.

Sets the style for progress views in this view.

### Text

Sets the style for labels within this view.

Sets the style for text fields within this view.

Sets the style for text editors within this view.

### Collections

Sets the style for lists within this view.

Sets the style for tables within this view.

Sets the style for disclosure groups within this view.

### Presentation

Sets the style for navigation split views within this view.

Sets the style for the tab view within the current environment.

Sets the style for windows created by interacting with this view.

Sets the style for the toolbar in windows created by interacting with this view.

### Groups

Sets the style for control groups within this view.

Sets the style for group boxes within this view.

Sets the style for the index view within the current environment.

## See Also

### Drawing views

Tell a view how to arrange itself within a view hierarchy by adjusting its size, position, alignment, padding, and so on.

Affect the way the system draws a view, for example by scaling or masking a view, or by applying graphical effects.

---

# https://developer.apple.com/documentation/swiftui/view-graphics-and-rendering

Collection

- SwiftUI
- View fundamentals
- View
- Graphics and rendering modifiers

API Collection

# Graphics and rendering modifiers

Affect the way the system draws a view, for example by scaling or masking a view, or by applying graphical effects.

## Overview

Use these view modifiers to apply many of the rendering effects typically associated with a graphics context, like adding masks and creating composites. You can apply these effects to graphical views, like Shapes, as well as any other SwiftUI view.

When you do need the flexibility of immediate mode drawing in a graphics context, use a `Canvas` view instead. This can be particularly helpful when you want to draw an extremely large number of dynamic shapes — for example, to create particle effects.

For more information about using these effects in your app, see Drawing and graphics.

## Topics

### Masks and clipping

Masks this view using the alpha channel of the given view.

Clips this view to its bounding rectangular frame.

Sets a clipping shape for this view.

`func containerShape(_:)`

Sets the container shape to use for any container relative shape or concentric rectangle within this view.

### Scale

Scales this view to fill its parent.

Scales this view to fit its parent.

`func scaleEffect(_:anchor:)`

Scales this view’s rendered output by the given amount in both the horizontal and vertical directions, relative to an anchor point.

Scales this view’s rendered output by the given horizontal and vertical amounts, relative to an anchor point.

Scales this view by the specified horizontal, vertical, and depth factors, relative to an anchor point.

Scales images within the view according to one of the relative sizes available including small, medium, and large images sizes.

`func aspectRatio(_:contentMode:)`

Constrains this view’s dimensions to the specified aspect ratio.

### Rotation and transformation

Rotates a view’s rendered output in two dimensions around the specified point.

Rotates the view’s content by the specified 3D rotation value.

Renders a view’s content as if it’s rotated in three dimensions around the specified axis.

`func rotation3DEffect(_:axis:anchor:)`

Rotates the view’s content by an angle about an axis that you specify as a tuple of elements.

Applies a projection transformation to this view’s rendered output.

Applies an affine transformation to this view’s rendered output.

Applies a 3D transformation to this view’s rendered output.

### Graphical effects

Applies a Gaussian blur to this view.

Sets the transparency of this view.

Brightens this view by the specified amount.

Sets the contrast and separation between similar colors in this view.

Inverts the colors in this view.

Adds a color multiplication effect to this view.

Adjusts the color saturation of this view.

Adds a grayscale effect to this view.

Applies a hue rotation effect to this view.

Adds a luminance to alpha effect to this view.

Adds a shadow to this view.

Applies effects to this view, while providing access to layout information through a geometry proxy.

Applies effects to this view, while providing access to layout information through a 3D geometry proxy.

### Shaders

Returns a new view that applies `shader` to `self` as a filter effect on the color of each pixel.

Returns a new view that applies `shader` to `self` as a geometric distortion effect on the location of each pixel.

Returns a new view that applies `shader` to `self` as a filter on the raster layer created from `self`.

### Composites

Sets the blend mode for compositing this view with overlapping views.

Wraps this view in a compositing group.

Composites this view’s contents into an offscreen image before final display.

### Animations

`func animation(_:)`

Applies the given animation to this view when this view changes.

Applies the given animation to this view when the specified value changes.

Applies the given animation to all animatable values within the `body` closure.

Loops the given keyframes continuously, updating the view using the modifiers you apply in `body`.

Plays the given keyframes when the given trigger value changes, updating the view using the modifiers you apply in `body`.

Animates effects that you apply to a view over a sequence of phases that change continuously.

Animates effects that you apply to a view over a sequence of phases that change based on a trigger.

Modifies the view to use a given transition as its method of animating changes to the contents of its views.

`func transition(_:)`

Associates a transition with the view.

Applies the given transaction mutation function to all animations used within the view.

Applies the given transaction mutation function to all animations used within the `body` closure.

Defines a group of views with synchronized geometry using an identifier and namespace that you provide.

Isolates the geometry (e.g. position and size) of the view from its parent view.

## See Also

### Drawing views

Apply built-in styles to different types of views.

Tell a view how to arrange itself within a view hierarchy by adjusting its size, position, alignment, padding, and so on.

---

# https://developer.apple.com/documentation/swiftui/view-search

Collection

- SwiftUI
- View fundamentals
- View
- Search modifiers

API Collection

# Search modifiers

Enable people to search for content in your app.

## Overview

Use search view modifiers to add search capability to your app. For more information, see Search.

## Topics

### Displaying a search interface

`func searchable(text:placement:prompt:)`

Marks this view as searchable, which configures the display of a search field.

`func searchable(text:isPresented:placement:prompt:)`

Marks this view as searchable with programmatic presentation of the search field.

Configures the search toolbar presentation behavior for any searchable modifiers within this view.

### Searching with tokens

`func searchable(text:tokens:placement:prompt:token:)`

Marks this view as searchable with text and tokens.

`func searchable(text:tokens:isPresented:placement:prompt:token:)`

Marks this view as searchable with text and tokens, as well as programmatic presentation.

### Searching with editable tokens

`func searchable(text:editableTokens:isPresented:placement:prompt:token:)`

`func searchable(text:editableTokens:placement:prompt:token:)`

### Making search suggestions

Configures the search suggestions for this view.

Configures how to display search suggestions within this view.

`func searchCompletion(_:)`

Associates a fully formed string with the value of this view when used as a search suggestion.

`func searchable(text:tokens:suggestedTokens:placement:prompt:token:)`

Marks this view as searchable with text, tokens, and suggestions.

`func searchable(text:tokens:suggestedTokens:isPresented:placement:prompt:token:)`

Marks this view as searchable with text, tokens, and suggestions, as well as programmatic presentation.

### Limiting search scope

Configures the search scopes for this view.

Configures the search scopes for this view with the specified activation strategy.

### Searching through dictation

Configures the dictation behavior for any search fields configured by the searchable modifier.

## See Also

### Providing interactivity

Supply actions for a view to perform in response to user input and system events.

Define additional views for the view to present under specified conditions.

Access storage and provide child views with configuration data.

---

# https://developer.apple.com/documentation/swiftui/view-presentation

Collection

- SwiftUI
- View fundamentals
- View
- Presentation modifiers

API Collection

# Presentation modifiers

Define additional views for the view to present under specified conditions.

## Overview

Use presentation modifiers to show different kinds of modal presentations, like alerts, popovers, sheets, and confirmation dialogs.

Because SwiftUI is a declarative framework, you don’t call a method at the moment you want to present the modal. Rather, you define how the presentation looks and the condition under which SwiftUI should present it. SwiftUI detects when the condition changes and makes the presentation for you. Because you provide a `Binding` to the condition that initiates the presentation, SwiftUI can reset the underlying value when the user dismisses the presentation.

For more information about how to use these modifiers, see Modal presentations.

## Topics

### Alerts

`func alert(_:isPresented:actions:)`

Presents an alert when a given condition is true, using a text view for the title.

`func alert(_:isPresented:presenting:actions:)`

Presents an alert using the given data to produce the alert’s content and a text view as a title.

Presents an alert when an error is present.

### Alerts with a message

`func alert(_:isPresented:actions:message:)`

Presents an alert with a message when a given condition is true using a text view as a title.

`func alert(_:isPresented:presenting:actions:message:)`

Presents an alert with a message using the given data to produce the alert’s content and a text view for a title.

Presents an alert with a message when an error is present.

### Confirmation dialogs

`func confirmationDialog(_:isPresented:titleVisibility:actions:)`

Presents a confirmation dialog when a given condition is true, using a text view for the title.

`func confirmationDialog(_:isPresented:titleVisibility:presenting:actions:)`

Presents a confirmation dialog using data to produce the dialog’s content and a text view for the title.

`func dismissalConfirmationDialog(_:shouldPresent:actions:)`

Presents a confirmation dialog when a dismiss action has been triggered.

### Confirmation dialogs with a message

`func confirmationDialog(_:isPresented:titleVisibility:actions:message:)`

Presents a confirmation dialog with a message when a given condition is true, using a text view for the title.

`func confirmationDialog(_:isPresented:titleVisibility:presenting:actions:message:)`

Presents a confirmation dialog with a message using data to produce the dialog’s content and a text view for the message.

`func dismissalConfirmationDialog(_:shouldPresent:actions:message:)`

### Dialog configuration

Configures the icon used by dialogs within this view.

Enables user suppression of dialogs and alerts presented within `self`, with a default suppression message on macOS. Unused on other platforms.

`func dialogSuppressionToggle(_:isSuppressed:)`

Enables user suppression of dialogs and alerts presented within `self`, with a custom suppression message on macOS. Unused on other platforms.

### Sheets

Presents a sheet when a binding to a Boolean value that you provide is true.

Presents a sheet using the given item as a data source for the sheet’s content.

Presents a modal view that covers as much of the screen as possible when binding to a Boolean value you provide is true.

Presents a modal view that covers as much of the screen as possible using the binding you provide as a data source for the sheet’s content.

### Popovers

Presents a popover using the given item as a data source for the popover’s content.

Presents a popover when a given condition is true.

### Sheet and popover configuration

Conditionally prevents interactive dismissal of presentations like popovers, sheets, and inspectors.

Sets the available detents for the enclosing sheet.

Sets the available detents for the enclosing sheet, giving you programmatic control of the currently selected detent.

Sets the visibility of the drag indicator on top of a sheet.

Sets the presentation background of the enclosing sheet using a shape style.

Sets the presentation background of the enclosing sheet to a custom view.

Controls whether people can interact with the view behind a presentation.

Specifies how to adapt a presentation to horizontally and vertically compact size classes.

Specifies how to adapt a presentation to compact size classes.

Configures the behavior of swipe gestures on a presentation.

Requests that the presentation have a specific corner radius.

Sets the sizing of the containing presentation.

### File exporter

`func fileExporter(isPresented:document:contentType:defaultFilename:onCompletion:)`

Presents a system interface for exporting a document that’s stored in a value type, like a structure, to a file on disk.

`func fileExporter(isPresented:documents:contentType:onCompletion:)`

Presents a system interface for exporting a collection of value type documents to files on disk.

`func fileExporter(isPresented:document:contentTypes:defaultFilename:onCompletion:onCancellation:)`

Presents a system interface for allowing the user to export a `FileDocument` to a file on disk.

`func fileExporter(isPresented:documents:contentTypes:onCompletion:onCancellation:)`

Presents a system dialog for allowing the user to export a collection of documents that conform to `FileDocument` to files on disk.

Presents a system interface allowing the user to export a `Transferable` item to file on disk.

Presents a system interface allowing the user to export a collection of items to files on disk.

`func fileExporterFilenameLabel(_:)`

On macOS, configures the `fileExporter` with a label for the file name field.

### File importer

Presents a system interface for allowing the user to import multiple files.

Presents a system interface for allowing the user to import an existing file.

Presents a system dialog for allowing the user to import multiple files.

### File mover

Presents a system interface for allowing the user to move an existing file to a new location.

Presents a system interface for allowing the user to move a collection of existing files to a new location.

Presents a system dialog for allowing the user to move an existing file to a new location.

Presents a system dialog for allowing the user to move a collection of existing files to a new location.

### File dialog configuration

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` to provide a refined URL search experience: include or exclude hidden files, allow searching by tag, etc.

`func fileDialogConfirmationLabel(_:)`

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` with a custom confirmation button label.

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` to persist and restore the file dialog configuration.

Configures the `fileExporter`, `fileImporter`, or `fileMover` to open with the specified default directory.

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` behavior when a user chooses an alias.

`func fileDialogMessage(_:)`

On macOS, configures the `fileExporter`, `fileImporter`, or `fileMover` with a custom text that is presented to the user, similar to a title.

On macOS, configures the `fileImporter` or `fileMover` to conditionally disable presented URLs.

### Inspectors

Inserts an inspector at the applied position in the view hierarchy.

Sets a fixed, preferred width for the inspector containing this view when presented as a trailing column.

Sets a flexible, preferred width for the inspector in a trailing-column presentation.

### Quick look previews

Presents a Quick Look preview of the contents of a single URL.

Presents a Quick Look preview of the URLs you provide.

### Family Sharing

Presents an activity picker view as a sheet.

### Live Activities

The text color for the auxiliary action button that the system shows next to a Live Activity on the Lock Screen.

Sets the tint color for the background of a Live Activity that appears on the Lock Screen.

### Apple Music

Initiates the process of presenting a sheet with subscription offers for Apple Music when the `isPresented` binding is `true`.

### StoreKit

Presents a StoreKit overlay when a given condition is true.

Display the refund request sheet for the given transaction.

Presents a sheet that enables customers to redeem offer codes that you configure in App Store Connect.

### PhotoKit

Presents a Photos picker that selects a `PhotosPickerItem`.

Presents a Photos picker that selects a `PhotosPickerItem` from a given photo library.

Presents a Photos picker that selects a collection of `PhotosPickerItem`.

Presents a Photos picker that selects a collection of `PhotosPickerItem` from a given photo library.

Sets the accessory visibility of the Photos picker. Accessories include anything between the content and the edge, like the navigation bar or the sidebar.

Disables capabilities of the Photos picker.

Sets the mode of the Photos picker.

## See Also

### Providing interactivity

Supply actions for a view to perform in response to user input and system events.

Enable people to search for content in your app.

Access storage and provide child views with configuration data.

---

# https://developer.apple.com/documentation/swiftui/view-state

Collection

- SwiftUI
- View fundamentals
- View
- State modifiers

API Collection

# State modifiers

Access storage and provide child views with configuration data.

## Overview

SwiftUI provides tools for managing data in your app. For example, you can store values and objects in an environment that’s shared among the views in a view hierarchy. Any view that shares the environment — typically all the descendant views of the view that stores the item — can then access the stored item.

For more information about the types that SwiftUI provides to help manage data in your app, see Model data.

## Topics

### Identity

Sets the unique tag value of this view.

Binds a view’s identity to the given proxy value.

Prevents the view from updating its child view when its new value is the same as its old value.

### Environment values

Places an observable object in the view’s environment.

Sets the environment value of the specified key path to the given value.

Supplies an observable object to a view’s hierarchy.

Transforms the environment value of the specified key path with the given function.

### Preferences

Sets a value for the given preference.

Applies a transformation to a preference value.

Sets a value for the specified preference key, the value is a function of a geometry value tied to the current coordinate space, allowing readers of the value to convert the geometry to their local coordinates.

Sets a value for the specified preference key, the value is a function of the key’s current value and a geometry value tied to the current coordinate space, allowing readers of the value to convert the geometry to their local coordinates.

Adds an action to perform when the specified preference key’s value changes.

Reads the specified preference value from the view, using it to produce a second view that is applied as the background of the original view.

Reads the specified preference value from the view, using it to produce a second view that is applied as an overlay to the original view.

### Default storage

The default store used by `AppStorage` contained within the view.

### Configuring a model

Sets the model context in this view’s environment.

Sets the model container and associated model context in this view’s environment.

`func modelContainer(for:inMemory:isAutosaveEnabled:isUndoEnabled:onSetup:)`

Sets the model container in this view for storing the provided model type, creating a new container if necessary, and also sets a model context for that container in this view’s environment.

## See Also

### Providing interactivity

Supply actions for a view to perform in response to user input and system events.

Enable people to search for content in your app.

Define additional views for the view to present under specified conditions.

---

# https://developer.apple.com/documentation/swiftui/view-deprecated

Collection

- SwiftUI
- View fundamentals
- View
- Deprecated modifiers

API Collection

# Deprecated modifiers

Review unsupported modifiers and their replacements.

## Overview

Avoid using deprecated modifiers in your app. Select a modifier to see the replacement that you should use instead.

## Topics

### Accessibility modifiers

Adds a label to the view that describes its contents.

Deprecated

Adds a textual description of the value that the view contains.

Specifies whether to hide this view from system accessibility features.

Uses the specified string to identify the view.

Sets a selection identifier for this view’s accessibility element.

Communicates to the user what happens after performing the view’s action.

`func accessibility(activationPoint:)`

Specifies the point where activations occur in the view.

Sets alternate input labels with which users identify a view.

Adds the given traits to the view.

Removes the given traits from this view.

Sets the sort priority order for this view’s accessibility element, relative to other elements at the same level.

### Appearance modifiers

Sets this view’s color scheme.

Sets the color that the system applies to the row background when this view is placed in a list.

Layers the given view behind this view.

Layers a secondary view in front of this view.

Sets the color of the foreground elements displayed by this view.

Promotes this view to the foreground in a complication.

### Text modifiers

Sets whether to apply auto-capitalization to this view.

Sets whether to disable autocorrection for this view.

### Auxiliary view modifiers

`func navigationBarTitle(_:)`

Sets the title in the navigation bar for this view.

`func navigationBarTitle(_:displayMode:)`

Sets the title and display mode in the navigation bar for this view.

Sets the navigation bar items for this view.

Configures the navigation bar items for this view.

Hides the navigation bar for this view.

Sets the visibility of the status bar.

Adds a context menu to the view.

### Style modifiers

Sets the style for menu buttons within this view.

Sets the style for navigation views within this view.

### Layout modifiers

Positions this view within an invisible frame.

Changes the view’s proposed area to extend outside the screen’s safe areas.

Assigns a name to the view’s coordinate space, so other code can operate on dimensions like points and sizes relative to the named space.

### Graphics and rendering modifiers

Sets the accent color for this view and the views it contains.

Masks this view using the alpha channel of the given view.

Applies the given animation to all animatable values within this view.

Clips this view to its bounding frame, with the specified corner radius.

### Input and events modifiers

Adds an action to perform when the given value changes.

Adds an action to perform when this view recognizes a tap gesture, and provides the action with the location of the interaction.

Adds an action to perform when this view recognizes a long press gesture.

Adds an action to perform in response to the system’s Paste command.

Adds an action to perform in response to the system’s Paste command with items that you validate.

Defines the destination for a drag and drop operation with the same size and position as this view, with behavior controlled by the given delegate.

`func onDrop(of:isTargeted:perform:)`

Defines the destination of a drag-and-drop operation that handles the dropped content with a closure that you specify.

Specifies if the view is focusable and, if so, adds an action to perform when the view comes into focus.

Adds an action to perform when the pointer enters, moves within, and exits the view’s bounds.

### View presentation modifiers

Presents an action sheet when a given condition is true.

Presents an action sheet using the given item as a data source for the sheet’s content.

Presents an alert to the user.

### Search modifiers

`func searchable(text:placement:prompt:suggestions:)`

Marks this view as searchable, which configures the display of a search field.

### Tab modifiers

Sets the tab bar item associated with this view.

---

# https://developer.apple.com/documentation/swiftui/view/accessibilityactions(category:_:)

#app-main)

- SwiftUI
- View
- accessibilityActions(category:\_:)

Instance Method

# accessibilityActions(category:\_:)

Adds multiple accessibility actions to the view with a specific category. Actions allow assistive technologies, such as VoiceOver, to interact with the view by invoking the action and are grouped by their category. When multiple action modifiers with an equal category are applied to the view, the actions are combined together.

nonisolated

category: AccessibilityActionCategory,

## Parameters

`category`

The category the accessibility actions are grouped by.

`content`

The accessibility actions added to the view.

## Discussion

Var body: some View { EditorView() .accessibilityActions(category: .edit) { ForEach(editActions) { action in Button(action.title) { action() } } if hasTextSuggestions { Button(“Show Text Suggestions”) { presentTextSuggestions() } } } }

## See Also

### Adding actions to views

Adds an accessibility action to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action.

Adds multiple accessibility actions to the view.

`func accessibilityAction(named:_:)`

Adds an accessibility action labeled by the contents of `label` to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action. When the action is performed, the `intent` will be invoked.

Adds an accessibility action representing `actionKind` to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action. When the action is performed, the `intent` will be invoked.

`func accessibilityAction(named:intent:)`

Adds an accessibility action labeled `name` to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action. When the action is performed, the `intent` will be invoked.

Adds an accessibility adjustable action to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action.

Adds an accessibility scroll action to the view. Actions allow assistive technologies, such as the VoiceOver, to interact with the view by invoking the action.

`struct AccessibilityActionKind`

The structure that defines the kinds of available accessibility actions.

`enum AccessibilityAdjustmentDirection`

A directional indicator you use when making an accessibility adjustment.

`struct AccessibilityActionCategory`

Designates an accessibility action category that is provided and named by the system.

---

# https://developer.apple.com/documentation/swiftui/view/accessibilitydefaultfocus(_:_:)

#app-main)

- SwiftUI
- View
- accessibilityDefaultFocus(\_:\_:)

Instance Method

# accessibilityDefaultFocus(\_:\_:)

Defines a region in which default accessibility focus is evaluated by assigning a value to a given accessibility focus state binding.

nonisolated

_ value: Value

## Parameters

`binding`

An accessibility focus state binding to update when evaluating default accessibility focus.

`value`

The value to set the binding to during evaluation.

## Discussion

Accessibility default focus is evaluated when a scene appears and an accessibility technology like VoiceOver focuses on its content, when an accessibility focus state binding update moves focus automatically, and when the layout of a scene changes and the accessibility technology must refocus on new content.

In the following example, an accessibility technology, like VoiceOver, automatically lands on the title of the playlist as the most important view to initially have focus on, rather than navigating through all controls to understand what the primary content of the view is.

var body: some View {
VStack {
PlayerControls(currentSong: $currentSong)
Text(playlist.title)
.font(.title)
.accessibilityFocused($focusedField, equals: .title)
PlaylistEntries(entries: playlist.entries)
}
.accessibilityDefaultFocus($focusedField, .title)
}

---

# https://developer.apple.com/documentation/swiftui/view/accessibilityscrollstatus(_:isenabled:)

#app-main)

- SwiftUI
- View
- accessibilityScrollStatus(\_:isEnabled:)

Instance Method

# accessibilityScrollStatus(\_:isEnabled:)

Changes the announcement provided by accessibility technologies when a user scrolls a scroll view within this view.

nonisolated
func accessibilityScrollStatus(
_ status: LocalizedStringResource,
isEnabled: Bool = true

Show all declarations

## Parameters

`status`

The current status of the scroll view.

`isEnabled`

If true the accessibility scroll status is applied; otherwise the accessibility scroll status is unchanged.

## Discussion

Use this modifier to provide a description of the content at the current position in the scroll view. For example, you could use this modifier to announce the current month being scrolled to in a view that contains a calendar.

@State private var position = ScrollPosition(idType: Month.ID.self)

ScrollView {
LazyVStack {
ForEach(months) { months in
MonthView(month: months)
}
}
.scrollTargetLayout()
}
.scrollPosition($position)
.accessibilityScrollStatus("\(months.name(position.viewID)) \(year)")

By default, VoiceOver announces “Page X of Y” while scrolling.

---

# https://developer.apple.com/documentation/swiftui/view/addordertowalletbuttonstyle(_:)

#app-main)

- SwiftUI
- View
- addOrderToWalletButtonStyle(\_:)

Instance Method

# addOrderToWalletButtonStyle(\_:)

Sets the button’s style.

@MainActor @preconcurrency

## Discussion

(See `AddOrderToWalletButtonStyle`).

## See Also

### Accessing Apple Pay and Wallet

`struct PayWithApplePayButton`

A type that provides a button to pay with Apple pay.

`struct AddPassToWalletButton`

A type that provides a button that enables people to add a new or existing pass to Apple Wallet.

`struct VerifyIdentityWithWalletButton`

A type that displays a button to present the identity verification flow.

Sets the style to be used by the button. (see `PKAddPassButtonStyle`).

Called when a user has entered or updated a coupon code. This is required if the user is being asked to provide a coupon code.

Called when a payment method has changed and asks for an update payment request. If this modifier isn’t provided Wallet will assume the payment method is valid.

Called when a user selected a shipping address. This is required if the user is being asked to provide a shipping contact.

Called when a user selected a shipping method. This is required if the user is being asked to provide a shipping method.

Sets the action on the PayLaterView. See `PKPayLaterAction`.

Sets the display style on the PayLaterView. See `PKPayLaterDisplayStyle`.

Sets the style to be used by the button. (see `PayWithApplePayButtonStyle`).

Sets the style to be used by the button. (see `PKIdentityButtonStyle`).

`struct AsyncShareablePassConfiguration`

Provides a task to perform before this view appears

---

# https://developer.apple.com/documentation/swiftui/view/addpasstowalletbuttonstyle(_:)

#app-main)

- SwiftUI
- View
- addPassToWalletButtonStyle(\_:)

Instance Method

# addPassToWalletButtonStyle(\_:)

Sets the style to be used by the button. (see `PKAddPassButtonStyle`).

PassKitSwiftUI

nonisolated

## See Also

### Accessing Apple Pay and Wallet

`struct PayWithApplePayButton`

A type that provides a button to pay with Apple pay.

`struct AddPassToWalletButton`

A type that provides a button that enables people to add a new or existing pass to Apple Wallet.

`struct VerifyIdentityWithWalletButton`

A type that displays a button to present the identity verification flow.

Sets the button’s style.

Called when a user has entered or updated a coupon code. This is required if the user is being asked to provide a coupon code.

Called when a payment method has changed and asks for an update payment request. If this modifier isn’t provided Wallet will assume the payment method is valid.

Called when a user selected a shipping address. This is required if the user is being asked to provide a shipping contact.

Called when a user selected a shipping method. This is required if the user is being asked to provide a shipping method.

Sets the action on the PayLaterView. See `PKPayLaterAction`.

Sets the display style on the PayLaterView. See `PKPayLaterDisplayStyle`.

Sets the style to be used by the button. (see `PayWithApplePayButtonStyle`).

Sets the style to be used by the button. (see `PKIdentityButtonStyle`).

`struct AsyncShareablePassConfiguration`

Provides a task to perform before this view appears

---

# https://developer.apple.com/documentation/swiftui/view/allowswindowactivationevents()

#app-main)

- SwiftUI
- View
- allowsWindowActivationEvents()

Instance Method

# allowsWindowActivationEvents()

Configures gestures in this view hierarchy to handle events that activate the containing window.

nonisolated

## Discussion

Views higher in the hierarchy can override the value you set on this view. In the following example, the tap gesture on the `Rectangle` won’t handle events that activate the containing window because the outer `allowsWindowActivationEvents(_:)` view modifier overrides the inner one:

HStack {
Rectangle()
.onTapGesture { ... }
.allowsWindowActivationEvents()
}
.allowsWindowActivationEvents(false)

---

# https://developer.apple.com/documentation/swiftui/view/appstoremerchandising(ispresented:kind:ondismiss:)

#app-main)

- SwiftUI
- View
- appStoreMerchandising(isPresented:kind:onDismiss:)

Instance Method

# appStoreMerchandising(isPresented:kind:onDismiss:)

StoreKitSwiftUI

nonisolated
func appStoreMerchandising(

kind: AppStoreMerchandisingKind,

---

# https://developer.apple.com/documentation/swiftui/view/aspectratio3d(_:contentmode:)

#app-main)

- SwiftUI
- View
- aspectRatio3D(\_:contentMode:)

Instance Method

# aspectRatio3D(\_:contentMode:)

Constrains this view’s dimensions to the specified 3D aspect ratio.

nonisolated
func aspectRatio3D(
_ aspectRatio: Size3D? = nil,
contentMode: ContentMode

## Parameters

`aspectRatio`

The ratio of width to height to depth to use for the resulting view. If `aspectRatio` is `nil`, the resulting view maintains this view’s aspect ratio.

`contentMode`

A flag indicating whether this view should fit or fill the parent context.

## Return Value

A view that constrains this view’s dimensions to `aspectRatio`, using `contentMode` as its scaling algorithm.

## Discussion

If this view is resizable, the resulting view will have `aspectRatio` as its aspect ratio. In this example, the Model3D has a 2 : 3 : 1 width to height to depth ratio, and scales to fit its frame:

Model3D(named: "Sphere") { resolved in
let ratio3D = Size3D(width: 2, height: 3, depth: 1)
resolved
.resizable()
.aspectRatio3D(ratio3D, contentMode: .fit)
} placeholder: {
ProgressView()
}
.frame(width: 200, height: 200)
.frame(depth: 200)
.border(Color(white: 0.75))

---

# https://developer.apple.com/documentation/swiftui/view/assistiveaccessnavigationicon(_:)

#app-main)

- SwiftUI
- View
- assistiveAccessNavigationIcon(\_:)

Instance Method

# assistiveAccessNavigationIcon(\_:)

Configures the view’s icon for purposes of navigation.

nonisolated

## Parameters

`icon`

The icon image to display.

## Discussion

In an Assistive Access scene on iOS and iPadOS, the icon is displayed adjacent to the navigation title. Otherwise, the icon is unused.

---

# https://developer.apple.com/documentation/swiftui/view/assistiveaccessnavigationicon(systemimage:)

#app-main)

- SwiftUI
- View
- assistiveAccessNavigationIcon(systemImage:)

Instance Method

# assistiveAccessNavigationIcon(systemImage:)

Configures the view’s icon for purposes of navigation.

nonisolated

## Parameters

`systemImage`

The system symbol to display.

## Discussion

In an Assistive Access scene on iOS and iPadOS, the icon is displayed adjacent to the navigation title. Otherwise, the icon is unused.

---

# https://developer.apple.com/documentation/swiftui/view/attributedtextformattingdefinition(_:)

#app-main)

- SwiftUI
- View
- attributedTextFormattingDefinition(\_:)

Instance Method

# attributedTextFormattingDefinition(\_:)

Apply a text formatting definition to nested views.

nonisolated

Show all declarations

## Discussion

Applying a text formatting definition to a `Text` or `TextEditor` created using the `init(_:)` or `init(text:selection:)` initializer, respectively, makes sure that any content observable to the user adheres to the constraints of the formatting definition.

You can compose your own definition from an attribute scope and a series of `AttributedTextValueConstraint` s:

// MyTextFormattingDefinition.swift

struct MyTextFormattingDefinition: AttributedTextFormattingDefinition {
var body: some AttributedTextFormattingDefinition<

ValueConstraint(
for: \.underlineStyle,
values: [nil, .single],
default: .single)
MyAttributedTextValueConstraint()
}
}

// MyEditorView.swift

TextEditor(text: $text)
.attributedTextFormattingDefinition(MyTextFormattingDefinition())

To manually enforce constraints, e.g. before serializing text contents, use the `constrain(_:)` method.

---

# https://developer.apple.com/documentation/swiftui/view/automateddeviceenrollmentaddition(ispresented:)

#app-main)

- SwiftUI
- View
- automatedDeviceEnrollmentAddition(isPresented:)

Instance Method

# automatedDeviceEnrollmentAddition(isPresented:)

Presents a modal view that enables users to add devices to their organization.

@MainActor @preconcurrency

## Parameters

`isPresented`

A binding to a Boolean value that determines whether to present the view.

## Return Value

The modal view that the system presents to the user.

## Discussion

Use this view modifier to present UI in your app for device administrators to add devices purchased outside of the official channel to their organization — Apple School Manager, Apple Business Manager, or Apple Business Essentials. The system requires sign in with a Managed Apple Account that includes device enrollment privileges.

The following code example shows one way to present this view to your users:

Example Usage:

import SwiftUI
import AutomatedDeviceEnrollment

struct ContentView: View {
@State private var isAddingDevices: Bool = false

var body: some View {
Button("Add Devices to Automated Device Enrollment") {
isAddingDevices = true
}
.automatedDeviceEnrollmentAddition(isPresented: $isAddingDevices)
.onChange(of: isAddingDevices) {
if !isAddingDevices {
// Handle dismiss action
}
}
}
}

## See Also

### Working with managed devices

Applies a managed content style to the view.

---

# https://developer.apple.com/documentation/swiftui/view/backgroundextensioneffect(isenabled:)



---

# https://developer.apple.com/documentation/swiftui/view/breakthrougheffect(_:)

#app-main)

- SwiftUI
- View
- breakthroughEffect(\_:)

Instance Method

# breakthroughEffect(\_:)

Ensures that the view is always visible to the user, even when other content is occluding it, like 3D models.

nonisolated

## Parameters

`effect`

The type of effect to apply when the view is occluded by other content.

## Discussion

Breakthrough is an effect allowing elements to be visible to the user even when other app content (3D models, UI elements) is positioned in front. The way the element breaks through content in front depends on the chosen `BreakthroughEffect`.

This modifier can be used in a number of scenarios, including ornaments and `RealityView` attachments to have them break through in their entirety.

### Regular Elements

To have SwiftUI element break through content in front, apply the `breakthroughEffect` modifier directly to the View:

ResizeHandle()
.breakthroughEffect(.subtle)

### Ornaments

When applied to the whole content of an ornament, the ornament (including its background) will break through content in front:

Text("A view with an ornament")
.ornament(attachmentAnchor: .scene(.bottom)) {
OrnamentContent()
.glassBackgroundEffect()
.breakthroughEffect(.prominent)
}

### RealityView Attachments

Similarly, a `RealityView``Attachment` can break through other entities in the RealityView, including the entity it is attached to:

Attachment(id: "example") {
AttachmentContent()
.breakthroughEffect(.subtle)
}

### Presentations

Most system presentations appear with a breakthrough effect by default. For these cases, you can customize the type of effect by applying the `presentationBreakthroughEffect(_:)` modifier to the content of the presentation, like in the following example:

Button("Show Details") {
isShowingDetails = true
}
.popover(isPresented: $isShowingDetails) {
DetailsView()
.presentationBreakthroughEffect(.prominent)
}

This also applies to RealityKit presentations using `RealityKit/PresentationComponent`

---

# https://developer.apple.com/documentation/swiftui/view/buttonsizing(_:)

#app-main)

- SwiftUI
- View
- buttonSizing(\_:)

Instance Method

# buttonSizing(\_:)

The preferred sizing behavior of buttons in the view hierarchy.

nonisolated

## Parameters

`sizing`

A button sizing behavior that may be used to influence the primary axis size of buttons capable of adapting to it.

## Discussion

Views may use the specified button sizing when determining the size they choose to be in their primary axis within their parent view’s proposed size.

Many built-in controls that display as a button adapt to this view modifier. For example, you can make certain styles of `Button`, `Picker`, `ControlGroup`, and `Toggle` flexible by applying this modifier to them or their container.

This example creates a button that spans the width of its container, which you may want to do if the button is placed in a narrow context, like the sidebar of a welcome window.

Button("Open Document…", action: openDocument)
.buttonSizing(.flexible)

Your own views and styles can adapt to this view modifier by reading the `buttonSizing` environment value and applying an appropriate frame.

struct CustomButtonStyle: ButtonStyle {
@Environment(\.buttonSizing) private var buttonSizing

private var maxWidth: CGFloat {
switch buttonSizing {
case .flexible: .infinity
case .fitted, _: nil
}
}

configuration.content
.frame(maxWidth: maxWidth)
.background(.tint, in: Capsule())
}
}

---

# https://developer.apple.com/documentation/swiftui/view/certificatesheet(trust:title:message:help:)



---

# https://developer.apple.com/documentation/swiftui/view/chart3dcameraprojection(_:)

#app-main)

- SwiftUI
- View
- chart3DCameraProjection(\_:)

Instance Method

# chart3DCameraProjection(\_:)

nonisolated

---

# https://developer.apple.com/documentation/swiftui/view/chart3dpose(_:)

#app-main)

- SwiftUI
- View
- chart3DPose(\_:)

Instance Method

# chart3DPose(\_:)

Associates a binding to be updated when the 3D chart’s pose is changed by an interaction.

@MainActor @preconcurrency

Show all declarations

## Parameters

`pose`

The 3D chart’s current pose.

---

# https://developer.apple.com/documentation/swiftui/view/chart3drenderingstyle(_:)

#app-main)

- SwiftUI
- View
- chart3DRenderingStyle(\_:)

Instance Method

# chart3DRenderingStyle(\_:)

@MainActor @preconcurrency

---

# https://developer.apple.com/documentation/swiftui/view/chartzaxis(_:)

#app-main)

- SwiftUI
- View
- chartZAxis(\_:)

Instance Method

# chartZAxis(\_:)

Sets the visibility of the z axis.

nonisolated

---

# https://developer.apple.com/documentation/swiftui/view/chartzaxis(content:)

#app-main)

- SwiftUI
- View
- chartZAxis(content:)

Instance Method

# chartZAxis(content:)

Configures the z-axis for 3D charts in the view.

nonisolated

## Parameters

`content`

The axis content.

## Discussion

Use this modifier to customize the z-axis of a chart. Provide an `AxisMarks` builder that composes `AxisGridLine`, `AxisTick`, and `AxisValueLabel` structures to form the axis. Omit components from the builder to omit them from the resulting axis. For example, the following code adds grid lines to the z-axis:

.chartZAxis {
AxisMarks {
AxisGridLine()
}
}

Use arguments such as `position:` or `values:` to control the placement of the axis values it displays.

---

# https://developer.apple.com/documentation/swiftui/view/chartzaxislabel(_:position:alignment:spacing:)

#app-main)

- SwiftUI
- View
- chartZAxisLabel(\_:position:alignment:spacing:)

Instance Method

# chartZAxisLabel(\_:position:alignment:spacing:)

Adds z axis label for charts in the view. It effects 3D charts only.

nonisolated
func chartZAxisLabel(
_ label: some StringProtocol,
position: AnnotationPosition = .automatic,
alignment: Alignment? = nil,
spacing: CGFloat? = nil

Show all declarations

## Parameters

`label`

The label string.

`position`

The position of the label.

`alignment`

The alignment of the label.

`spacing`

The spacing of the label from the axis markers.

---

# https://developer.apple.com/documentation/swiftui/view/chartzscale(domain:range:type:)

#app-main)

- SwiftUI
- View
- chartZScale(domain:range:type:)

Instance Method

# chartZScale(domain:range:type:)

Configures the z scale for 3D charts.

nonisolated

domain: Domain,
range: Range,
type: ScaleType? = nil

## Parameters

`domain`

The possible data values along the z axis in the chart. You can define the domain with a `ClosedRange` for numeric values.

`range`

The range of x positions that correspond to the scale domain. By default the range is determined by the dimension of the plot area.

`type`

The scale type.

---

# https://developer.apple.com/documentation/swiftui/view/chartzscale(domain:type:)

#app-main)

- SwiftUI
- View
- chartZScale(domain:type:)

Instance Method

# chartZScale(domain:type:)

Configures the z scale for 3D charts.

nonisolated

domain: Domain,
type: ScaleType? = nil

## Parameters

`domain`

The possible data values along the z axis in the chart. You can define the domain with a `ClosedRange` for numeric values (e.g., `0 ... 500`).

`type`

The scale type.

---

# https://developer.apple.com/documentation/swiftui/view/chartzscale(range:type:)



---

# https://developer.apple.com/documentation/swiftui/view/chartzselection(range:)



---

# https://developer.apple.com/documentation/swiftui/view/chartzselection(value:)

#app-main)

- SwiftUI
- View
- chartZSelection(value:)

Instance Method

# chartZSelection(value:)

nonisolated

---

# https://developer.apple.com/documentation/swiftui/view/contactaccessbuttoncaption(_:)

#app-main)

- SwiftUI
- View
- contactAccessButtonCaption(\_:)

Instance Method

# contactAccessButtonCaption(\_:)

@MainActor @preconcurrency

## See Also

### Managing contact access

Modally present UI which allows the user to select which contacts your app has access to.

---

# https://developer.apple.com/documentation/swiftui/view/contactaccessbuttonstyle(_:)



---

# https://developer.apple.com/documentation/swiftui/view/containercorneroffset(_:sizetofit:)



---

# https://developer.apple.com/documentation/swiftui/view/containervalue(_:_:)



---

# https://developer.apple.com/documentation/swiftui/view/contentcaptureprotected(_:)



---

# https://developer.apple.com/documentation/swiftui/view/contenttoolbar(for:content:)



---

# https://developer.apple.com/documentation/swiftui/view/continuitydevicepicker(ispresented:ondidconnect:)



---

# https://developer.apple.com/documentation/swiftui/view/controlwidgetactionhint(_:)



---

# https://developer.apple.com/documentation/swiftui/view/controlwidgetstatus(_:)

#app-main)

- SwiftUI
- View
- controlWidgetStatus(\_:)

Instance Method

# controlWidgetStatus(\_:)

The status of the control described by the modified label.

@MainActor @preconcurrency

Show all declarations

## Parameters

`status`

The localized string resource to display.

## Discussion

This text appears in Control Center when your control’s state changes. You can customize the text by applying this modifier to the control’s value label:

// Status Text: "Do Not Disturb Until This Evening" / "Do Not Disturb Disabled"
ControlWidgetToggle("Do Not Disturb", ...) { isOn in
Image(systemName: "moon")
.controlWidgetStatus(isOn ? "Do Not Disturb Until This Evening" : "Do Not Disturb Disabled")
}

## See Also

### Composing control widgets

`protocol ControlWidget`

The configuration and content of a control widget to display in system spaces such as Control Center, the Lock Screen, and the Action Button.

`protocol ControlWidgetConfiguration`

A type that describes a control widget’s content.

`struct EmptyControlWidgetConfiguration`

An empty control widget configuration.

`struct ControlWidgetConfigurationBuilder`

A custom attribute that constructs a control widget’s body.

`protocol ControlWidgetTemplate`

`struct EmptyControlWidgetTemplate`

An empty control widget template.

`struct ControlWidgetTemplateBuilder`

A custom attribute that constructs a control widget template’s body.

`func controlWidgetActionHint(_:)`

The action hint of the control described by the modified label.

---

# https://developer.apple.com/documentation/swiftui/view/currententitlementtask(for:priority:action:)

#app-main)

- SwiftUI
- View
- currentEntitlementTask(for:priority:action:)

Instance Method

# currentEntitlementTask(for:priority:action:)

Declares the view as dependent on the entitlement of an In-App Purchase product, and returns a modified view.

StoreKitSwiftUI

nonisolated
func currentEntitlementTask(
for productID: String,
priority: TaskPriority = .medium,

## Parameters

`productID`

The product ID to get the entitlement for. The task restarts whenever this parameter changes.

`priority`

The task priority to use when creating the task.

`action`

The action to perform when the task’s state changes.

## Discussion

Before a view modified with this method appears, a task will start in the background to get the current entitlement. While the view is presented, the task will call `action` whenever the entitlement changes or the task’s state changes.

Consumable in-app purchases will always pass `nil` to `action`. For auto-renewable subscriptions, use `subscriptionStatusTask(for:priority:action:)` to get the full status information for the subscription.

## See Also

### Interacting with the App Store and Apple Music

Presents a StoreKit overlay when a given condition is true.

Display the refund request sheet for the given transaction.

Presents a sheet that enables customers to redeem offer codes that you configure in App Store Connect.

Initiates the process of presenting a sheet with subscription offers for Apple Music when the `isPresented` binding is `true`.

Add a function to call before initiating a purchase from StoreKit view within this view, providing a set of options for the purchase.

Add an action to perform when a purchase initiated from a StoreKit view within this view completes.

Add an action to perform when a user triggers the purchase button on a StoreKit view within this view.

Adds a standard border to an in-app purchase product’s icon .

Sets the style for In-App Purchase product views within a view.

Configure the visibility of labels displaying an in-app purchase product description within the view.

Specifies the visibility of auxiliary buttons that store view and subscription store view instances may use.

Declares the view as dependent on an In-App Purchase product and returns a modified view.

Declares the view as dependent on a collection of In-App Purchase products and returns a modified view.

---

# https://developer.apple.com/documentation/swiftui/view/dialogpreventsapptermination(_:)

#app-main)

- SwiftUI
- View
- dialogPreventsAppTermination(\_:)

Instance Method

# dialogPreventsAppTermination(\_:)

Whether the alert or confirmation dialog prevents the app from being quit/terminated by the system or app termination menu item.

nonisolated

## Discussion

SwiftUI uses the actions passed to the above dialogs to determine whether the dialog should block app termination by default when presented. If all of the following are satisfied, the dialog will not block app quit:

- There is only a single button and its role is not `destructive`

- The `dialogSeverity(_:)` is not \`DialogSeverity/critical\`\`

- There are no `TextField` s

Use this modifier after a `View/alert` or `View/confirmationDialog` to specify whether the dialog should prevent app termination. Pass `nil` to explicitly request the automatic behavior/for the inert version of this modifier.

struct ConfirmLogoutView: View {
@State private var isConfirming = false

var body: some View {
Button("Logout") { isConfirming = true }
.confirmationDialog(
Text("Logout?"),
isPresented: $isConfirming
) {
Button("Yes") {
// Handle logout action.
}
}
.dialogPreventsAppTermination(false)
}
}

---

# https://developer.apple.com/documentation/swiftui/view/dragconfiguration(_:)

#app-main)

- SwiftUI
- View
- dragConfiguration(\_:)

Instance Method

# dragConfiguration(\_:)

Configures a drag session.

nonisolated

## Parameters

`configuration`

A value that describes the configuration of a drag session.

## Return Value

A view that configures a drag session in a way, described by the `configuration` parameter.

## Discussion

Below is a simplified example of a view that supports copy, move and delete operations for drag.

### Drag to delete into trash bin

If a view wants to support drag-to-delete into the trash bin or another location that has similar semantics, it should specify the support for this operation in a drag configuration:

@State private var photos: [Photo] = []
@State private var selectedPhotos: [Photo.ID] = []

var body: some View {
ScrollView {
LazyVGrid(columns: gridColumns) {
ForEach(photos) { photo in
PhotoView(photo: photo)
.draggable(containerItemID: photo.id)
}
}
}
.dragContainer(for: Photo.self) { draggedIDs in
photos(ids: draggedIDs)
}
.dragContainerSelection(selectedPhotos)
.dragConfiguration(DragConfiguration(allowMove: false, allowDelete: true))
.onDragSessionUpdated { session in
if session.phase == .ended(.delete) {
let ids = session.draggedItemIDs(for: Photo.ID.self)
removeAndTrash(ids)
}
}
.dragPreviewsFormation(.stack)
}

func removeAndTrash(_ ids: [Photo.ID]) {
ids.forEach { id
if let idx = photos.firstIndex(where: { $0.id == id }) {
let photo = photos[idx]
photos.remove(at: idx)
try? FileManager.default.trashItem(
at: photo.fileURL, resultingItemURL: nil
)
}
}
}
}

Note, that any drag supports copy operation by default. In the snippet above, the view supports both copy and delete operations.

---

# https://developer.apple.com/documentation/swiftui/view/dragcontainer(for:in:_:)

#app-main)

- SwiftUI
- View
- dragContainer(for:in:\_:)

Instance Method

# dragContainer(for:in:\_:)

A container with draggable views where the drag payload is based on multiple identifiers of dragged items.

nonisolated

for itemType: Item.Type = Item.self,
in namespace: Namespace.ID? = nil,

Show all declarations

## Parameters

`itemType`

A type of the dragged items.

`namespace`

A namespace that identifies the drag container.

`payload`

A closure which is called when a drag operation begins. As an argument, the closure receives either the identifiers of all the selected items, if the dragged item is a part of selection or only the identifier of the dragged item, if it is not part of the selection. With the passed identifiers, put together the payload to drag, and return from the closure. Return an empty `Collection` to disable the drag.

## Return Value

A view that can be activated as the source of a drag and drop operation, beginning with user gesture input.

## Discussion

Provide the selected identifiers list to SwiftUI using `dragContainerSelection(_:containerNamespace)` modifier. In a case when there’s no selection information available, SwiftUI passes the dragged item identifier to the `payload` closure.

In an example below, an app presents a view with `Fruit` values. When a user starts drag, SwiftUI uses the selection to put together the list of item identifiers to drag.

var fruits: [Fruit]
@State private var selection: [Fruit.ID]

var body: some View {
VStack {
ForEach(fruits) { fruit in
FruitView(fruit)
.draggable(containerItemID: fruit.id)
}
}
.dragContainer(for: Fruit.self) { ids in
fruits(with: ids)
}
.dragContainerSelection(selection)
}

struct Fruit: Transferable, Identifiable { ... }

---

# https://developer.apple.com/documentation/swiftui/view/dragcontainer(for:itemid:in:_:)

#app-main)

- SwiftUI
- View
- dragContainer(for:itemID:in:\_:)

Instance Method

# dragContainer(for:itemID:in:\_:)

A container with draggable views.

nonisolated

for itemType: Item.Type = Item.self,

in namespace: Namespace.ID? = nil,

Show all declarations

## Parameters

`itemType`

A type of the dragged items.

`itemID`

A closure that provides an item’s identifier.

`namespace`

A namespace that identifies the drag container.

`payload`

A closure which is called when a drag operation begins. As an argument, the closure receives either the identifiers of all the selected items, if the dragged item is a part of selection or only the identifier of the dragged item, if it is not part of the selection. Using the passed identifiers, put together the payload to drag, and return from the closure. Return an empty `Collection` to disable the drag.

## Return Value

A view that can be activated as the source of a drag and drop operation, beginning with user gesture input.

## Discussion

In an example below, an app presents a view with `Fruit` values. `Fruit` does not conform to `Identifiable` but uses its name as its identifier.

@State private var fruits: [Fruit]
@State private var selection: [String]

var body: some View {
VStack {
ForEach(fruits) { fruit in
FruitView(fruit)
.draggable(containerItemID: fruit.name)
}
}
.dragContainer(itemID: \Fruit.name) { ids in
fruits(with: ids)
}
}

struct Fruit: Transferable {
var name: String
...
}

---

# https://developer.apple.com/documentation/swiftui/view/dragcontainerselection(_:containernamespace:)

#app-main)

- SwiftUI
- View
- dragContainerSelection(\_:containerNamespace:)

Instance Method

# dragContainerSelection(\_:containerNamespace:)

Provides multiple item selection support for drag containers.

nonisolated

containerNamespace: Namespace.ID? = nil

## Parameters

`selection`

A closure that provides identifiers of selected items.

`containerNamespace`

An optional namespace of the drag container.

## Discussion

A drag container finds the nearest enclosing `dragContainerSelection(_:containerNamespace:)` with the same item identifier type and same namespace, if specified. Drag container uses the provided selected item identifiers to determine what the drag payload should be.

If the dragged view is associated with a selected identifier, the payload should contain all the selected items. If the dragged view is not selected, the payload should not contain the whole selection, just the dragged item. With `dragContainerSelection(_:containerNamespace:)`, you get fine-grained control over what items are included in the drag payload.

struct FruitContainer: View {
@State private var fruits: [Fruit]
@State private var selection: [Fruit.ID]

var body: some View {
VStack {
ForEach(fruits) { fruit in
FruitView(fruit)
.draggable(containerItemID: fruit.id)
}
}
.dragContainer(for: Fruit.self) { ids in
fruits(with: ids)
}
.dragContainerSelection(selection)
}

struct Fruit: Transferable, Identifiable {
let id: String
...
}

struct FruitView: View {
init(_ fruit: Fruit) { ... }
}
}

---

# https://developer.apple.com/documentation/swiftui/view/dragpreviewsformation(_:)

#app-main)

- SwiftUI
- View
- dragPreviewsFormation(\_:)

Instance Method

# dragPreviewsFormation(\_:)

Describes the way dragged previews are visually composed.

nonisolated

---

