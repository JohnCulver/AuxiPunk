package com.auxiliumgames.base {
	
/*	
.__       _____   ____    ______      ______   __  __     
/\ \     /\  __`\/\  _`\ /\__  _\    /\__  _\ /\ \/\ \    
\ \ \    \ \ \/\ \ \,\L\_\/_/\ \/    \/_/\ \/ \ \ `\\ \   
.\ \ \  __\ \ \ \ \/_\__ \  \ \ \       \ \ \  \ \ , ` \  
..\ \ \L\ \\ \ \_\ \/\ \L\ \ \ \ \       \_\ \__\ \ \`\ \ 
...\ \____/ \ \_____\ `\____\ \ \_\      /\_____\\ \_\ \_\
....\/___/   \/_____/\/_____/  \/_/      \/_____/ \/_/\/_/
	                                                          
	                                                          
.______  ____    ______  ______   _____   __  __  ____    ____     ____    ______   ____    ______   
/\  _  \/\  _`\ /\__  _\/\__  _\ /\  __`\/\ \/\ \/\  _`\ /\  _`\  /\  _`\ /\__  _\ /\  _`\ /\__  _\  
\ \ \L\ \ \ \/\_\/_/\ \/\/_/\ \/ \ \ \/\ \ \ `\\ \ \,\L\_\ \ \/\_\\ \ \L\ \/_/\ \/ \ \ \L\ \/_/\ \/  
.\ \  __ \ \ \/_/_ \ \ \   \ \ \  \ \ \ \ \ \ , ` \/_\__ \\ \ \/_/_\ \ ,  /  \ \ \  \ \ ,__/  \ \ \  
..\ \ \/\ \ \ \L\ \ \ \ \   \_\ \__\ \ \_\ \ \ \`\ \/\ \L\ \ \ \L\ \\ \ \\ \  \_\ \__\ \ \/    \ \ \ 
...\ \_\ \_\ \____/  \ \_\  /\_____\\ \_____\ \_\ \_\ `\____\ \____/ \ \_\ \_\/\_____\\ \_\     \ \_\
....\/_/\/_/\/___/    \/_/  \/_____/ \/_____/\/_/\/_/\/_____/\/___/   \/_/\/ /\/_____/ \/_/      \/_/

    
Copyright (c) 2008 Lost In Actionscript - Shane McCartney

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

/*
 * Capped Object Pool
 * This Class allows for a Object Pool which doesn't exceed the bounds of a set maximum size
 * for the resource the Object Pool.
 */ 

	public class CappedObjectPool {

                private var _minSize : int;
                private var _maxSize : int;
                public var size : int = 0;

                public var create : Function;
                public var clean : Function;
                public var length : int = 0;

                private var list : Array = [];
                private var disposed : Boolean = false;
                
                /*
                 * @param create This is the Function which should return a new Object to populate the Object pool
                 * @param clean This Function will recieve the Object as a param and is used for cleaning the Object ready for reuse
                 * @param minSize The initial size of the pool on Pool construction
                 * @param maxSize The maximum possible size for the Pool
                 */

                public function CappedObjectPool(create : Function, clean : Function = null, minSize : int = 50, maxSize : int = 200) {
                        this.create = create;
                        this.clean = clean;
                        this.minSize = minSize;
                        this.maxSize = maxSize;
                        
                        for(var i : int = 0;i < minSize; i++) add();
                }

                private function add() : void {
                        list[length++] = create();
                        size++;
                }
                
                /*
                 * Sets the minimum size for the Pool
                 */
                public function set minSize(num : int) : void {
                        _minSize = num;
                        if(_minSize > _maxSize) _maxSize = _minSize;
                        if(_maxSize < list.length) list.splice(_maxSize);
                        size = list.length;
                }
                
                /*
                 * Gets the minimum size for the Pool
                 */
                public function get minSize() : int {
                        return _minSize;
                }
                
                /*
                 * Sets the maximum size for the Pool
                 */
                public function set maxSize(num : int) : void {
                        _maxSize = num;
                        if(_maxSize < list.length) list.splice(_maxSize);
                        size = list.length;
                        if(_maxSize < _minSize) _minSize = _maxSize;
                }
                
                /*
                 * Returns the maximum size for the Pool
                 */
                public function get maxSize() : int {
                        return _maxSize;
                }
                
                /*
                 * Checks out an Object from the pool
                 */
                public function checkOut() : * {
                        if(length == 0) {
                                if(size < maxSize) {
                                        size++;
                                        return create();
                                } else {
                                        return null;
                                }
                        }
                        
                        return list[--length];
                }
                
                /*
                 * Checks the Object back into the Pool
                 * @param item The Object you wish to check back into the Object Pool
                 */
                public function checkIn(item : *) : void {
                        if(clean != null) clean(item);
                        list[length++] = item;
                }
                
                /*
                 * Disposes the Pool ready for GC
                 */
                public function dispose() : void {
                        if(disposed) return;
                        
                        disposed = true;
                        
                        create = null;
                        clean = null;
                        list = null;
                }
        }

}