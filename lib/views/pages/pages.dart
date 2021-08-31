import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../widgets/widgets.dart';
import '../../shared/theme.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/page_cubit.dart';
import '../../routes/AppRoutes.dart';
import '../../shared/validator.dart';

part 'main_page.dart';
part 'home_page.dart';
part 'chat_page.dart';
part 'splash_page.dart';
part 'wallet_page.dart';
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'settings_page.dart';
part 'wishlist_page.dart';