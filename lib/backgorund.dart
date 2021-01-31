import 'package:background_fetch/background_fetch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_test_app/notifications.dart';

class TaskName {
  static const SEND_NOTIFICATION = "send_notification";
  static const PERIODIC_TASK = "periodic_task";
  static const LOCATION = "location";
}

Future<bool> callbackDispatcher(String taskName) async {
  switch (taskName) {
    case TaskName.SEND_NOTIFICATION:
      print('Dupaaaa 1222');
      await sendNotification('Send notify task');
      break;
    case TaskName.PERIODIC_TASK:
      print('Periodic heerereee');
      await sendNotification('Period');
      break;
    case TaskName.LOCATION:
      print('Location hrere');
      await notifyLocation();
      break;
    default:
  }

  BackgroundFetch.finish(taskName);
}

void setUpWorkManager() {
  BackgroundFetch.configure(
    BackgroundFetchConfig(
      minimumFetchInterval: 15,
    ),
    callbackDispatcher,
  );
}

Future notifyLocation() async {
  var isEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isEnabled) {
    sendNotification('Location not enabled!');
    return;
  }
  if (await Geolocator.checkPermission() != LocationPermission.always) {
    sendNotification("No permission to run always!");
    return;
  }

  sendNotification("Your location: ${await Geolocator.getCurrentPosition()}");
}
