import 'package:axolon_container/model/connection_setting_model.dart';
import 'package:axolon_container/services/db_helper/db_helper.dart';
import 'package:get/get.dart';

class LocalSettingsController extends GetxController {
  final connectionSettings = [].obs;

  Future<void> getLocalSettings() async {
    print('enteringggg');
    final List<Map<String, dynamic>> elements =
        await DbHelper().queryAllSettings();
    connectionSettings.assignAll(
        elements.map((data) => ConnectionModel.fromMap(data)).toList());
  }

  addLocalSettings({required ConnectionModel element}) async {
    print('adding');
    await DbHelper().insertSettings(element);
    connectionSettings.add(element);
    // getTransferOut();
  }

  deleteTable() async {
    await DbHelper().deleteSettingsTable();
  }
}
