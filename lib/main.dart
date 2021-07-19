import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webant_test_app/data/models/image.dart';
import 'package:webant_test_app/data/models/user.dart';

import 'package:webant_test_app/data/repositories/image_repository_impl.dart';
import 'package:webant_test_app/data/repositories/send_image_repository_impl.dart';
import 'package:webant_test_app/data/repositories/user_repository_impl.dart';
import 'package:webant_test_app/presentation/blocs/home_page_bloc/home_page_bloc.dart';
import 'package:webant_test_app/presentation/blocs/home_page_bloc/home_page_event.dart';
import 'package:webant_test_app/presentation/blocs/home_page_bloc/home_page_state.dart';
import 'package:webant_test_app/presentation/blocs/load_image_bloc/load_image_bloc.dart';
import 'package:webant_test_app/presentation/blocs/load_popular_images_bloc/load_popular_images_bloc.dart';
import 'package:webant_test_app/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:webant_test_app/presentation/blocs/profile_setting_bloc/profile_setting_bloc.dart';
import 'package:webant_test_app/presentation/blocs/send_image_bloc/send_image_bloc.dart';
import 'package:webant_test_app/injection.dart';
import 'package:webant_test_app/presentation/screens/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webant_test_app/presentation/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setDI();
  EquatableConfig.stringify = kDebugMode;
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('user_data');
  Hive.registerAdapter(ImageModelAdapter());
  await Hive.openBox<ImageModel>('new_image_data');
  await Hive.openBox<ImageModel>('popular_image_data');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoadImageBloc(
                imageRepository: injection<ImageRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) => LoadPopularImageBloc(
                imageRepository: injection<ImageRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                ProfileBloc(userRepository: injection<UserRepositoryImpl>()),
          ),
          BlocProvider(
            create: (_) =>
                SendImageBloc(repository: injection<SendImageRepositoryImpl>()),
          ),
          BlocProvider(
              create: (_) => ProfileSettingsBloc(
                  repository: injection<UserRepositoryImpl>()))
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocProvider(
            create: (_) => HomePageBloc()..add(CheckIfTheUserIsAuthorized()),
            child: Builder(
              builder: (context) => BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  if (state is WelcomeScreenState) {
                    return WelcomeScreen();
                  }
                  if (state is MainScreenState) {
                    return MainScreen();
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
