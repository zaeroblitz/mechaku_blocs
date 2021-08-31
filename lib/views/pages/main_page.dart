part of 'pages.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Center(
              child: Text(state.user.name),
            );
          }

          return Center(
            child: Text('Main Page'),
          );
        },
      ),
    );
  }
}
