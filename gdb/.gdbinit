set breakpoint pending on
set disassembly-flavor intel
tui enable
lay src

define hook-stop
    info locals
end
