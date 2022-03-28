This directory contains the checkers you want to enable.

The way I see this working is the same as Apache does with modules and sites,
keep the checkers in the checkers_available directory but then symlink the
ones you want to use into here.

Linux
-----

    $ ln -s 01basic.rb ../checkers_available/basic.rb

Windows
-------

    $ mklink 01basic.rb "../checkers_available/basic.rb"

(For version of Windows prior to Vista, you need to copy checkers manually from the `checkers_available` folder to the `checkers_enable` folder)
