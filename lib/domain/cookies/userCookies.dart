import 'package:get_storage/get_storage.dart';

import 'package:universal_html/html.dart' as html;

//USER DATA - STORES USER DATA IN COOKIES AND LOADS IT WHEN TRIGGERED
class UserCookies {
  //NAMED CONSTRUCTOR
  UserCookies();

  GetStorage getStorage = GetStorage();

  //SETS USER INFO
  setUserInfo({required String email, required String role}) {
    getStorage.write('email', email);
    getStorage.write('role', role);
  }

  //GETS USER INFO
  Future getUserInfo() async {
    return UserCookiesModel(
        getStorage.read('email') ?? "", getStorage.read('role') ?? "");
  }




  void addCookie(String email, String role) {
    print("TESTING COOKIES START ${email} ${role}");

    final cookie = '$role-$email';
    html.document.cookie = cookie;
  }

  void deleteCookie() {
    const cookie = ';';
    html.document.cookie = cookie;
  }

  Future<UserCookiesModel> getCookie() async {
    print("TESTING COOKIES INIT RECIEVE ${html.document.cookie}");
    final cookies = html.document.cookie != null && html.document.cookie != '' ? html.document.cookie?.split('-') : '-'.split('-');
    print("TESTING COOKIES SPLIT ${cookies}");
   if(cookies!.length == 2){
     final role = cookies![0];
     final email = cookies![1];
     if (role != '') {
       return UserCookiesModel(email, role);
     }else{
       return UserCookiesModel('','');
     }
   }else{
     return UserCookiesModel('','');
   }
  }


}

//USER PREFS MODEL
class UserCookiesModel {
  String? email;
  String? role;

  UserCookiesModel(this.email, this.role);
}
