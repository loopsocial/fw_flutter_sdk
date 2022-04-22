# fw_flutter_sdk

Firework Flutter SDK

## Installation

```sh
flutter pub add fw_flutter_sdk
```

## Usage

### SDK Initialization

```dart
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

/// Optional: set listener for SDK init
FireworkSDK.getInstance().onSDKInit = (event) {
    
};

/// It is recommended to call the init method when the application starts, 
/// e.g. in the initState method of your AppState. Init method has two optional params: 
/// userId and adConfig. 
FireworkSDK.getInstance().init();
```

### Video Feed Integration

```dart
import 'package:fw_flutter_sdk/fw_flutter_sdk.dart';

VideoFeed(
  height: 200,
  source: VideoFeedSource.discover,
);
```
