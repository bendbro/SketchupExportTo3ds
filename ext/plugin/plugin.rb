require 'win32ole'
require "sketchup.rb"
require 'tmpdir'

# https://stackoverflow.com/questions/170956/how-can-i-find-which-operating-system-my-ruby-program-is-running-on
class OS
  def self.windows
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def self.mac
   (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def self.unix
    !OS.windows?
  end

  def self.linux
    OS.unix? and not OS.mac?
  end
end

def run_command(command,args)
  if OS.windows() then
    # https://stackoverflow.com/questions/32374275/execute-basic-windows-commands
    # https://msdn.microsoft.com/en-us/library/windows/desktop/gg537745(v=vs.85).aspx
    # https://stackoverflow.com/questions/10869789/hiding-curl-window-on-windows/10874563#10874563
    shell = WIN32OLE.new('Shell.Application')
    return shell.ShellExecute(command,args,"", "", 0)
  end
  return system(command + ' ' + args)
end

def handle_3ds_export()
  plugin_location = File.join(File.dirname(__FILE__),'blender_export.py')
  # http://robertgreiner.com/2011/10/how-to-get-a-temp-directory-in-any-os-with-ruby/
  src = File.join(Dir.tmpdir(),'temp_export.dae')

  # http://www.sketchup.com/intl/developer/docs/ourdoc/model#export
  model = Sketchup.active_model
  status = model.export(src)
  if !status then
    UI.messagebox('Error creating .dae file with Sketchup API.')
    return
  end

  # http://ruby.sketchup.com/UI.html#savepanel-class_method
  dst = UI.savepanel("Choose where to export the .3ds")
  if dst == nil then
    return
  end

  result = run_command("blender","-b -P \"#{plugin_location}\" -- \"#{src}\" \"#{dst}\"")
  if result != nil && result != 0 then
    UI.messagebox('Error converting from .dae to .3ds. ' + "\n" + result.to_s())
  end
end

# http://sketchupplugins.com/about/creating-a-sketchup-plugin/
# https://forums.sketchup.com/t/exec-crashes-sketchup/14417
mymenu = UI.menu("File").add_item("Export to .3ds") {
  begin
    handle_3ds_export()
  rescue Exception => e
    UI.messagebox(e)
  end
}
