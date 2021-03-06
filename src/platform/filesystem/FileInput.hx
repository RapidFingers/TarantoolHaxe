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

package platform.filesystem;

import platform.io.input.IFileInput;
import platform.io.ByteArray;
import tarantool.fio.native.NativeFileHandle;

/**
 *  Input file read
 */
class FileInput implements IFileInput {

    /**
     *  Native file object
     */
    var fileObject : NativeFileHandle;

    /**
     *  Size
     */
    public var length (default, null) : Int;

    /**
     *  Current pos
     */
    public var position (default, null) : Int;

    /**
     *  Constructor
     *  @param fileObject - 
     */
    @:allow(platform.filesystem)
    function new (fileObject : NativeFileHandle) {
        this.fileObject = fileObject;
    }

    /**
     *  Read one byte
     *  @return Int
     */
    public function readByte () : Int {
        var res = StringTools.fastCodeAt (fileObject.read (1), 0);
        position += 1;
        return res;
    }

    /**
     *  Read bytes
     *  @param count - byte count to read
     *  @return ByteArray
     */
    public function readBytes (count : Int) : ByteArray {
        var res = ByteArray.fromString (fileObject.read (count));
        position += res.length;
        return res;
    }

    /**
     *  Read line from stream
     *  @return String
     */
    public function readLine () : String {
        return "";
    }

    /**
     *  Set position in stream
     *  @param pos - 
     */
    public function setPosition (pos : Int) : Void {
        fileObject.seek (pos);
        position = pos;
    }    

    /**
     *  Close stream
     */
    public function close () : Void {
        fileObject.close ();
    }
}