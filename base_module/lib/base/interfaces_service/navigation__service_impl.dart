abstract class INavigationService {
  void navigateTo(String routeName, {dynamic arguments});

  void backToPreviousScreen({dynamic result});

  void navigateAndClearStack(String routeName, {dynamic arguments});
}
