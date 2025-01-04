<?php

namespace tests\Unit;

use DruiD628\Type\HashTable628;
use PHPUnit\Framework\TestCase;

class HashTableTest extends TestCase
{

    public function testCount()
    {
        $hashtable628 = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);

        $this->assertEquals('4', $hashtable628->count());
    }

    public function testImplode()
    {
        $hashtable628 = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);

        $this->assertInstanceOf('\DruiD628\Type\String628', $hashtable628->implode(" "));
    }

    public function testNext()
    {
        $hashtable628 = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);

        $this->assertEquals('abc', $hashtable628->current());
        $hashtable628->next();
        $this->assertEquals('bcd', $hashtable628->current());
    }

    public function testPrev()
    {
        $hashtable628 = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);

        $this->assertEquals('abc', $hashtable628->current());
        $hashtable628->next();
        $hashtable628->next();
        $this->assertEquals('cde', $hashtable628->current());
        $hashtable628->prev();
        $this->assertEquals('bcd', $hashtable628->current());

    }

    public function testCurrent()
    {
        $hashtable628 = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);

        $this->assertEquals('abc', $hashtable628->current());
    }

    public function testKey()
    {
        $hashtable628 = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);

        $hashtable628->next();
        $this->assertEquals('b', $hashtable628->key());
    }

    public function testsetData()
    {
        $arrayData = [
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ];

        $hashtable628 = new HashTable628();
        $hashtable628->setData($arrayData);

        $this->assertEquals($arrayData, $hashtable628->getData());
    }

    public function testRewind()
    {
        $hashtable628 = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);

        $hashtable628->next();
        $hashtable628->next();
        $hashtable628->next();
        $this->assertEquals('d', $hashtable628->key());
        $hashtable628->rewind();
        $this->assertEquals('a', $hashtable628->key());

    }

    public function testOffsets()
    {
        $hashtable628   = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);
        $stuffAndThangs = 'stuff and thangs';
        $this->assertTrue($hashtable628->offsetExists('a'));
        $this->assertFalse($hashtable628->offsetExists('z'));
        $this->assertEquals('abc', $hashtable628->offsetGet('a'));
        $hashtable628->offsetSet('z', $stuffAndThangs);
        $this->assertTrue($hashtable628->offsetExists('z'));
        $this->assertEquals($stuffAndThangs, $hashtable628->offsetGet('z'));
        $hashtable628->offsetUnset('z');
        $this->assertFalse($hashtable628->offsetExists('z'));

        try {
           $hashtable628[529] = 'Doc McStuffAndThangs';
        }catch(\Exception $e) {

            $this->assertInstanceOf('\DruiD628\Exceptions\InvalidKeyTypeException', $e);
            $this->assertEquals('Invalid Key type (integer) for HashTable', $e->getMessage());
        }
    }

    public function testInterfaces()
    {
        $hashtable628 = new HashTable628();
        $this->assertInstanceOf('\ArrayAccess', $hashtable628);
        $this->assertInstanceOf('\Iterator', $hashtable628);
        $this->assertInstanceOf('\DruiD628\Type\Base\Contracts\HashTableInterface', $hashtable628);
    }

    public function testKeyValidation()
    {
        try {

            $hashtable628 = new HashTable628([
                0 => 'abc',
                1 => 'bcd',
                2 => 'cde',
                3 => 'def',
            ]);
        } catch (\Exception $e) {
            $this->assertInstanceOf('\DruiD628\Exceptions\InvalidKeyTypeException', $e);
        }

    }

    public function testAddGet()
    {
        $hashtable628 = new HashTable628([
            'one'   => 'abc',
            'two'   => 'bcd',
            'three' => 'cde',
            'four'  => 'def',
        ]);

        $key       = 'five';
        $value     = 'this Should Work';
        $testValue = $hashtable628->add($key, $value);


        $this->assertEquals($value, $hashtable628->get($key));
        $this->assertInstanceOf('DruiD628\Type\HashTable628', $testValue);
    }

    public function testReadOnly()
    {
        $hashtable628 = new HashTable628([
            'one'   => 'abc',
            'two'   => 'bcd',
            'three' => 'cde',
            'four'  => 'def',
        ], true);

        $key   = 'five';
        $value = "this Shouldn't Work";

        $this->assertFalse($hashtable628->add($key, $value));
        $hashtable628['six'] = 'asdf';
        $this->assertEquals('4', $hashtable628->count());
    }

    public function testGetKeys()
    {
        $hashtable628 = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);

        $this->assertEquals(['a', 'b', 'c', 'd'], $hashtable628->getKeys());
    }

    public function testGetValues()
    {
        $hashtable628 = new HashTable628([
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ]);

        $this->assertEquals(['abc', 'bcd', 'cde', 'def'], $hashtable628->getValues());
    }

    public function testArrayAccess()
    {
        $data      = [
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ];
        $hashTable = new HashTable628($data);

        $this->assertEquals($data['b'], $hashTable['b']);
    }

    public function testFixedSize()
    {
        $data = [
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ];

        $hashTable  = new HashTable628($data, false, 5);
        $hashTable2 = new HashTable628($data, false, true);

        // hashtable
        $this->assertTrue($hashTable->isFixedSize());
        $this->assertEquals(5, $hashTable->count());
        $this->assertEquals(0, $hashTable[4]);

        $hashTable->add('seven', "YOU KEELING ME");
        $this->assertFalse($hashTable['seven']);

        // hashtable2
        $this->assertEquals(4, $hashTable2->count());
        $this->assertFalse($hashTable[4]);

        $hashTable->add('seven', "YOU KEELING ME");
        $this->assertFalse($hashTable['seven']);
    }

    public function testFixedSizeTooBig()
    {
        $data = [
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ];

        try {

            $hashTable = new HashTable628($data, false, 2);

        } catch (\Exception $e) {

            $this->assertInstanceOf('\Exception', $e);
            $this->assertEquals('HashTable data size is larger than defined size', $e->getMessage());
        }
    }

    public function testLockSize()
    {
        $data = [
            'a' => 'abc',
            'b' => 'bcd',
            'c' => 'cde',
            'd' => 'def',
        ];

        $hashTable = new HashTable628($data);
        $hashTable->lockSize();

        $this->assertTrue($hashTable->isFixedSize());
        $this->assertEquals(4, $hashTable->count());
        $this->assertEquals(0, $hashTable[4]);

        $hashTable->add('seven', "YOU KEELING ME");
        $this->assertFalse($hashTable['seven']);
    }

    public function testTraversable()
    {
        $data     = [
            '2a' => 'abc',
            '2b' => 'bcd',
            '2c' => 'cde',
            '2d' => 'def',
        ];
        $array628 = new HashTable628($data);

        $this->assertInstanceOf('\Traversable', $array628);
    }
}
