// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart'; // Make sure to update the import path to match your project structure

void main() {
  testWidgets('Welcome Page has a Get Started button',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BankPredictionApp());

    // Verify that the Welcome Page has a Get Started button.
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Navigating to Data Entry Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BankPredictionApp());

    // Tap the Get Started button.
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Data Entry Page.
    expect(find.text('Enter Client Information'), findsOneWidget);
  });

  testWidgets('Data Entry Page has a Submit button',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BankPredictionApp());

    // Tap the Get Started button to navigate to the Data Entry Page.
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify that the Data Entry Page has a Submit button.
    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('Submitting data navigates to Result Page',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BankPredictionApp());

    // Tap the Get Started button to navigate to the Data Entry Page.
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Fill in the form fields (using only one as an example here, you should fill in all required fields).
    await tester.enterText(find.byType(TextFormField).first, '25'); // Age field

    // Select a value from the dropdown (example for the Job field).
    await tester.tap(find.byType(DropdownButtonFormField).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Admin').last);
    await tester.pumpAndSettle();

    // Tap the Submit button.
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Result Page.
    expect(find.text('Prediction Result'), findsOneWidget);
  });

  testWidgets('Result Page has a Back button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BankPredictionApp());

    // Navigate to the Data Entry Page.
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Fill in the form fields (using only one as an example here, you should fill in all required fields).
    await tester.enterText(find.byType(TextFormField).first, '25'); // Age field

    // Select a value from the dropdown (example for the Job field).
    await tester.tap(find.byType(DropdownButtonFormField).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Admin').last);
    await tester.pumpAndSettle();

    // Tap the Submit button.
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Verify that the Result Page has a Back button.
    expect(find.text('Back'), findsOneWidget);
  });

  testWidgets('Navigating back to Data Entry Page from Result Page',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BankPredictionApp());

    // Navigate to the Data Entry Page.
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Fill in the form fields (using only one as an example here, you should fill in all required fields).
    await tester.enterText(find.byType(TextFormField).first, '25'); // Age field

    // Select a value from the dropdown (example for the Job field).
    await tester.tap(find.byType(DropdownButtonFormField).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Admin').last);
    await tester.pumpAndSettle();

    // Tap the Submit button.
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Tap the Back button.
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    // Verify that we navigated back to the Data Entry Page.
    expect(find.text('Enter Client Information'), findsOneWidget);
  });
}

BankPredictionApp() {}
