import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../widgets/widgets.dart';
import '../../shared/theme.dart';
import '../../models/models.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/page_cubit.dart';
import '../../routes/AppRoutes.dart';
import '../../shared/validator.dart';
import '../../cubit/product_cubit.dart';
import '../../cubit/category_cubit.dart';
import '../../cubit/transaction_cubit.dart';
import '../../cubit/sold_product_cubit.dart';
import '../../extension/date_time_extension.dart';
import '../../cubit/product_best_seller_cubit.dart';
import '../../cubit/product_new_arrival_cubit.dart';

part 'cart_page.dart';
part 'main_page.dart';
part 'home_page.dart';
part 'chat_page.dart';
part 'search_page.dart';
part 'splash_page.dart';
part 'top_up_page.dart';
part 'wallet_page.dart';
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'category_page.dart';
part 'checkout_page.dart';
part 'settings_page.dart';
part 'wishlist_page.dart';
part 'product_detail_page.dart';
part 'success_top_up_page.dart';
part 'success_checkout_page.dart';
