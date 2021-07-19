import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/data/datasources/shared_prefs.dart';
import 'package:webant_test_app/presentation/blocs/home_page_bloc/home_page_event.dart';
import 'package:webant_test_app/presentation/blocs/home_page_bloc/home_page_state.dart';

import '../../../injection.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(WelcomeScreenState());

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is CheckIfTheUserIsAuthorized) {
      String? token = await getAccessToken();
      if(token != null){
        yield MainScreenState();
      }else{
        yield WelcomeScreenState();
      }
    }
  }

  Future<String?> getAccessToken() async {
    SharedPrefs _prefs = injection<SharedPrefs>();
    String? _accessToken = await _prefs.read('access_token');
    return _accessToken;
  }
}
