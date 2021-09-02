part of 'pages.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: pinkColor,
          ));
        } else if (state is AuthInitial) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.sign_in_page, (route) => false);
        }
      },
      builder: (context, state) => Center(
        child: GestureDetector(
          onTap: () {
            context.read<AuthCubit>().signOut();
          },
          child: Text(
            'Sign Out',
            style: titleTextStyle,
          ),
        ),
      ),
    );
  }
}
