package com.bytemyth.qr_scanner

import android.content.ComponentName
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL,
        ).setMethodCallHandler { call, result ->
            if (call.method == "setIcon") {
                setLauncherIcon(call.arguments as? String ?: "anime")
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setLauncherIcon(style: String) {
        val business = style == "business"
        // Enable the target first so the launcher never loses every icon.
        if (business) {
            setAliasEnabled(BUSINESS_ALIAS, enabled = true, defaultEnabled = false)
            setAliasEnabled(ANIME_ALIAS, enabled = false, defaultEnabled = true)
        } else {
            setAliasEnabled(ANIME_ALIAS, enabled = true, defaultEnabled = true)
            setAliasEnabled(BUSINESS_ALIAS, enabled = false, defaultEnabled = false)
        }
    }

    private fun setAliasEnabled(
        alias: String,
        enabled: Boolean,
        defaultEnabled: Boolean,
    ) {
        val component = ComponentName(this, alias)
        val current = packageManager.getComponentEnabledSetting(component)
        val currentlyEnabled = when (current) {
            PackageManager.COMPONENT_ENABLED_STATE_ENABLED -> true
            PackageManager.COMPONENT_ENABLED_STATE_DISABLED -> false
            else -> defaultEnabled
        }
        if (currentlyEnabled == enabled) return
        packageManager.setComponentEnabledSetting(
            component,
            if (enabled) {
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED
            } else {
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED
            },
            PackageManager.DONT_KILL_APP,
        )
    }

    companion object {
        private const val CHANNEL = "com.bytemyth.qr_scanner/launcher_icon"
        private const val ANIME_ALIAS = "com.bytemyth.qr_scanner.MainActivityAnime"
        private const val BUSINESS_ALIAS = "com.bytemyth.qr_scanner.MainActivityBusiness"
    }
}
