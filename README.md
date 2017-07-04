Adds File -> Export to .3ds dropdown to Google SketchUp that is removed after the Pro trial version expires.

Installation Instructions: https://github.com/bendbro/SketchupExportTo3ds/releases

Needs blender accessible on the system path.
  * In windows search for "Edit environment variables for your account"
  * https://www.blender.org/

Issues
  * Only tested on windows, should work elsewhere
  * Tested only on old AF versions of Sketchup and Windows.
  * Scaling gets lost from Sketchup -> .dae -> Blender -> .3ds. It is currently hardcoded to 1000 on all axes.
  * Windows ShellExecute doesn't provide a return value. There is no indication to the user if blender commands fail.