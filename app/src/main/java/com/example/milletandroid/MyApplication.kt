package com.example.milletandroid

import android.app.Application
import android.content.Context
import com.example.milletandroid.plugin.FlutterNativeImageChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MyApplication : Application() {

    lateinit var flutterEngine: FlutterEngine

   companion object {
       lateinit var context: Context
   }

    override fun onCreate() {
        super.onCreate()
        context = this

        // Instantiate a FlutterEngine.
        flutterEngine = FlutterEngine(this)

        flutterEngine.navigationChannel.setInitialRoute("/second")

        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine)

        // 注册获取图片
        FlutterNativeImageChannel.registerWith(this.flutterEngine)
    }

}