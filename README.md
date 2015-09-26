#What is it
enableAPKDebugging is a script that will take any apk as an input, recompile, sign, and align the output. This means in one command you now get a version of the apk that can be installed and will allow for debugging.

#Usage
enableAPKDebugging.sh App.apk

Output will be App_debugging.apk.

Now just install it:

adb install App_debugging.apk

Done.
