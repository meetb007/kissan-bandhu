import 'package:bloc/bloc.dart';
import 'package:frontend/Screens/Driver/components/my_orders.dart';
import 'package:frontend/Screens/Driver/components/profile.dart';
import 'package:frontend/Screens/Driver/components/track.dart';

enum NavigationEvents {
  //HomePageClickedEvent,
  ProfileClickedEvent,
  MyOrdersClickedEvent,
  TrackOrderClickedEvent,
  //LogoutClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => Profile();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      // case NavigationEvents.HomePageClickedEvent:
      //   yield Sell();
      //   break;
      case NavigationEvents.ProfileClickedEvent:
        yield Profile();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrders();
        break;
      case NavigationEvents.TrackOrderClickedEvent:
        yield Track();
        break;
      // case NavigationEvents.LogoutClickedEvent:
      //   yield Logout();
      //   break;
    }
  }
}
