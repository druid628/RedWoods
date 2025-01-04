namespace DruiD628\Test;

<<__EntryPoint>>

function second(): void
{
  echo "welcome to Hack!\n\n";

  \printf("DruiD628 . hack\n");
  $x = new Testola("stuff and thangs");
  echo $x->getMessage() . "\n\n\n";

  exit(0);
}

class Testola 
{
    public bool $active;

    public string $message;

    public function __construct(string $message, bool $active = true)
    {
      $this->active = $active;
      $this->message = $message;
    }

    public function setMessage(string $message): notreturn 
    {
      $this->message = $message;
    }

    public function getMessage(): string 
    {
        return $this->message;
    }
}


/**
 * OUTPUT:
 *     $ hhvm second.hack
 *     welcome to Hack!
 *
 *     DruiD628 . hack
 *     stuff and thangs
 *
 *
 *     $
 */
