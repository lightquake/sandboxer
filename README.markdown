# About

`sandboxer` is a wrapper around `cabal-dev` that overrides the default
sandbox location with one of your choice. This way, multiple projects
can share the same sandbox, even if your development/build environment
doesn't provide options for specifying the cabal-dev sandbox.

# Installation

Put `source path/to/sandboxer.sh` somewhere in your shell init
script. Note that you *must* source it, since it works by defining
functions. Executing it directly will not be useful, which is why it's
mode 0644.

# Usage

`sandbox init name` creates a new sandbox. `sandbox activate name`
activates that sandbox, and `sandbox deactivate` deactivates the
current sandbox. Sandboxes are created in ~/.sandboxer by default, but
you can set `$SANDBOXER_ROOT` to override this.

`sandboxer` also sets `$GHC_PACKAGE_PATH` to help with applications
that call `runghc` directly; if this isn't what you want you can just
comment it out (and let me know so I can add an option!).
