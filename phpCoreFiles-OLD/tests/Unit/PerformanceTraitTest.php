<?php

namespace tests\Unit;

use PHPUnit\Framework\TestCase;
use DruiD628\Traits\PerformanceTrait;

class MockPerfTraitClass
{
    use PerformanceTrait;

    public function generateRandomNumbers()
    {
            rand(1000, 9999999);
    }
}

class PerformanceTraitTest extends TestCase
{

    public function testGetPerformance()
    {
        $mock = new MockPerfTraitClass();

        $perfData = $mock->getPerformance();

        $this->assertContains('bytes', $perfData);
    }

    public function testGetLargerPerformance()
    {
        $mock = new MockPerfTraitClass();

        for( $i=0; $i>1001; $i++ ) {
            $mock->generateRandomNumbers();
        }

        $perfData = $mock->getPerformance();

        $this->assertContains('mega', $perfData);

    }


}