import 'dart:convert';

import 'package:happy_tech_mastering_api_with_flutter/cache/cahce_helper.dart';
import 'package:happy_tech_mastering_api_with_flutter/cleanArcitecture/Features/user/data/models/user_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/cleanArcitecture/errors/exceptions.dart';

class UserLocalDataSource {
  final CacheHelper cache;
  final String lastUserKey =
      "CachedUser"; // كيي بستعمله لتحديد موقع تخزين بيانات المستخدم داخل الكاش

  UserLocalDataSource({required this.cache});
  // ياما هخزن فالكاش ياما هجيب اخر حاجه عندنا فالكاش
  cachUser(UserModel? userToCach) {
    if (userToCach != null) {
      cache.saveData(
        key: lastUserKey,
        value: json.encode(
          userToCach.toJson(),
        ),
      );
      // الكيي الهخزن بيه اليوزر بتاعي 'CachedUser'
      // الفاليو مينفعش يكون مودل فبتالي هحتاج احولها لصورة اقدر اقدر اخزنها عندي فالشيرد
      // ف اولا هحولو جسون ومن جسون هعملو اينكود لسترنج لان التخزين بيكون بشكل سترنج
      // وبعدين وانا بجيب اليوزر بحولو من سترنج ل مودل تاني
    } else {
      throw CacheException(errorMessage: 'No InterNet Conncetion');
    }
  }
// الميثود بختصار باخد بيانات اليوزر الجايه من النت بخزنها بكيي وفاليو والفاليو معمولها انكود علشان تتخزن كسترنج

  Future<UserModel> getLastUser() {
    //يتم تحويل JSON إلى كائن UserModel باستخدام الدالة UserModel.fromJson().

    final String? jsonString = cache.getData(key: lastUserKey);

    if (jsonString != null) {
      return Future.value(
        UserModel.fromJson(
          jsonDecode(jsonString),
          //Future.value تُستخدم لإنشاء كائن Future يُعيد قيمة جاهزة على الفور (بمعنى أنها لا تحتاج إلى انتظار عمليات غير متزامنة مثل طلبات الشبكة أو الاستعلامات من قاعدة البيانات).
        ),
      );
    } else {
      throw CacheException(errorMessage: 'No InterNet Conncetion');
    }
  }
}
