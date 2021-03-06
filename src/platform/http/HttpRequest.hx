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

package platform.http;

import platform.net.AbstractTcpSocket;
import platform.io.input.LimitedReader;
import tink.Url;
using StringTools;

/**
 *  Request from client
 */
class HttpRequest {

    /**
     *  Version
     */
    public var version : HttpVersion;

    /**
     *  Method
     */
    public var method : HttpMethod;

    /**
     *  Request resource       
     */
    public var url : Url;

    /**
     *  Request headers
     */
    public var headers (default, null) : Map<String, String>;

    /**
     *  Request body
     */
    public var body : LimitedReader;

    /**
        Read all headers
    **/
    private function readHeaders (channel : AbstractTcpSocket) : Void {        
        var text = channel.input.readLine ();        
        if (text == null) throw "Connection closed";    // TODO: create internal error class to catch them
        var line = text.trim ();
        var parts = line.split (" ");
        if (parts.length != 3) throw HttpStatus.BadRequest;
        method = parts[0].toUpperCase ();
        url = parts[1];

        headers = new Map<String, String> ();

        line = channel.input.readLine ().trim ();
        while (line.length > 0) {
            var head = line.split (": ");
            if (head.length < 2) throw HttpStatus.BadRequest;
            headers[head[0]] = head[1];
            line = channel.input.readLine ().trim ();
        }
    }

    /**
     *  Read body
     *  @param channel - 
     */
    private function readBody (channel : AbstractTcpSocket) : Void {
        body = null;
        if (method == HttpMethod.Get) return;

        if (headers.exists ("Content-Length")) {
            var len = Std.parseInt (headers ["Content-Length"]);
            if (len < 1) return;
            body = new LimitedReader (channel.input, len);
        } else if (headers["Transfer-Encoding"] == "chunked") {
            
        }
    }

    /**
     *  Constructor
     *  @param channel - 
     */
    public function new (channel : AbstractTcpSocket) {        
        readHeaders (channel);        
        readBody (channel);        
    }
}