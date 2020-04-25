#!/bin/bash

export MY_FILE=m12_localization_ert_linux/ert_main.c
sed -i '1s/^/#ifndef rtmGetStopRequested \n/' $MY_FILE;
sed -i '2s/^/#define rtmGetStopRequested(rtm)      ((void*) 0) \n/' $MY_FILE;
sed -i '3s/^/#endif \n/' $MY_FILE;

sed -i '4s/^/#ifndef rtmSetStopRequested \n/' $MY_FILE;
sed -i '5s/^/#define rtmSetStopRequested(rtm,rtm2)      ((void*) 0) \n/' $MY_FILE;
sed -i '6s/^/#endif \n/' $MY_FILE;

