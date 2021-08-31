part of 'pages.dart';

class SignInPage extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Container(
        width: 30,
        margin: EdgeInsets.only(bottom: 30),
        child: Image.asset(
          'assets/logo_min.png',
          width: 30,
        ),
      );
    }

    Widget _title() {
      return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Text(
          'Hey, \nLogin Now',
          style: titleTextStyle,
        ),
      );
    }

    Widget _form() {
      return Container(
        margin: EdgeInsets.only(bottom: 22),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email
              CustomTextField(
                validator: emailValidator,
                controller: _emailController,
                label: 'Email Address',
                hintText: 'Your Email Address',
                prefixIconUrl: 'assets/email_icon.png',
              ),

              // Password
              CustomTextField(
                validator: passwordValidator,
                isPassword: true,
                controller: _passwordController,
                label: 'Password',
                hintText: 'Your Password',
                prefixIconUrl: 'assets/password_icon.png',
              ),
            ],
          ),
        ),
      );
    }

    Widget _signInButton() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.mainpage, (route) => false);
          } else if (state is AuthFailed) {
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  'Something went wrong!',
                  state.error,
                  'Close',
                  () => Navigator.pop(context),
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return SpinKitWanderingCubes(
              size: 50,
              color: blackColor1,
              duration: Duration(seconds: 3),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  final isValid = _key.currentState!.validate();

                  if (isValid) {
                    _key.currentState!.save();

                    context.read<AuthCubit>().signIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                  }
                },
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 12),
                child: SignInButton(
                  Buttons.Google,
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  onPressed: () {
                    context.read<AuthCubit>().signInWithGoogle();
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    Widget _signUp() {
      return Container(
        margin: EdgeInsets.only(top: 100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: regularTextStyle.copyWith(fontSize: 12),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.sign_up_page);
              },
              child: Text(
                'Sign Up',
                style: orangeTextStyle.copyWith(
                  fontSize: 12,
                  color: orangeColor,
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _logo(),
                _title(),
                _form(),
                _signInButton(),
                _signUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
