part of 'pages.dart';

class SignUpPage extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _usernameController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  final TextEditingController _rePasswordController =
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
          'Create \nAccount',
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
              // Full Name
              CustomTextField(
                validator: requiredValidator,
                controller: _nameController,
                label: 'Full Name',
                hintText: 'Your Full Name',
                prefixIconUrl: 'assets/fullname_icon.png',
              ),

              // Username
              CustomTextField(
                validator: requiredValidator,
                controller: _usernameController,
                label: 'Username',
                hintText: 'Your Username',
                prefixIconUrl: 'assets/username_icon.png',
              ),

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
                isPassword: true,
                validator: passwordValidator,
                controller: _passwordController,
                label: 'Password',
                hintText: 'Your Password',
                prefixIconUrl: 'assets/password_icon.png',
              ),

              // Retype Password
              CustomTextField(
                validator: (val) {
                  return MatchValidator(errorText: 'Password must be same')
                      .validateMatch(val ?? '', _passwordController.text);
                },
                isPassword: true,
                controller: _rePasswordController,
                label: 'Retype Password',
                hintText: 'Your Password',
                prefixIconUrl: 'assets/password_icon.png',
              ),
            ],
          ),
        ),
      );
    }

    Widget _signUpButton() {
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
                  () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
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

          return CustomButton(
            text: 'Sign Up',
            onPressed: () {
              final isValid = _key.currentState!.validate();

              if (isValid) {
                _key.currentState!.save();

                context.read<AuthCubit>().signUp(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      username: _usernameController.text,
                    );
              }
            },
          );
        },
      );
    }

    Widget _signIn() {
      return Container(
        margin: EdgeInsets.only(top: 100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: regularTextStyle.copyWith(fontSize: 12),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Sign In',
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
                _signUpButton(),
                _signIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
