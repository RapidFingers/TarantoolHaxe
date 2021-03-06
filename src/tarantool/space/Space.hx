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

package tarantool.space;

import tarantool.space.native.SpaceNative;
import tarantool.space.native.SpaceObjectNative;
import tarantool.index.native.IndexNative;
import tarantool.index.Index;
import tarantool.index.IndexOptions;
import tarantool.types.KeyType;
import tarantool.util.Convert;
import tarantool.types.collections.Tuple;
import tarantool.types.query.UpdateQuery;
import lua.Table;

/**
 *  Tarantool space
 */
@:native("t.space")
class Space {

    /**
     *  Native tarantool space
     */
    private var spaceObject : SpaceObjectNative;

    /**
     *  Id of space
     */
    public var id (get, null) : Int;
    public inline function get_id () : Int {
        return spaceObject.id;
    }

    /**
     *  Space name
     */
    public var name (default, null) : String;

    /**
     *  Create new space
     *  @param name - space name
     *  @return Space
     */
    public inline static function create (name : String) : Space {
        var obj = SpaceNative.create (name);
        return new Space (obj, name);
    }

    /**
     *  Create new space if not exists
     *  @param name - space name
     *  @return Space
     */
    public inline static function getOrCreate (name : String) : Space {
        var obj = untyped box.space[name];
        if (obj == null) obj = SpaceNative.create (name);                        
        return new Space (obj, name);                        
    }

    /**
     *  Get space by name
     *  @param name - name of space
     *  @return Space
     */
    public inline static function getByName (name : String) : Space {
        var obj = untyped box.space[name];
        if (obj == null) throw 'Space ${name} not exist';
        return new Space (obj, name);
    }

    /**
     *  Constructor
     *  @param spaceObject - native space object
     *  @param name - space name
     */
    private function new (spaceObject : SpaceObjectNative, name : String) {
        this.spaceObject = spaceObject;
        this.name = name;
    }    

    /**
     *  Insert array of data in space with autoincrement of primary key
     *  @param tuple - tuple
     *  @return inserted Tuple
     */
    public inline function autoIncrement (tuple : Tuple) : Tuple {        
        return spaceObject.auto_increment (tuple);
    }

    /**
     *  Number of bytes in the space
     *  @return Int
     */
    public inline function bsize () : Int {
        return spaceObject.bsize ();
    }

    /**
     *  Count tuples
     *  @param key - 
     *  @param iterator - 
     *  @return Int
     */
    public function count (?key : KeyType, ?iterator : Dynamic) : Int {
        // TODO: iterators
        return 0;
    }

    /**
     *  Create index in space
     *  @param name - index name
     *  @param options - index create options
     *  @return Index
     */
    public function createIndex (name : String, ?options : IndexOptions) : Index {
        var idx : IndexNative = null;

        if (options != null) {
            var table = Convert.serializeToLua (options);            
            idx = spaceObject.create_index (name, table);
        } else {
            idx = spaceObject.create_index (name);
        }
                
        return new Index (idx, name);
    }

    /**
     *  [Description]
     *  @param key - 
     *  @return Tuple
     */
    public function delete (key : KeyType) : Tuple {
        var table = Convert.serializeToLua (key);
        return spaceObject.delete (table);
    }

    /**
     *  Drop space
     */
    public inline function drop ()  {
        spaceObject.drop ();
    }

    /**
     *  Get one record
     *  @param key - scalar type or tuple of key parts
     *  @return Array<Dynamic>
     */
    public function get (key : KeyType) : Tuple {
        var table = Convert.serializeToLua (key);
        var tup = spaceObject.get (table);
        if (tup == null) return null;        
        return cast (tup.totable (), AnyTable);
    }

    /**
     *  Insert array of data in space
     *  @param tuple - tuple
     *  @return replaced Tuple    
     */
    public inline function insert (tuple : Tuple) : Tuple {
        var tup = spaceObject.insert (tuple);
        if (tup == null) return null;        
        return cast (tup.totable (), AnyTable);        
    }    

    /**
     *  Total tuple count
     *  @return Int
     */
    public inline function len () : Int {
        return spaceObject.len ();
    }

    /**
     *  Add trigger on replace
     *  @param call - 
     */
    public function onReplace (call : Tuple -> Tuple -> Void) {
        // TODO 
    }

    /**
     *  Iterate over data
     *  @param key - 
     *  @param iterator - 
     */
    public function pairs (?key : KeyType, iterator : Dynamic) {
        // TODO
    }

    /**
     *  Replace tuple
     *  @param tuple - tuple  
     *  @return replaced Tuple    
     */
    public inline function put (tuple : Tuple) : Tuple {
        return spaceObject.put (tuple);
    }

    /**
     *  Rename space
     */
    public inline function rename (name : String)  {
        spaceObject.rename (name);
        this.name = name;
    }

    /**
     *  Replace tuple
     *  @param tuple - tuple   
     *  @return replaced Tuple  
     */
    public inline function replace (tuple : Tuple) : Tuple {
        return spaceObject.replace (tuple);
    }

    /**
     *  Enable/disable onReplace trigger
     *  @param value - 
     */
    public inline function runTriggers (value : Bool) {
        spaceObject.run_triggers (value);
    }

    /**
     *  Select tuples by key
     *  @param key - scalar type or tuple of key parts
     *  @return Tuple
     */
    public function select (?key : KeyType) : Array<Tuple> {
        var tables = {
            if (key != null) {
                var table = Convert.serializeToLua (key);
                spaceObject.select (table);
            } else {
                spaceObject.select ();
            }
        };

        return {
            var res = new Array<Tuple> ();
            AnyTable.foreachi (tables, function(i,val,e) {
                var tab = cast (val.totable (), AnyTable);
                res.push (tab);
            });
            res;           
        }
    }

    /**
     *  Delete all tuples in space
     */
    public inline function truncate () : Void {
        spaceObject.truncate ();
    }  

    /**
     *  Update tuple
     *  @param key - scalar type or tuple of key parts
     *  @param query - array of query for update    
     *  @return updated Tuple 
     */
    public inline function update (key : KeyType, query : Array<UpdateQuery<Dynamic>>) : Tuple {
        var keyTable = Convert.serializeToLua (key);
        var table = Convert.serializeToLua (query);
        return spaceObject.update (keyTable, table);
    }                    

    /**
     *  Update or insert data
     *  @param tuple - tuple to update/insert
     *  @param query - array of query for update
     *  @return inserted Tuple
     */    
    public function upsert (tuple : Tuple, query : Array<UpdateQuery<Dynamic>>) : Tuple {
        var table = Convert.serializeToLua (query);
        return spaceObject.upsert (tuple, table);
    }                
}