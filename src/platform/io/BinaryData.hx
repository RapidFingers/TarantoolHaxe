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

package platform.io;

import platform.io.input.IByteReadable;

/**
 *  For working with binary data in memory
 */
class BinaryData {

    /**
     *  Get byte by position
     *  @param pos - 
     *  @return Int
     */
    public function get (pos : Int) : Int {
        return 0;
    }

    /**
     *  Set byte at position
     *  @param byte - 
     */
    public function set (pos : Int, byte : Int) {
        
    }

    /**
     *  Append byte
     *  @param data - 
     */
    public function addByte (data : Int) {

    }    

    /**
     *  Append byte array
     *  @param data - 
     */
    public function addArray (data : ByteArray) {

    }
    
    /**
     *  Write array
     *  @param data - array data
     *  @param dstPos - start pos in binary data
     *  @param srcPos - start pos in byte array
     *  @param size - size of write data
     *  @param autoResize - auto resize binary data
     */
    public function writeArray (data : ByteArray, dstPos : Int, srcPos : Int, size : Int, autoResize : Bool = true) {

    }

    /**
     *  Append some IByteReadable
     *  @param data - 
     */
    public function addReadable (data : IByteReadable) {

    }
}