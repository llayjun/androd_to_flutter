package com.example.milletandroid.plugin

import android.annotation.SuppressLint
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import androidx.annotation.NonNull
import com.example.milletandroid.MyApplication
import com.example.milletandroid.SecondActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream


class FlutterNativeImageChannel : FlutterPlugin, MethodChannel.MethodCallHandler {

    private val CHANNEL_ROUTER = "com.millet.flutter/native_image"

    private lateinit var channel: MethodChannel

    companion object {

        fun registerWith(flutterEngine: FlutterEngine?) {
            flutterEngine?.plugins?.add(FlutterNativeImageChannel())
        }

    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_ROUTER)
        channel.setMethodCallHandler(this)
    }

    @SuppressLint("WrongThread")
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getNativeImage" -> {
                val context = MyApplication.context
                val imageName = call.arguments as String
                val drawableId: Int = context.resources.getIdentifier(imageName, "mipmap", context.packageName)
                val bitmap: Bitmap = BitmapFactory.decodeResource(context.resources, drawableId)
                val bao = ByteArrayOutputStream()
                bitmap.compress(Bitmap.CompressFormat.PNG, 100, bao)
                val byteArray: ByteArray = bao.toByteArray()
                result.success(byteArray)
            }
            "toActivity" -> {
                val context = MyApplication.context
                val intent = Intent(context, SecondActivity::class.java)
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context.startActivity(intent)
                result.success("")
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

}