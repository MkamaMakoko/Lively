FROM gitpod/workspace-full

USER gitpod

RUN sudo apt-get update -y
RUN sudo apt-get upgrade -y
RUN sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa


# Install Flutter
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.4-stable.tar.xz && \
    tar xf flutter_linux_3.19.4-stable.tar.xz -C /workspace && \
    rm flutter_linux_3.19.4-stable.tar.xz

# Add Flutter to PATH
ENV PATH="$PATH:/workspace/flutter/bin"

RUN flutter upgrade

# Install Android SDK
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip && \
    mkdir -p /workspace/android/cmdline-tools && \
    unzip commandlinetools-linux-11076708_latest.zip -d /workspace/android/cmdline-tools && \
    rm commandlinetools-linux-11076708_latest.zip

# Add Android SDK to PATH
# ENV PATH="$PATH:/workspace/android/cmdline-tools/tools/bin"

ENV ANDROID_HOME /workspace/android/sdk
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Accept Android SDK licenses
# RUN yes | sdkmanager --licenses

# Update Android SDK packages
RUN sdkmanager --update && \
    sdkmanager "platform-tools" "platforms;android-33"

# Install JDK
RUN sudo apt-get update && \
    sudo apt-get install -y openjdk-11-jdk

# Install ADB
RUN sudo apt-get install -y adb
