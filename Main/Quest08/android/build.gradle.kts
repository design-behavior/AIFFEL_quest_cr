import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

// ✅ ✅ ✅ ✔️ ✔️ ✔️
// ✔️ buildscript 로 버전 관리
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.3.15")
    }
}

plugins {
    //id("com.google.gms.google-services") version "4.3.15" apply false
    // ✔️ plugins { } 에는 version 쓰지 않음!
    id("com.google.gms.google-services") apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://www.jitpack.io") }
        maven { url = uri("https://dl.cloudsmith.io/public/arthenica/ffmpeg-kit/maven/") } // ✅ 필수
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

