import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mechaku_blocs/cubit/product_best_seller_cubit.dart';
import 'package:mechaku_blocs/cubit/product_cubit.dart';
import 'package:mechaku_blocs/cubit/product_new_arrival_cubit.dart';
import 'package:mechaku_blocs/cubit/top_up_cubit.dart';

import '/shared/theme.dart';
import '/routes/AppPages.dart';
import '/routes/AppRoutes.dart';
import '/cubit/auth_cubit.dart';
import '/cubit/page_cubit.dart';
import '/cubit/category_cubit.dart';

Future<void> main() async {
  _changeStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: blackColor1,
      ),
    );
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _changeStatusBarColor();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => PageCubit()),
        BlocProvider(create: (_) => TopUpCubit(0, false)),
        BlocProvider(create: (_) => ProductCubit()),
        BlocProvider(create: (_) => CategoryCubit()),
        BlocProvider(create: (_) => ProductBestSellerCubit()),
        BlocProvider(create: (_) => ProductNewArrivalCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppPages().pages,
        initialRoute: AppRoutes.splash_page,
      ),
    );
  }
}
