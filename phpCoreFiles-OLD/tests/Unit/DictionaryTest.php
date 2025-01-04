<?php

namespace tests\Unit;

use DruiD628\Type\Dictionary628;
use PHPUnit\Framework\TestCase;

class DictionaryTest extends TestCase
{
    public function testCount()
    {
        $dictionary628 = new Dictionary628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertEquals('4', $dictionary628->count());
    }

    public function testValidationError()
    {
        $dictionary628 = new Dictionary628();
        try {
            $dictionary628->add(0.24, 'abc');
        }catch(\Exception $e) {
            $this->assertInstanceOf("DruiD628\Exceptions\InvalidKeyTypeException", $e);
            $this->assertEquals("Invalid Key type (double) for Dictionary", $e->getMessage());
        }
    }

    public function testGetSet()
    {
        $testData = [
            'z' => 'abc',
            'y' => 'bcd',
            'x' => 'cde',
            'w' => 'def',
        ];

        $dictionary628 = new Dictionary628($testData);

        $this->assertEquals(array_keys($testData), $dictionary628->getKeys());
        $this->assertEquals(array_values($testData), $dictionary628->getValues());

        $dictionary628->set('bye', 'adios');
        $this->assertEquals('adios', $dictionary628->get('bye'));

        $dictionary628->offsetSet('gloves', 'car');
        $this->assertEquals('car', $dictionary628->offsetGet('gloves'));

        $dictionary628->offsetSet('gloves', 'stuff');
        $this->assertEquals('stuff', $dictionary628->offsetGet('gloves'));

        $this->assertFalse( $dictionary628->offsetGet('thisKeyDoesntExist'));
    }

    public function testNext()
    {
        $dictionary628 = new Dictionary628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertEquals('abc', $dictionary628->current());
        $dictionary628->next();
        $this->assertEquals('bcd', $dictionary628->current());
    }

    public function testPrev()
    {
        $dictionary628 = new Dictionary628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertEquals('abc', $dictionary628->current());
        $dictionary628->next();
        $dictionary628->next();
        $this->assertEquals('cde', $dictionary628->current());
        $dictionary628->prev();
        $this->assertEquals('bcd', $dictionary628->current());

    }

    public function testCurrent()
    {
        $dictionary628 = new Dictionary628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $this->assertEquals('abc', $dictionary628->current());
    }

    public function testKey()
    {
        $dictionary628 = new Dictionary628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $dictionary628->next();
        $this->assertEquals(1, $dictionary628->key());
    }

    public function testsetData()
    {
        $arrayData = [
            'abc',
            'bcd',
            'cde',
            'def',
        ];

        $dictionary628 = new Dictionary628();
        $dictionary628->setData($arrayData);

        $this->assertEquals($arrayData, $dictionary628->getData());
    }

    public function testRewind()
    {
        $dictionary628 = new Dictionary628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);

        $dictionary628->next();
        $dictionary628->next();
        $dictionary628->next();
        $this->assertEquals(3, $dictionary628->key());
        $dictionary628->rewind();
        $this->assertEquals(0, $dictionary628->key());

    }

    public function testOffsets()
    {
        $dictionary628  = new Dictionary628([
            'abc',
            'bcd',
            'cde',
            'def',
        ]);
        $stuffAndThangs = 'stuff and thangs';
        $this->assertTrue($dictionary628->offsetExists(0));
        $this->assertFalse($dictionary628->offsetExists(25));
        $this->assertEquals('abc', $dictionary628->offsetGet(0));
        $dictionary628->offsetSet(25, $stuffAndThangs);
        $this->assertTrue($dictionary628->offsetExists(25));
        $this->assertEquals($stuffAndThangs, $dictionary628->offsetGet(25));
        $dictionary628->offsetUnset(25);
        $this->assertFalse($dictionary628->offsetExists(25));


        try {
            $dictionary628['doc'] = 'McStuffAndThangs';
        } catch (\Exception $e) {

            $this->assertInstanceOf('\DruiD628\Exceptions\InvalidKeyTypeException', $e);
            $this->assertEquals('Invalid Key type (string) for Array', $e->getMessage());
        }
    }

    public function testInterfaces()
    {
        $dictionary628 = new Dictionary628();
        $this->assertInstanceOf('\ArrayAccess', $dictionary628);
        $this->assertInstanceOf('\Iterator', $dictionary628);
        $this->assertInstanceOf('\DruiD628\Type\Base\Contracts\ArrayInterface', $dictionary628);
        $this->assertInstanceOf('\DruiD628\Type\Base\Contracts\DictionaryInterface', $dictionary628);
    }

    public function testArrayAccess()
    {
        $data          = [
            'abc',
            'bcd',
            'cde',
            'def',
        ];
        $dictionary628 = new Dictionary628($data);

        $this->assertEquals($data[2], $dictionary628[2]);
    }

    public function testTraversable()
    {
        $data          = [
            'abc',
            'bcd',
            'cde',
            'def',
        ];
        $dictionary628 = new Dictionary628($data);

        $this->assertInstanceOf('\Traversable', $dictionary628);
    }
}
