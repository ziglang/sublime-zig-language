# Build System
The build system provided for Sublime Text depends on `zig` being either in your path or the `zig.executable` setting. The build system comes with predefined build targets for running, testing, and formatting single files or whole projects that use a `build.zig`. If for whatever reason you would want to extend these build targets or add your own (e.g. your own `.sublime-project` file), the following shows all the options available:
```js
{
	// .sublime-project

   "folders": [
   		//...
   	],
    "settings": {
    	// ...
    },
    "build_systems": [
    	// runs `zig fmt $file_name` 
    	{
    		// the build systems functions are all under the `zig_build` command
    		// `target` must always be `"zig_build"`
        "target": "zig_build", 
        "name": "Format File",
        "cmd": ["fmt", "$file_name"]
      },
    	// runs `zig build install` 
      {
      	// t
        "target": "zig_build", 
        "name": "Install Project",
        "step": {
        	"name": "install"
        }
      },
      // runs `zig build run -- foo bar` 
      {
      	// t
        "target": "zig_build", 
        "name": "Run Project",
        "step": {
        	"name": "run",
        	"args": ["foo", "bar"]
        }
      }
    ]
}
```
See the Sublime Text [docs](https://www.sublimetext.com/docs/build_systems.html#variables) for all the possible expansion variables.
