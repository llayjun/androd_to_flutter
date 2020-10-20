package com.example.milletandroid

import android.os.Bundle
import com.example.milletandroid.plugin.FlutterNativeImageChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        FlutterNativeImageChannel.registerWith(this.flutterEngine)
        // 使用withNewEngine方式，弊端是跳转的时候需要初始化flutter，所以会有黑屏
        tv_click_with_new_engine.setOnClickListener {
            startActivity(FlutterActivity.withNewEngine().initialRoute("/home").build(this))
        }
        // 使用FlutterEngine方式，在MyApplication中进行FlutterEngine的初始化
        tv_click_engine.setOnClickListener {
            startActivity(FlutterActivity.withCachedEngine("my_engine_id").build(this))
        }
    }

}