require "sketchup.rb"
require "extensions.rb"

# Load plugin as extension (so that user can disable it)

loader = SketchupExtension.new "3ds Exporter Loader",
"plugin/plugin.rb"
loader.copyright= "Copyright 2011 by bendbro"
loader.creator= "bendbro"
loader.version = "0.1"
loader.description = "Exports models to .3ds" 
Sketchup.register_extension loader, true
