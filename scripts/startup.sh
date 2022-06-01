#!/bin/bash

emulator @emulator -no-boot-anim -netfast -no-snapshot -wipe-data -noaudio -skip-adb-auth -delay-adb -accel on -verbose -gpu swiftshader_indirect -writable-system -ranchu -no-window -qemu -enable-kvm &> logs.txt