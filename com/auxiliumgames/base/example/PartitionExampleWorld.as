/**
 * Created with IntelliJ IDEA.
 * User: JC
 * Date: 7/6/12
 * Time: 4:48 PM
 * To change this template use File | Settings | File Templates.
 */
package com.auxiliumgames.base.example {
import com.auxiliumgames.base.example.PartitionExampleEntity;
import com.auxiliumgames.base.example.SpawnExampleEntity;
import com.auxiliumgames.base.Partition;

import flash.geom.Point;

import net.flashpunk.FP;
import net.flashpunk.World;

public class PartitionExampleWorld extends World{

    private var i:int = 0;

    public function PartitionExampleWorld() {
        FP.screen.color = 0x000088;
        FP.console.enable();
        var p:Partition = new Partition();
        p.setValues(50,50,50);

        for (var j:int = 0; j < 3; j++) {
            for (var k:int = 0; k < 3; k++) {
                var t:PartitionExampleEntity = newP();
                p.setXYForRowCol(t,j, k, true);
                add(t);
            }
        }

        add(new PartitionGrid());

    }

    private function newP():PartitionExampleEntity{
        var pee:PartitionExampleEntity =  new PartitionExampleEntity();
        pee.centerOrigin();
        pee.image.centerOrigin();
        return pee;
    }
}
}
