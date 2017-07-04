SET plugin_directory=C:\Users\%USERNAME%\AppData\Roaming\SketchUp\SketchUp 2017\SketchUp\Plugins\
SET plugin_zip=3ds_exporter.zip
python -c "import shutil; shutil.make_archive('./3ds_exporter', 'zip', 'ext')
copy /Y /b "%~dp0%plugin_zip%" "%~dp0%3ds_exporter.rbz"