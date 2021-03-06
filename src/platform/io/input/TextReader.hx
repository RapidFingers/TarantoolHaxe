/**
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

package platform.io.input;

import platform.io.input.IByteInput;

/**
 *  Read text data from byte input
 */
class TextReader implements ITextInput {

    /**
     *  Data input
     */
    var input : IByteInput;

    /**
     *  Constructor
     *  @param input - Data input
     */
    public function new (input : IByteInput) {
        this.input = input;
    }

    /**
     *  Read line from stream
     *  @return String
     */
    public function readLine () : String {
        var buf = new BinaryData ();
		var last : Int;
		var s : String;

        while ((last = input.readByte ()) != 0x0A) {
            buf.addByte (last);
        }

        s = buf.toString ();
        if( s.charCodeAt (s.length - 1) == 0x0D ) s = s.substr (0,-1);
		return s;        
    }
}