import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_test_app/notifications.dart';

class TaskName {
  static const SEND_NOTIFICATION = "send_notification";
  static const PERIODIC_TASK = "periodic_task";
  static const LOCATION = "location";
}

void callbackDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    switch (taskName) {
      case TaskName.SEND_NOTIFICATION:
        print('Dupaaaa 1222');
        await sendNotification('Send notify task');
        return true;
        break;
      case TaskName.PERIODIC_TASK:
        print('Periodic heerereee');
        await sendNotification('Period');
        return true;
      case TaskName.LOCATION:
        print('Location hrere');
        await notifyLocation();
        return true;
      default:
    }

    return false;
  });
}

void setUpWorkManager() {
  Workmanager.initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
}

Future notifyLocation() async {
  var isEnabled = await Geolocator.isLocationServiceEnabled();
  if(!isEnabled){
    sendNotification('Location not enabled!');
    return;
  }
  if(await Geolocator.checkPermission() != LocationPermission.always){
    sendNotification("No permission to run always!");
    return;
  }

  sendNotification("Your location: ${await Geolocator.getCurrentPosition()}");
}
