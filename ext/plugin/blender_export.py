import bpy

def export_dae_to_3ds(src,dst,magnification=100):
    # Delete objects in default scene
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete()

    # TODO: import units?
    # https://docs.blender.org/api/2.78b/bpy.ops.wm.html?highlight=collada#bpy.ops.wm.collada_import
    bpy.ops.wm.collada_import(filepath=src,import_units=False)

    # Scale the object for situations where export/import is behaving weird.
    if magnification != 1:
        for obj in bpy.data.objects:
            obj.delta_scale = (magnification,)*3
            
    # https://docs.blender.org/api/2.78b/bpy.ops.export_scene.html?highlight=3ds#bpy.ops.export_scene.autodesk_3ds
    bpy.ops.export_scene.autodesk_3ds(filepath=dst,check_existing=False)

if __name__ == '__main__':
    import sys
    
    # https://blender.stackexchange.com/questions/6817/how-to-pass-command-line-arguments-to-a-blender-python-script
    if '--' not in sys.argv:
        sys.argv = []
    else:
        sys.argv = [sys.argv[sys.argv.index("--") - 1]] + \
            sys.argv[sys.argv.index("--") + 1:]

    print(sys.argv)

    import argparse
    parser = argparse.ArgumentParser(
        description='Convert .dae to .3ds for non-pro Sketchup')
    parser.add_argument('src',type=str,help='The source .dae file')
    parser.add_argument('dst',type=str,help='The destination .3ds file')
    parser.add_argument('-mag',type=int,help='The scale factor',default=100)

    args = parser.parse_args()
    export_dae_to_3ds(args.src,args.dst,args.mag)
