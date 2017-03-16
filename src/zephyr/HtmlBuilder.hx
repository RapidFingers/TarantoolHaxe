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

package zephyr;

import zephyr.tag.*;


/**
 *  Html Builder
 */
class HtmlBuilder {
    /**
     *  Create <html> tag
     *  @param tags - child tags
     *  @return Tag
     */
    public static function html (?options : TagOptions, ?tags : Array<Tag>) : Tag {        
        return new Tag ("html", options, tags);
    }

    /**
     *  Create <header> tag
     *  @param tags - child tags
     *  @return Tag
     */
    public static function head (?options : TagOptions, ?tags : Array<Tag>) : Tag {
        return new Tag ("head", options, tags);
    }

    public static function link (?options : LinkTagOptions) : Tag {
        return new LinkTag (options);
    }

    /**
     *  Create <body> tag
     *  @param tags - 
     *  @return Tag
     */
    public static function body (?options : TagOptions, ?tags : Array<Tag>) : Tag {
        return new Tag ("body", options, tags);
    }

    /**
     *  Create <div> tag
     *  @param text - 
     *  @param tags -
     *  @return Tag
     */
    public static function div (?options : TextTagOptions, ?tags : Array<Tag>) : Tag {        
        return new TextTag ("div", options, tags);
    }

    /**
     *  Create <ul> tag
     *  @param options - 
     *  @param tags - 
     *  @return Tag
     */
    public static function ul (?options : TextTagOptions, ?tags : Array<Tag>) : Tag {        
        return new TextTag ("ul", options, tags);
    }

    /**
     *  Create <ul> tag
     *  @param options - 
     *  @param tags - 
     *  @return Tag
     */
    public static function li (?options : TextTagOptions, ?tags : Array<Tag>) : Tag {        
        return new TextTag ("li", options, tags);
    }

    /**
     *  Create <p> tag
     *  @param text - 
     *  @param tags - 
     *  @return Tag
     */
    public static function p (?options : TextTagOptions, ?tags : Array<Tag>) : Tag {
        return new TextTag ("p", options, tags);
    }

    /**
     *  Create <a> tag
     *  @param text - 
     *  @param tags - 
     *  @return Tag
     */
    public static function a (?options : ATagOptions, ?tags : Array<Tag>) : Tag {
        return new ATag (options, tags);
    }

    /**
     *  Create <h1> tag
     *  @param text - 
     *  @param tags - 
     *  @return Tag
     */
    public static function h1 (?options : TextTagOptions, ?tags : Array<Tag>) : Tag {
        return new TextTag ("h1", options, tags);
    }
}