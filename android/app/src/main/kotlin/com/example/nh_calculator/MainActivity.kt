package com.example.nh_calculator

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.content.Intent
import io.flutter.plugin.common.ActivityLifecycleListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import android.net.Uri
import io.flutter.app.FlutterActivityDelegate
import io.flutter.app.FlutterActivityEvents

class MainActivity : FlutterActivity() {

  private var sharedText:String? = "henlo"

  override fun onCreate(savedInstanceState: Bundle?){
    super.onCreate(savedInstanceState)

    val intent = getIntent()
    val action:String? = intent.action
    val type:String? = intent.type

    if(Intent.ACTION_VIEW.equals(action)){
      sharedText = intent.getDataString()
      //  = URLDecoder.decode(value)
    }
    
    val methodCaller = object : MethodCallHandler{
      override fun onMethodCall(call:MethodCall , result:MethodChannel.Result) {
        if (call.method.contentEquals("getSharedText")) {
          result.success(sharedText);
        }
      }
    }

    MethodChannel(getFlutterEngine()?.getDartExecutor()?.getBinaryMessenger(), "app.channel.shared.data")
    .setMethodCallHandler(methodCaller)
  }
}