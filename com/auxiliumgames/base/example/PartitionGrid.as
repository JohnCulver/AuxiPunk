/**
 * Created with IntelliJ IDEA.
 * User: JC
 * Date: 7/6/12
 * Time: 5:45 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.example {
import net.flashpunk.Entity;
import net.flashpunk.masks.Grid;

public class PartitionGrid extends Entity{
    public function PartitionGrid() {
        var g:Grid = new Grid(150,150,50,50,50,50);
        for (var i:int = 0; i < 3; i++) {
            for (var j:int = 0; j < 3; j++) {
                g.setTile(i, j);
            }
        }
        mask = g;
    }
}
}
