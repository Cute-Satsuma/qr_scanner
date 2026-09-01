import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let channel = FlutterMethodChannel(
      name: "com.bytemyth.qr_scanner/launcher_icon",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    channel.setMethodCallHandler { call, result in
      guard call.method == "setIcon" else {
        result(FlutterMethodNotImplemented)
        return
      }
      let style = call.arguments as? String ?? "anime"
      let desired: String? = style == "business" ? "AppIconBusiness" : nil
      DispatchQueue.main.async {
        guard UIApplication.shared.supportsAlternateIcons else {
          result(nil)
          return
        }
        if UIApplication.shared.alternateIconName == desired {
          result(nil)
          return
        }
        UIApplication.shared.setAlternateIconName(desired) { error in
          if let error = error {
            result(
              FlutterError(
                code: "icon",
                message: error.localizedDescription,
                details: nil
              )
            )
          } else {
            result(nil)
          }
        }
      }
    }
  }
}
