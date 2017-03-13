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

package http.handlers;

/**
 *  Handle errors
 */
class ErrorHandler extends Handler {
    /**
     *  Callback to process error
     */
    private var _onError : HttpContext -> HttpStatus -> Void;

    /**
     *  Process error
     */
    private function processError (c : HttpContext, err : HttpStatus) {
        c.response.reset ();
        c.response.status = err;

        if (_onError != null) {
            try {                
                _onError (c, err);
            } catch (e : Dynamic) {
                c.response.reset ();
                c.response.status = HttpStatus.Internal;
            }
        }            

        c.response.close ();
    }

    /**
     *  Constructor
     */
    public function new (call : HttpContext -> HttpStatus -> Void) {
        _onError = call;
    }    

    /**
     *  Process request
     *  @param context - Http context
     */
    public override function process (context : HttpContext) : Void {
        try {
            callNext (context);
        } catch (e : HttpStatus) {
            processError (context, e);
        } catch (e : Dynamic) {
            processError (context, HttpStatus.Internal);
        }
    }
}