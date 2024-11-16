library core;

export 'src/base/base.dart';
export 'src/environment/environment.dart';
export 'src/extensions/extensions.dart';
export 'src/helpers/helpers.dart';
export 'src/utils/utils.dart';

const serverDateFormat = "yyyy-MM-dd";
const serverTimeFormat = "HH:mm:ss";
const serverDateTimeFormat = "$serverDateFormat $serverTimeFormat";
const localDateFormat = "dd/MM/yyyy";
const localTimeFormat = "hh:mm a";
const localDateTimeFormat = "$localDateFormat $localTimeFormat";
