import 'package:get/get.dart';
import 'package:my_chat_app/core/servece_status.dart';
import 'package:my_chat_app/data/user_serveces.dart';
import 'package:my_chat_app/injection.dart';
import 'package:my_chat_app/models/search_user_models.dart';

class SearchUsersViewModel extends GetxController {
  final userService = inject.get<UserServeces>();

  List<SearchUserModel> _searchList = [];
  final RxString _email = ''.obs;

  List<SearchUserModel> get searchList => _searchList;
  String get email => _email.value;

  setEmailText(String value) {
    _email.value = value.trim();
  }

  setUserSearchList(List<SearchUserModel> value) {
    _searchList = value;
    update();
  }

  usersSearch(String email) async {
    var response = await userService.usersSearch(email: email);
    if (response is Success) {
      setUserSearchList(response.response as List<SearchUserModel>);
    }
  }

  @override
  void onInit() {
    super.onInit();
    debounce(
      _email,
      (_) => usersSearch(email),
    );
  }
}
