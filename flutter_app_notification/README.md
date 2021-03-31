# flutter_app_notification

A new Flutter application.

## Getting Started


##Step 1
### AndroidManifest.xml
Add Permission
 <uses-permission android:name="android.permission.VIBRATE" />
 <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    
Add the following meta-data schema within the application component:
<meta-data
  android:name="com.google.firebase.messaging.default_notification_channel_id"
  android:value="high_importance_channel" />

##Step 2
Add Icon into "android/app/src/main/res/drawable/icon_launcher.png"

##Step 3
In the App Level Gradle
apply plugin: 'com.google.gms.google-services'
dependencies {
    ...
    implementation 'com.google.firebase:firebase-analytics-ktx'
}

In the Project Level Gradle
dependencies {
        classpath 'com.google.gms:google-services:4.3.5'
        ...
    }
