plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // ✅ 정식 ID
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("com.google.gms.google-services") // Firebase 추가
    id("dev.flutter.flutter-gradle-plugin")

}

android {
    namespace = "com.kickingthon.kicksense"
    compileSdk = flutter.compileSdkVersion
    // ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.kickingthon.kicksense"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        manifestPlaceholders += mapOf(
            "applicationName" to "io.flutter.app.FlutterApplication" // 또는 다른 Application 클래스 이름
        )
        minSdk = 23
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // ✅ Proguard & Shrink Resources — false면 둘 다 false
            isMinifyEnabled = false // 🔴 false일 경우, shrinkResources도 false여야 함
            isShrinkResources = false // ✅ 이 줄을 추가하거나, true면 같이 true로
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            // ✅ Debug 서명 키 — 개발 단계에서는 디버그 키 사용
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.9.0")

    // ✅ Firebase 관련 의존성
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-analytics-ktx")
    implementation("com.google.firebase:firebase-auth-ktx")
    implementation("com.google.firebase:firebase-firestore-ktx")
    implementation("com.google.firebase:firebase-storage-ktx")

    // ✅ Firebase App Check (Play Integrity)
    implementation("com.google.firebase:firebase-appcheck-playintegrity")
    implementation("com.google.firebase:firebase-appcheck-ktx")
    implementation("com.google.firebase:firebase-appcheck-debug:17.0.1")
}