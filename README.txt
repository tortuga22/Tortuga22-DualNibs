DualNibs Readme

This is a preliminary public release of the DualNibs library for iOS.

Fuller documentation (including design notes) will show up in another week or two, at which point this document will be updated.

Origins:

This library originated in the ScreenChalk app by Tortuga 22, Inc., as a way of making it easier to have radially-different UIs in each of portrait and landscape modes while still enabling easy collaboration with our designers. Due to unforeseen events the current version of ScreenChalk doesn't actually implement the portrait orientation at this time, but the dual-nib capability is still in the app (and in that app was fairly thoroughly tested prior to the point we discovered we weren't going to implement it).

This library is a cleaner and more-reusable version of the dual-nib functionality built into ScreenChalk; it's a little more general and a little better-architected, but is different enough that you should give it a thorough shakedown before committing to use it in your own projects.

How it Works (Step-By-Step):
- "primary" view controller is initialized, and informed of the "other orientation's" nib and orientation
- "primary" view controller hits viewDidLoad
- "primary" view controller creates instance of "alternate" view controller
- "primary" view controller creates rotation manager
- rotation manager reads off each "rotating" view's layout params from the primary and alternate's views (as specified in the nib)
- alternate view controller is destroyed (along with its view)
- primary view's view is presented to user
- from then on, whenever the view controller needs to rotate its view it calls through to its rotation manager, and the rotation manager rotates the views according to the parameters it read off earlier

Quick Start Guide:

Here is a quick-start guide to getting up and running.

Step 1: Start a new project.

Step 2: Add DualNibs as a subproject. Sub-steps: (1) set DualNibs as one of your target's dependencies (2) add the generated DualNib library to the libraries you link against and (3) set the -ObjC and -all_load linking flags (necessary to get the library's categories to load correctly).

Step 3: Create a view controller you want to rotate. This view controller should be a subclass of VDDualNibViewController.

Step 4: Create your nibs for the portrait and landscape orientations. The default names for these are $CLASSNAME-Portrait.xib and $CLASSNAME-Landscape.xib. You can name them whatever you want but doing so leaves you unable to use some of the convenience constructors.

Step 5: Override +(void)actuallyAddKeysForRotatingViews:(NSMutableSet *)targetSet on your view controller. It should add the property name of each rotating view to targetSet.

Step 6: Put any view population code in viewWillAppear: or viewDidAppear:, if you want to keep things simple. If you have more complicated needs you should look into the actuallyPerformHeavyWeightContentPopulation and  actuallyPerformLightWeightContentPopulation methods (which hopefully will be documented soon).

Tips + Gotchas:

(A) Make sure both you set all IBOutlets and IBActions, etc., in both nibs; if you use VDDualNibViewController you can't control which nib it actually loads from. I recommend making one nib first, wiring up all its IBOutlets and IBActions, and then 

(B) Not all properties of a view are copied over by a view specification. You can look at the source of DualNibs to see if a particular property is included at the present. See also "Future Work: (B)".

(C) This was designed for apps that had a single main view controller. On the one hand it ought to work fine if, eg, you have multiple rotating viwe controllers at once (eg: as you would with a rotating modal atop a rotating view, or with multiple rotating views in a navigation controller stack) but hasn't been thoroughly tested in that scenario.

(D) When you use this library you need to be more careful about how your dual-nib view controllers handle the lifecycle methods; basically you need to avoid creating 2 of a particular resource-intensive object as part of your view controller's initialization sequence (eg: an instance of MPMoviePlayerController). The simple way to do that for now is to put any initialization code in viewWillAppear and/or viewDidAppear; there's also infrastructure in place for separating out "what should I load if my destiny is to be presented to the user" and "what should I load if my destiny is to be destroyed after having my layout parameters read-off", and that infrastructure will eventually be better-documented.

Future Work:

(A) Sanitizing the builds and preprocessor flags. If you peruse the codebase you'll see lots of assertions as well as some debug logging; these are toggled on/off by commenting/uncommenting certain #define statements in the DualNibs project's prefix header. Ideally these #defines would be controlled by environment variables set up in the project making use of the library, instead of manual commenting/uncommenting.

(B) The view specification classes could conceivably be replaced with a much simpler class that looks like this: for ivars rely on an NSMutableDictionary and NSMutableSet instance, use valueForKey: and setValue:forKey: exclusively for reading off view properties and setting them (storing values in the dictionary), and storing the keys to get-and-set in the set instance. This would simplify the codebase at the expense of slowing down the set/get behavior, but perhaps not significantly; this is a topic for investigation at a future point.

(C) Cleaning up some of the "actually" code. A house idiom is to make subclassing simpler while ensuring @synchronized and @try/@catch blocks are properly used, etc., is to have the public method be like "doSomething" and then put the actual work in a method call "actuallyDoSomething". doSomething wraps the call to actuallyDoSomething in @try/@catch or @synchronized, and then you can safely override or extend actuallyDoSomething without having to worry about setting up exception safety and/or synchronization. In places, however, this library has some redundant "actually"-methods that could be streamlined.

(D) Profiling + other work. The originating code was performant enough to not have us too concerned with performance or memory usage, but we've never actually profiled either that code or this library's efficiency and thus can't make strong claims about how performant it is.

(E) iPhone Demo: the current demo is iPad only. Making an iPhone-sized demo would be a nice thing to do but isn't a priority at this time.

(F) Testing: as with most UI libraries setting up adequate testing is a bit more of a pain than with other types of code. It'd make us sleep better if we had some tests on this, though.