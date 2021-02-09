import 'package:bloc/bloc.dart';
import 'package:frontend/Screens/Buyer/components/buy.dart';
import 'package:frontend/Screens/Buyer/components/my_orders.dart';
import 'package:frontend/Screens/Buyer/components/profile.dart';
import 'package:frontend/Screens/Buyer/components/track.dart';
import 'package:frontend/Screens/Buyer/cart/cart_screen.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  ProfileClickedEvent,
  MyOrdersClickedEvent,
  TrackOrderClickedEvent,
  CartClickedEvent,
  //LogoutClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => Buy();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield Buy();
        break;
      case NavigationEvents.ProfileClickedEvent:
        yield Profile();
        break;
      case NavigationEvents.CartClickedEvent:
        yield CartScreen();
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
