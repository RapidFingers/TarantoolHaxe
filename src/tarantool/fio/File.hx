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

package tarantool.fio;

import platform.io.ByteArray;
import tarantool.fio.native.NativeFio;
import tarantool.fio.native.NativeFileHandle;

/**
 *  File
 */
class File {
    
    /**
     *  Native file handle
     */
    var file : NativeFileHandle;

    /**
     *  Get file extension
     *  @param path - 
     *  @return String
     */
    public inline static function getExtension (path : String) : String {
        var lind = path.lastIndexOf (".");
        if (lind < 0) return "";
        lind++;
        return path.substr (lind, path.length - lind);
    }

    /**
     *  Constructor
     *  @param path - 
     */
    public function new  (path : String) {
        file = NativeFio.open (path);
    }

    /**
     *  Read all file bytes
     *  @param path - file path
     *  @return Bytes
     */
    public function readAllBytes (path : String) : ByteArray {
        var s = file.stat ();
        var size = untyped s["size"];
        var data = file.read (size);
        file.close ();
        return ByteArray.fromString (data);
    }
}