/*
 * Copyright (c) 2017 Grabli66
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package tarantool.clock;

import tarantool.clock.native.ClockNative;
import tarantool.types.UInt64;

/**
 *  The clock module returns time values derived from the Posix / C CLOCK_GETTIME function or equivalent
 */
@:native("t.Clock")
class Clock {

    /**
     *  System-wide clock that measures real (i.e., wall-clock) time.
     *  Setting this clock requires appropriate privileges.  This
     *  clock is affected by discontinuous jumps in the system time
     *  (e.g., if the system administrator manually changes the
     *  clock), and by the incremental adjustments performed by adjtime(3) and NTP.
     *  @return Seconds
     */    
    public inline static function realtime () : Int {
        return ClockNative.realtime ();
    }

    /**
     *  64 bit version of realtime
     *  @return Nanoseconds
     */
    public inline static function realtime64 () : UInt64 {        
        return ClockNative.realtime64 ();
    }

    /**
     *  Clock that cannot be set and represents monotonic time since
     *  some unspecified starting point.  This clock is not affected
     *  by discontinuous jumps in the system time (e.g., if the system
     *  administrator manually changes the clock), but is affected by
     *  the incremental adjustments performed by adjtime(3) and NTP.
     *  @return Seconds
     */
    public inline static function monotonic () : Int {
        return ClockNative.monotonic ();
    }

    /**
     *  64 bit version of monotonic
     *  @return Nanoseconds
     */
    public inline static function monotonic64 () : UInt64 {
        return ClockNative.monotonic64 ();
    }

    /**
     *  The processor time. Derived from C function clock_gettime(CLOCK_PROCESS_CPUTIME_ID). 
     *  This is the best function to use with benchmarks that need to calculate how much 
     *  time has been spent within a CPU.
     *  @return Seconds
     */
    public inline static function proc () : Int {
        return ClockNative.proc ();
    }

    /**
     *  64 bit version of proc
     *  @return Nanoseconds
     */
    public inline static function proc64 () : UInt64 {
        return ClockNative.proc64 ();
    }

    /**
     *  The thread time. Derived from C function clock_gettime(CLOCK_THREAD_CPUTIME_ID). 
     *  This is the best function to use with benchmarks that need to calculate how much 
     *  time has been spent within a thread within a CPU.
     *  @return Int
     */
    public inline static function thread () : Int {
        return ClockNative.thread ();
    }

    /**
     *  64 bit version of thread
     *  @return Nanoseconds
     */
    public inline static function thread64 () : UInt64 {
        return ClockNative.thread64 ();
    }
}