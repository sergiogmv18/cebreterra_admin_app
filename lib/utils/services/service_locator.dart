import 'package:cebreterra/utils/services/session.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

/*
  * Register global instance of session and database
  * @author  SGV
  * @version 1.0 - 20230424 - initial release
  * @return  void
  */
Future<void> setupLocator() async {
  if (!serviceLocator.isRegistered<Session>()) {
    Session session = Session();
    serviceLocator.registerSingleton<Session>(session);
  }
  
}

/*
  * set data session
  * @author  SGV
  * @version 1.0 - 20230505 - initial release
  * @return  void
  */
Future startSession() async {
 
}