namespace DruiD628\Test;

<<__EntryPoint>>
function fifth(): void{
  $boss = new Manager();
  $emp = new Employee();

  $dialog = "I need a day off";
  echo $emp->speak($dialog) . "\n";
  echo $boss->speak($dialog) . "\n\n";

  exit(0);
}

interface Human 
{
  public function speak(string $dialog);
}

abstract class Person implements Human
{
  public function speak(string $dialog)
  {
    return $dialog;
  }
}

class Employee extends Person
{
}

class Manager extends Person
{
  public function speak(string $dialog)
  {

    $newDialog = \explode(" ", \strrev($dialog));
    \shuffle(&$newDialog);
    $randKeys = \array_rand($newDialog);
    $newDialog[$randKeys] = \strrev($newDialog[$randKeys]);

    return \implode(" ", $newDialog);
  }
}


/**
 * OUTPUT:
 *
 *     $ hhvm fifth.hack
 *     I need a day off
 *     ffo day a I deen
 *
 *     $ hhvm fifth.hack
 *     I need a day off
 *     deen a yad ffo I
 *
 *     $
 */