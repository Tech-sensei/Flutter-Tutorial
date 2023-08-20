import 'package:currency_converter/currency_converter_material_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // ignore: prefer_const_constructors
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CurrencyConverterMaterialPage(),
    );
  }
}


// A widget is a fundamental concept in the Flutter framework. In Flutter, everything you see on the screen is a widget. Widgets are the building blocks of the user interface (UI) in a Flutter app. They define the structure and appearance of your app's interface, ranging from simple elements like text and buttons to complex layouts and interactive components.

// Widgets in Flutter can be categorized into two main types:

// StatelessWidget:
// A widget that does not require mutable state.
// A StatelessWidget is a widget that does not change its properties or appearance once it's built.It's typically used for UI elements that don't have any internal state that can change, such as static text, images, icons, and simple buttons.

// StatefulWidget:
// A widget that maintains mutable state.
// A StatefulWidget is a widget that can change its properties or appearance over time, usually in response to user interactions or other events. It's used for UI elements that need to maintain some form of internal state, like checkboxes, text input fields, and animation components.

// The MyApp class extends StatelessWidget, which makes the app itself a widget. In Flutter, almost everything is a widget, including alignment, padding, and layout.

// The build() method returns a widget tree that describes the widgets that the app displays in its UI. The Flutter framework calls the build() method in two different contexts:

//Design system basics
// 1. Material Design
// 2. Cupertino (iOS-style) widgets

//Material Design is a design system created by Google. It's used to build beautiful, coherent user interfaces for apps on Android, iOS, and the web. Flutter includes a number of widgets that adhere to the Material Design system for layout, structure, and functionality. These widgets are located in the Flutter SDK, in the material library.

//Cupertino is an iOS-style design system created by Apple. It's used to build beautiful, coherent user interfaces for apps on iOS, macOS, and the web. Flutter includes a number of widgets that adhere to the Cupertino design system for layout, structure, and functionality. These widgets are located in the Flutter SDK, in the cupertino library.