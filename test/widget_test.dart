import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_detail_app/main.dart';
import 'package:user_detail_app/presentation/UI/bloc/app/app_bloc.dart';

void main() {
  testWidgets('starts on the login screen', (tester) async {
    await tester.pumpWidget(
      BlocProvider(create: (_) => AppBloc(), child: const MyApp()),
    );

    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
