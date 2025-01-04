<?php

namespace tests\Unit;

use DruiD628\Type\Array628;
use PHPUnit\Framework\TestCase;

class ArrayTest extends TestCase
{
    public function testCount()
    {
        $array628 = new Array628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertEquals('4', $array628->count());
    }

    public function testImplode()
    {
        $array628 = new Array628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertInstanceOf('\DruiD628\Type\String628', $array628->implode(" "));
    }

    public function testNext()
    {
        $array628 = new Array628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertEquals('abc', $array628->current());
        $array628->next();
        $this->assertEquals('bcd', $array628->current());
    }

    public function testPrev()
    {
        $array628 = new Array628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertEquals('abc', $array628->current());
        $array628->next();
        $array628->next();
        $this->assertEquals('cde', $array628->current());
        $array628->prev();
        $this->assertEquals('bcd', $array628->current());

    }

    public function testCurrent()
    {
        $array628 = new Array628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertEquals('abc', $array628->current());
    }

    public function testKey()
    {
        $array628 = new Array628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $array628->next();
        $this->assertEquals(1, $array628->key());
    }

    public function testsetData()
    {
        $arrayData = [
            'abc',
            'bcd',
            'cde',
            'def',
        ];

        $array628 = new Array628();
        $array628->setData($arrayData);

        $this->assertEquals($arrayData, $array628->getData());
    }

    public function testRewind()
    {
        $array628 = new Array628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $array628->next();
        $array628->next();
        $array628->next();
        $this->assertEquals(3, $array628->key());
        $array628->rewind();
        $this->assertEquals(0, $array628->key());

    }

    public function testOffsets()
    {
        $array628       = new Array628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);
        $stuffAndThangs = 'stuff and thangs';
        $this->assertTrue($array628->offsetExists(0));
        $this->assertFalse($array628->offsetExists(25));
        $this->assertEquals('abc', $array628->offsetGet(0));
        $array628->offsetSet(25, $stuffAndThangs);
        $this->assertTrue($array628->offsetExists(25));
        $this->assertEquals($stuffAndThangs, $array628->offsetGet(25));
        $array628->offsetUnset(25);
        $this->assertFalse($array628->offsetExists(25));


        try {
            $array628['doc'] = 'McStuffAndThangs';
        }catch(\Exception $e) {

            $this->assertInstanceOf('\DruiD628\Exceptions\InvalidKeyTypeException', $e);
            $this->assertEquals('Invalid Key type (string) for Array', $e->getMessage());
        }
    }

    public function testInterfaces()
    {
        $array628 = new Array628();
        $this->assertInstanceOf('\ArrayAccess', $array628);
        $this->assertInstanceOf('\Iterator', $array628);
        $this->assertInstanceOf('\DruiD628\Type\Base\Contracts\ArrayInterface', $array628);
    }

    public function testPositiveStrictness()
    {
        $array628 = new Array628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertEquals('4', $array628->count());
        $this->assertTrue($array628->isStrict());
        try {
            $x = new Array628([
                'a' => 'abc',
                'b' => 'bcd',
                'c' => 'cde'
            ]);
        } catch (\Exception $e) {

            $this->assertInstanceOf('DruiD628\Exceptions\InvalidKeyTypeException', $e);
        }
    }

    public function testNegativeStrictness()
    {
        $array628 = new Array628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ], false);

        $this->assertEquals('4', $array628->count());
        $this->assertFalse($array628->isStrict());
    }

    public function testArrayAccess()
    {
        $data     = [
            'abc',
            'bcd',
            'cde',
            'def',
        ];
        $array628 = new Array628($data);

        $this->assertEquals($data[2], $array628[2]);
    }

    public function testTraversable()
    {
        $data     = [
            'abc',
            'bcd',
            'cde',
            'def',
        ];
        $array628 = new Array628($data);

        $this->assertInstanceOf('\Traversable', $array628);
    }
}
