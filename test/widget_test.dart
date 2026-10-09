import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('muestra los alumnos registrados', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lista de alumnos'), findsOneWidget);
    expect(find.text('Ana García López'), findsOneWidget);
    expect(find.text('Cuenta: 2024001'), findsOneWidget);
    expect(find.text('4 alumnos registrados'), findsOneWidget);
  });

  testWidgets('registra un alumno desde el formulario', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Agregar alumno'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('studentNombreField')),
      'Lucía',
    );
    await tester.enterText(
      find.byKey(const ValueKey('studentApellidoField')),
      'Pérez Mora',
    );
    await tester.enterText(
      find.byKey(const ValueKey('studentNúmerodecuentaField')),
      '2024010',
    );
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('saveStudentButton')));
    await tester.tap(find.byKey(const ValueKey('saveStudentButton')));
    await tester.pumpAndSettle();

    expect(find.text('5 alumnos registrados'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();
    expect(find.text('Lucía Pérez Mora'), findsOneWidget);
    expect(find.text('Cuenta: 2024010'), findsOneWidget);
  });

  testWidgets('no permite registrar una cuenta duplicada', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Agregar alumno'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('studentNombreField')),
      'Otro',
    );
    await tester.enterText(
      find.byKey(const ValueKey('studentApellidoField')),
      'Alumno',
    );
    await tester.enterText(
      find.byKey(const ValueKey('studentNúmerodecuentaField')),
      '2024001',
    );
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('saveStudentButton')));
    await tester.tap(find.byKey(const ValueKey('saveStudentButton')));
    await tester.pumpAndSettle();

    expect(find.text('Esta cuenta ya está registrada'), findsOneWidget);
    expect(find.text('5 alumnos registrados'), findsNothing);
  });
}
