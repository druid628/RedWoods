<?PHP

function __autoload($className)
{
    $filename = preg_replace("/\\\/", "" . DIRECTORY_SEPARATOR . "", $className);
    require_once(__DIR__ . "/src/" . $filename . ".php");
}


use druid628\campfires\traitdemo\App1;
use druid628\campfires\traitdemo\App2;

$mbA1   = new App1('mbreedlove');
$mbA2   = new App2('mbreedlove');
$kdubA2 = new App2('kwhite');


$token = $mbA2->getToken();

var_dump("App1: " . $mbA1->getUsername());
var_dump("App2: " . $mbA2->getUsername());
var_dump("token: " . $token);
var_dump("isValid: " . $mbA1->isValid($token));
var_dump("isValid: " . $mbA1->isValid($kdubA2->getToken()));

