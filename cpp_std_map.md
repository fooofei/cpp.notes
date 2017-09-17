
- before use `std::map::insert`, you should use `std::map::find` to detect
if it already exist. If already exist, and the memory is alloced, if not check,
there will have a memory leak.
