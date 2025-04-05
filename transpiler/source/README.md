# Transpiler source files

All files placed within this library are used to build the native transpiler binaries.

> [!CAUTION]
> The `Base` library should not link to any other dynamic libraries!
>
> This rule has only been broken once with the `Comms` library.
> As such, the `Comms` library cannot link to the `Base` library!
> (`Comms` should make use of C++ macros to access any needed `Base::Info` data!)
