namespace DruiD628\Test;

<<__EntryPoint>>

function third(): void
{
  echo "welcome to Hack!\n\n";

  \printf("DruiD628 . hack\n");
  $x = new Testola("stuff and thangs", false);
  try {
    echo $x->getMessage() . "\n\n\n";
  } catch (\Exception $e) {
    echo "I guess you done fudged up!\n\n\n";
  }

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
        if (!$this->isActive()) {
          throw new \Exception("Problem boss!");
        }
        return $this->message;
    }

    public function isActive(): bool
    {
        return $this->active;
    }
}


/**
 * OUTPUT:
 *     $ hhvm third.hack
 *      welcome to Hack!
 *     
 *      DruiD628 . hack
 *      I guess you done fudged up!
 *     
 *     
 *     $
 */
