#!/usr/bin/env bash

#iOS Settings
INFO_PLIST_FILE=${APPCENTER_SOURCE_DIRECTORY}/quickquestions_ios/Info.plist

plutil -replace CFBundleShortVersionString -string "1.0.$APPCENTER_BUILD_ID" $INFO_PLIST_FILE

    echo "File content:"
    cat $INFO_PLIST_FILE

#Constants
APP_CONSTANT_FILE=$APPCENTER_SOURCE_DIRECTORY/quickquestions_ios/Constants.swift

if [ -e "$APP_CONSTANT_FILE" ]
then
    sed -i '' 's#oneSignalId = ".*"#oneSignalId = "'$ONE_SIGNAL_ID'"#' $APP_CONSTANT_FILE
fi


    echo "File content:"
    cat $APP_CONSTANT_FILE

    

cd $APPCENTER_SOURCE_DIRECTORY/quickquestions_ios/
curl -O $cdnpath/GoogleService-Info.plist.zip
unzip -o GoogleService-Info.plist.zip
rm -rf GoogleService-Info.plist.zip
rm -rf __MACOSX