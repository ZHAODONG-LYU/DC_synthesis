# some tricks in eFPGA physical implement

some modules are created by muxs, but the unconfigured modules can not counted into critical path, so it ignore these paths including muxs, using\
set_disable_timing [get_pins * mux *] --> that means all the paths incuding muxs pins will be ignored.  
