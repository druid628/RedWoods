namespace Hack\GettingStarted\MyFirstProgram;

<<__EntryPoint>>
function first(): void{
  echo "Welcome to Hack!\n\n";

  \printf("Table of Squares\n" .
          "----------------\n");
  for ($i = -5; $i <= 5; ++$i) {
    \printf("  %2d        %2d  \n", $i, $i * $i);
  }
  \printf("----------------\n");
  exit(0);
}


/**
 * Taken from Hack site
 * OUTPUT:
 *     $ hhvm first.hack
 *     Welcome to Hack!
 *     
 *     Table of Squares
 *     ----------------
 *       -5        25
 *       -4        16
 *       -3         9
 *       -2         4
 *       -1         1
 *        0         0
 *        1         1
 *        2         4
 *        3         9
 *        4        16
 *        5        25
 *     ----------------
 *     $
 */
