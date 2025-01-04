<?php

namespace tests\Unit;

use PHPUnit\Framework\TestCase;
use DruiD628\Traits\ArrayTrait;

class MockArrayTraitClass
{
    use ArrayTrait;

    public $testArray = [
        ['asdf', 'bdef'],
        ['jkl;'],
        ['1qaz', 'xsw2'],
    ];

    public $sumArray = ['a' => '1', 'b' => '2', 'z' => '26'];
    public $sum2Array = [
        [
            'a' => 14,
            'b' => 42,
        ],
        [
            'a' => 4,
            'b' => 2,
        ],
    ];
}

class ArrayTraitTest extends TestCase
{

    public function testArraySumKey()
    {
        $mock = new MockArrayTraitClass();
        $sum = $mock->sumByKey($mock->sumArray);
        $this->assertEquals('29', $sum);

        $sum2 = $mock->sumByKey($mock->sum2Array, 'b');
        $this->assertEquals('44', $sum2);

        $sum3 = $mock->sumByKey(['a'], 'b');
        $this->assertEquals('0', $sum3);

        $sum4 = $mock->sumByKey('a', 'b');
        $this->assertEquals('0', $sum4);
    }

    public function testIsMulti()
    {
        $mock = new MockArrayTraitClass();

        $this->assertTrue($mock->isMulti($mock->testArray));
        $this->assertFalse($mock->isMulti($mock->sumArray));
    }
}