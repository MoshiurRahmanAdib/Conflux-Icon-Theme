### Inkscape SVGs
Icons in the "Inkscape SVGs" folder are Inkscape documents. You should save Inkscape files there. Icons in that folder should be exported from Inkscape (probably to `../apps/scalable/` or similar) (*do not just copy the Inkscape files, or save from Inkscape*).

Some files may have multiple icons, or elements that make up more than one icon (e.g., files.svg has the Dolphin icon in it. From this, the general Files (files.svg) icon is exported excluding the dolphin, and the Dolphin icon (dolphin.svg) including it); these need to be exported separately.

### From Source
Icons there are those that are directly copied from the sources with no modifications.

### Optimize Script
It is recommended that after exporting the icons, you optimize them. You can simply run the `optimize.sh` script from a directory (there are symlinks in the theme folder, like `apps/scalable`) to optimize all SVGs there (uses SVGO) (or just manually run `svgo --pretty -i .`).

### Template
You may use the icon template `template.svg`.