import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:image_upload_app/ui/locator/locator.config.dart';

final GetIt locator = GetIt.instance;

@injectableInit
Future<void> setupLocator() async => await $initGetIt(locator);