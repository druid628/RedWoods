<?php

namespace tests\Unit;

use DruiD628\Utilities\CSVUtil;
use PHPUnit\Framework\TestCase;

class CSVUtilTest extends TestCase
{

    public function testSputCSV()
    {
        $rows = [
            ['firstName', 'lastName', 'jerseyNumber'],
            ['Sidney', 'Crosby', '87'],
            ['Evgeni', 'Malkin', '71'],
            ['Bill', 'Guerin', '13'],
            ['Matt', 'Cullen', '7'],
            ['Mario', 'Lemieux', '66'],
            ['Jaromir', 'Jagr', '68'],
        ];

        $csvString = '';

        foreach($rows as $row){
            $csvString .= CSVUtil::sputcsv($row, ',');
        }

        $output = "firstName,lastName,jerseyNumber
Sidney,Crosby,87
Evgeni,Malkin,71
Bill,Guerin,13
Matt,Cullen,7
Mario,Lemieux,66
Jaromir,Jagr,68
";
        $this->assertEquals($output, $csvString);

    }

    public function testSputCSVEOL()
    {
        $rows = [
            ['firstName', 'lastName', 'jerseyNumber'],
            ['Mario', 'Lemieux', '66'],
            ['Sidney', 'Crosby', '87'],
            ['Bill', 'Guerin', '13'],
        ];

        $csvString = '';

        foreach($rows as $row){
            $csvString .= CSVUtil::sputcsv($row, ',', '"', "<BR/>");
        }

        $output = "firstName,lastName,jerseyNumber<BR/>Mario,Lemieux,66<BR/>Sidney,Crosby,87<BR/>Bill,Guerin,13<BR/>";
        $this->assertEquals($output, $csvString);

    }
}
