#!/usr/bin/env bash

echo "##[warning][Pre-Build Action] - Lets do some Pre build transformations..."

# Declare local script variables
SCRIPT_ERROR=0

# Define the files to manipulate
ANDROID_MAINACTIVITY_FILE=${APPCENTER_SOURCE_DIRECTORY}/TestDistribute/TestDistribute.Android/MainActivity.cs
ANDROID_MANIFEST_FILE=${APPCENTER_SOURCE_DIRECTORY}/TestDistribute/TestDistribute.Android/Properties/AndroidManifest.xml
CONSTANT_HELPER_FILE=${APPCENTER_SOURCE_DIRECTORY}/TestDistribute/TestDistribute/Helpers/ConstantHelper.cs

echo "##[warning][Pre-Build Action] - Checking if all files and environment variables are available..."
echo
echo "##[info][Pre-Build Info] - AppCenter Source Directory - ${APPCENTER_SOURCE_DIRECTORY}"
echo "##[info][Pre-Build Info] - MainActivity.cs - ${ANDROID_MAINACTIVITY_FILE}"
echo "##[info][Pre-Build Info] - AndroidManifest.xml - ${ANDROID_MANIFEST_FILE}"
echo "##[info][Pre-Build Info] - ConstantHelper.cs - ${CONSTANT_HELPER_FILE}"
echo

if [ ! -n "${APP_DISPLAY_NAME}" ]
then
    echo "##[error][Pre-Build Action] - APP_DISPLAY_NAME variable needs to be defined in App Center!!!"
    let "SCRIPT_ERROR += 1"
else
    echo "##[warning][Pre-Build Action] - APP_DISPLAY_NAME variable - oK!"
fi

if [ ! -n "${PACKAGE_NAME}" ]
then
    echo "##[error][Pre-Build Action] - PACKAGE_NAME variable needs to be defined in App Center!!!"
    let "SCRIPT_ERROR += 1"
else
    echo "##[warning][Pre-Build Action] - PACKAGE_NAME variable - oK!"
fi

if [ ! -n "${ANDROID_APP_SECRET}" ]
then
    echo "##[error][Pre-Build Action] - ANDROID_APP_SECRET variable needs to be defined in App Center!!!"
    let "SCRIPT_ERROR += 1"
else
    echo "##[warning][Pre-Build Action] - ANDROID_APP_SECRET variable - oK!"
fi

if [ -e "${ANDROID_MAINACTIVITY_FILE}" ]
then
    echo "##[warning][Pre-Build Action] - MainActivity file found - oK!"
else
    echo "##[error][Pre-Build Action] - MainActivity file not found!"
    let "SCRIPT_ERROR += 1"
fi

if [ -e "${ANDROID_MANIFEST_FILE}" ]
then
    echo "##[warning][Pre-Build Action] - Manifest file found - oK!"
else
    echo "##[error][Pre-Build Action] - Manifest file not found!"
    let "SCRIPT_ERROR += 1"
fi

if [ -e "${CONSTANT_HELPER_FILE}" ]
then
    echo "##[warning][Pre-Build Action] - ConstantHelper.cs file found - oK!"
else
    echo "##[error][Pre-Build Action] - ConstantHelper.cs file not found!"
    let "SCRIPT_ERROR += 1"
fi

if [ ${SCRIPT_ERROR} -gt 0 ]
then
    echo "##[error][Pre-Build Action] - There are ${SCRIPT_ERROR} errors."
    echo "##[error][Pre-Build Action] - Fix them and try again..."
    exit 1 # this will kill the build
fi

echo "##[warning][Pre-Build Action] - There are ${SCRIPT_ERROR} errors."

if [ -e "${ANDROID_MAINACTIVITY_FILE}" ]
then
    echo "##[command][Pre-Build Action] - Changing the App display name on Android to: ${APP_DISPLAY_NAME} "
    sed -i '' "s/Label = \"[-a-zA-Z0-9_ ]*\"/Label = \"${APP_DISPLAY_NAME}\"/" ${ANDROID_MAINACTIVITY_FILE}

    echo "##[section][Pre-Build Action] - MainActivity.cs File content:"
    cat ${ANDROID_MAINACTIVITY_FILE}
    echo "##[section][Pre-Build Action] - MainActivity.cs EOF"
fi

if [ -e "${ANDROID_MANIFEST_FILE}" ]
then
	echo "##[command][Pre-Build Action] - Changing the package name on Android to: ${PACKAGE_NAME} "
	sed -i '' 's/package=\".*?\"/package="'$PACKAGE_NAME'"/' $ANDROID_MANIFEST_FILE

    echo "##[section][Pre-Build Action] - AndroidManifest.xml File content:"
    cat ${ANDROID_MANIFEST_FILE}
    echo "##[section][Pre-Build Action] - AndroidManifest.xml EOF"
fi

if [ -e "${CONSTANT_HELPER_FILE}" ]
then
	echo "##[command][Pre-Build Action] - Changing the  app secret on Android to: ${ANDROID_APP_SECRET} "
	sed -i '' 's/AppCenterToken = \"[-a-zA-Z0-9]*\"/AppCenterToken = "'$ANDROID_APP_SECRET'"/' $CONSTANT_HELPER_FILE

    echo "##[section][Pre-Build Action] - ConstantHelper.cs File content:"
    cat ${CONSTANT_HELPER_FILE}
    echo "##[section][Pre-Build Action] - ConstantHelper.cs EOF"
fi