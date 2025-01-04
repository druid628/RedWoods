<?php

namespace tests\Unit;

use DruiD628\Traits\MagicGetSetTrait;
use PHPUnit\Framework\TestCase;

/**
 * Class MockMagicGetSetTraitClass
 * @package tests\Unit
 * @method setJohn
 * @method getJohn
 * @method setCena
 * @method getCena
 * @method setYouCantSeeMe
 * @method getYouCantSeeMe
 */
class MockMagicGetSetTraitClass
{
    use MagicGetSetTrait;

    public $john;

    protected $cena;

    private $youCantSeeMe;

}

class MagicGetSetTraitTest extends TestCase
{
    public function testGetSet()
    {
        $mock         = new MockMagicGetSetTraitClass();
        $x            = 'asdf';
        $y            = 'xyzzy';
        $youCantSeeMe = '1qazxsw2';

        $mock->setJohn($x);
        $this->assertEquals($x, $mock->getJohn());

        $mock->setCena($y);
        $this->assertEquals($y, $mock->getCena());

        $mock->setYouCantSeeMe($youCantSeeMe);
        $this->assertEquals($youCantSeeMe, $mock->getYouCantSeeMe());
    }

    public function testSetExceptions()
    {
        $mock = new MockMagicGetSetTraitClass();

        $value = 'asdf';
        try {
            $mock->setIrish($value);
        } catch (\Exception $e) {
            $this->assertInstanceOf('\Exception', $e);
            $this->assertEquals('Variable (irish) Not Found', $e->getMessage());
        }

    }

    public function testGetExceptions()
    {
        $mock = new MockMagicGetSetTraitClass();

        try {
            $mock->getIrish();
        } catch (\Exception $e) {
            $this->assertInstanceOf('\Exception', $e);
            $this->assertEquals('Variable (irish) Not Found', $e->getMessage());
        }

    }

    public function testMethodNotFoundExceptions()
    {
        $mock = new MockMagicGetSetTraitClass();

        try {
            $mock->save();
        } catch (\Exception $e) {
            $this->assertInstanceOf('\Exception', $e);
            $this->assertEquals("No Method (save) exists on tests\Unit\MockMagicGetSetTraitClass", $e->getMessage());
        }

    }

//
}